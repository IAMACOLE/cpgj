//
//  KKFindViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindViewController.h"
#import "KKFindHeadView.h"
#import "KKFindMVPView.h"
#import "KKFindTableViewCell.h"
#import "KKFindSortView.h"
#import "KKMVPPeopleViewController.h"
#import "KKFollowViewController.h"
#import "KKFindDetailViewController.h"
#import "KKTrendViewController.h"
#import "KKMVPPeopleModel.h"
#import "KKFindMVPDetailViewController.h"
#import "KKFindModel.h"


#import "KKFindSortViewController.h"
@interface KKFindViewController ()<UITableViewDelegate,UITableViewDataSource,KKFindTableViewCellDelegate,KKFindMVPViewDelegate,KKFindHeadViewDelegate,KKFindSortViewDelegate,KKLotterySortViewDelegate>
@property(nonatomic,strong)KKFindHeadView *headView;
@property(nonatomic,strong)KKFindMVPView *mvpView;
@property(nonatomic,strong)KKFindSortView *sortView;
@property(assign,nonatomic)BOOL isSort;
@property(assign,nonatomic)NSInteger page_no;
@property(assign,nonatomic)NSInteger page_size;
@property(assign,nonatomic)NSInteger order_by;
@property(assign,nonatomic)BOOL isAutoRefresh;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (nonatomic, strong) NSMutableArray * peopleArrayM;
@property (nonatomic, strong) MCEmptyDataView *empty2View;
@property (nonatomic, strong)NSString *lottery_id;
@end

@implementation KKFindViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self numberUnreadMessages];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    [self initUI];
    
}

#pragma mark - UI布局
- (void)initUI {
    
    self.view.backgroundColor = MCUIColorFromRGB(0xF4F4F4);
    
    UIView *tableHeadView = [[UIView alloc] init];
    
    tableHeadView.backgroundColor = [UIColor clearColor];
    tableHeadView.frame = CGRectMake(0, 0, MCScreenWidth, [self.headView heightFowView] + [self.mvpView heightFowView]);
    
    [tableHeadView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo([self.headView heightFowView]);
    }];
    
    [tableHeadView addSubview:self.mvpView];
    
    self.mvpView.delegate = self;
    [self.mvpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(0);
        make.height.mas_equalTo([self.mvpView heightFowView]);
    }];
    self.tableView.tableHeaderView = tableHeadView;
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
    }];
    
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"发现";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = self.customLeftItem;
    self.page_no = 1;
    self.page_size = 10;
    self.isSort = NO;
    self.order_by = -1;
    self.lottery_id = @"";
    self.isAutoRefresh = YES;
    self.navigationItem.rightBarButtonItem = self.noticeButtonItem;
    self.bgImageView.image = [UIImage imageNamed:@"bgImageView_Image1"];
     //[MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(23, 23) target:self selected:@selector(doubtClick) image:@"icon-buttonitem-wenhao" isLeft:NO];

}

-(void) doubtClick{

    NSString *gd_helper_url = [MCTool BSGetObjectForKey:BSConfig_gd_helper_url];
    
    if (![gd_helper_url isEqualToString:@""]) {
        MCH5ViewController * h5 = [[MCH5ViewController alloc] init];
        h5.url = gd_helper_url;
        [self.navigationController pushViewController:h5 animated:YES];
    }
}


#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-all-gd"];
    NSMutableDictionary * parameter = [NSMutableDictionary dictionaryWithDictionary:@{
                  @"page_no" : @(_page_no),
                  @"page_size" : @(self.page_size),
                  }];

    if (self.isAutoRefresh == NO) {
        if (self.order_by != -1) {
            [parameter addEntriesFromDictionary:@{ @"order_by": @(_order_by),}];
        }
        
        if (![self.lottery_id isEqualToString:@""]) {
            [parameter addEntriesFromDictionary:@{ @"lottery_id": self.lottery_id,}];
        }
    }

    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
        [self setIsShowEmptyView:NO];
        
        [self.empty2View removeFromSuperview];
        NSArray * dataArray = (NSArray *)data;
        
        //显示占位图
        if ((dataArray.count == 0 && self.dataArrayM.count == 0) || ( self.page_no == 1 && dataArray.count == 0 )) {
            
            [self.tableView addSubview:self.empty2View];
            self.empty2View.frame = CGRectMake(0, self.tableView.tableHeaderView.frame.size.height + 40, MCScreenWidth, MCScreenHeight - self.tableView.tableHeaderView.frame.size.height-64 - 100);
            [self.empty2View.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
            }];
            
        }
        
        if (self.page_no != 1) {
            [self.dataArrayM addObjectsFromArray:[KKFindModel arrayOfModelsFromDictionaries:dataArray error:nil]];
            
            if (dataArray.count < self.page_size) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
        }else{
        
            //是用户主动下拉刷新的情况下重置刷新条件
            if (self.isAutoRefresh == YES) {
                self.order_by = -1;
                [self.sortView.allButton setTitle:@"全部彩种" forState: UIControlStateNormal];
            }
             self.dataArrayM = [KKFindModel arrayOfModelsFromDictionaries:dataArray error:nil];
             [self.tableView.mj_header endRefreshing];
             [self.tableView.mj_footer endRefreshing];
        }
        
        self.isAutoRefresh = YES;
        [self.tableView reloadData];
        
    } dislike:^(id data) {
        [self setIsShow404View:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        if (self.page_no == 1) {
            [self setIsShow404View:YES];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self setIsShow404View:NO];
    [self.tableView.mj_header beginRefreshing];
}

- (void)sendNet2Working {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-dsb-rank"];
    NSDictionary * parameter = @{
                                 @"page_no" : @(1),
                                 @"page_size" : @(5),
                                 @"order_by": @(1)
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:FALSE isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
        self.peopleArrayM = [KKMVPPeopleModel arrayOfModelsFromDictionaries:data error:nil];
        [self.mvpView buildWithData:self.peopleArrayM];
    } dislike:^(id data) {
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -  UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKFindTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.row = indexPath.row;
    KKFindModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKFindModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    KKFindDetailViewController *viewController = [[KKFindDetailViewController alloc] init];
    viewController.model = model;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sortView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 27;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArrayM count];
}

-(void)didSelectFollowAtIndex:(KKFindTableViewCell *)view atIndex:(NSInteger)index {
    
    if([MCTool BSJudge_userIsLoginWith:self]) {
        KKFindModel *model = [self.dataArrayM objectAtIndex:index];
        
        NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/bet/bet-gd"];
        NSDictionary * parameter = @{
                                     @"gd_number" : model.gd_number,
                                     @"gd_money" : @(model.user_pay_money),
                                     };
        [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:FALSE isShowTabbar:YES success:^(id data) {
            
            [MCView BSAlertController_oneOption_viewController:self message:@"跟单成功" cancle:^{
                
            }];
            
        } dislike:^(id data) {
            
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}

-(void)didClickMvpPeople:(KKFindMVPView *)view index:(NSInteger)index {
    KKMVPPeopleModel *model = [self.peopleArrayM objectAtIndex:index];
    KKFindMVPDetailViewController *viewController = [[KKFindMVPDetailViewController alloc] init];
    
    viewController.model = model;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)didClickLottery:(KKFindSortViewController *)view lottery_id:(NSString *)lottery_id lottery_title:(NSString *)lottery_title {
    self.lottery_id = lottery_id;
    [self.sortView.allButton setTitle:lottery_title forState:UIControlStateNormal];
    self.isAutoRefresh = NO;
    [self.tableView.mj_header beginRefreshing];
}

-(void)didClickAll:(KKFindSortViewController *)view {
    self.lottery_id = @"";

    [self.sortView.allButton setTitle:@"全部彩种" forState:UIControlStateNormal];
    self.isAutoRefresh = NO;
    [self.tableView.mj_header beginRefreshing];

}

-(void)didClickLookMore:(KKFindMVPView *)view {
    KKMVPPeopleViewController *viewController = [[KKMVPPeopleViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)didClickMpv:(KKFindHeadView *)view {
    KKMVPPeopleViewController *viewController = [[KKMVPPeopleViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)didClickFollow:(KKFindHeadView *)view {
    KKFollowViewController *viewController = [[KKFollowViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)didClickLottery:(KKFindHeadView *)view {
    
    KKTrendViewController *viewController = [[KKTrendViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)didClickSortAll:(KKFindSortView *)view {

    //[self getCpTpyeNetWorking];
    KKFindSortViewController *vc = [[KKFindSortViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickSortBrokerage:(KKFindSortView *)view {
    self.order_by = 1;
    self.isAutoRefresh = NO;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - setter & getter
- (KKFindHeadView *)headView {
    if (_headView == nil) {
        _headView = [[KKFindHeadView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.delegate = self;
    }
    return _headView;
}

- (KKFindMVPView *)mvpView {
    if (_mvpView == nil) {
        _mvpView = [[KKFindMVPView alloc] init];
        _mvpView.backgroundColor = [UIColor clearColor];
    }
    return _mvpView;
}
-(KKFindSortView *)sortView {
    if (_sortView == nil) {
        _sortView = [[KKFindSortView alloc] init];
        _sortView.backgroundColor = [UIColor clearColor];
        _sortView.delegate = self;
    }
    return _sortView;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = 150;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self sendNet2Working];
            self.page_no  = 1;
//            [self.dataArrayM removeAllObjects];
            [self sendNetWorking];
        }];
        

        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
             self.page_no++;
             [self sendNetWorking];
        }];
        
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

- (MCEmptyDataView *)empty2View {
    if (_empty2View == nil) {
        self.empty2View = [[MCEmptyDataView alloc] initWithFrame:CGRectZero];
        self.empty2View.imageView.image = [UIImage imageNamed:@"Reuse_empty"];
        [self.empty2View.label setHidden:YES];
    } return _empty2View;
}


- (NSMutableArray *)peopleArrayM {
    if (_peopleArrayM== nil) {
        _peopleArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _peopleArrayM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
