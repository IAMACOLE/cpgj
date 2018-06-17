//
//  KKMyMVPPeopleViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMyMVPPeopleViewController.h"
#import "KKMVPPeopleTabelViewCell.h"
#import "KKMVPPeopleModel.h"
#import "KKFindMVPDetailViewController.h"
@interface KKMyMVPPeopleViewController () <UITableViewDelegate,UITableViewDataSource,KKMVPPeopleTabelViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(assign,nonatomic)NSInteger page_no;
@property(assign,nonatomic)NSInteger order_by;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@end

@implementation KKMyMVPPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self basicSetting];
    [self initUI];
}
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"我的关注";
    self.page_no = 1;
    self.order_by = 1;
    
}
-(void)initUI {

    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = MCMineTableViewBgColor;;
        self.tableView.rowHeight = 81;
        self.tableView.estimatedSectionHeaderHeight = 2;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self.dataArrayM removeAllObjects];
            [self sendNetWorking];
        }];
    } return _tableView;
}
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, MCScreenWidth, 2);
    headerView.backgroundColor = MCUIColorLighttingBrown;
    return headerView;
}

#pragma mark -  UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDcell = @"cell";
    KKMVPPeopleTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKMVPPeopleTabelViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    KKMVPPeopleModel *model = [self.dataArrayM objectAtIndex:indexPath.section];
    cell.row = indexPath.section;
    [cell buildWithData:model];
    cell.delegate = self;
    cell.isShowRanking = NO;
    cell.backgroundColor = MCMineTableCellBgColor;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KKMVPPeopleModel *model = [self.dataArrayM objectAtIndex:indexPath.section];
    KKFindMVPDetailViewController *viewController = [[KKFindMVPDetailViewController alloc] init];
    viewController.model = model;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArrayM count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/my-gz"];
    NSDictionary * parameter = @{
                                 @"page_no" : @(_page_no),
                                 @"page_size" : @(100),
                                 @"order_by": @(_order_by)
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
        
        NSArray * dataArray = (NSArray *)data;
        if (dataArray.count == 0 && self.dataArrayM.count == 0) {
            [self setIsShowEmptyView:YES];
        } else {
            [self setIsShowEmptyView:NO];
            self.dataArrayM = [KKMVPPeopleModel arrayOfModelsFromDictionaries:data error:nil];
            
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } dislike:^(id data) {
        [self.tableView.mj_header endRefreshing];
        [self setIsShow404View:YES];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self setIsShow404View:YES];
    }];
}

-(void)didClickAttention:(KKMVPPeopleTabelViewCell *)view row:(NSInteger)row {
    
    if([MCTool BSJudge_userIsLoginWith:self]){
        
        KKMVPPeopleModel *model = [self.dataArrayM objectAtIndex:row];
        
        //        user_token    true
        //        user_flag    true    对方用户名    test
        //        status    true    1关注2取消关注
        
        //has_gz    是否关注(0未关注1已关注3隐藏关注按钮)，登录状态下返回
        NSInteger status;
        
        if(model.has_gz.integerValue == 0) {
            status = 1;
        }else {
            status = 2;
        }
        
        
        NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/gz"];
        NSDictionary * parameter = @{
                                     @"status" : @(status),
                                     @"user_flag" : model.user_flag
                                     };
        [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
//            if(model.has_gz.integerValue == 0) {
//
//                model.has_gz = [[NSNumber alloc] initWithInt:1];
//                model.count_fans++;
//            }else {
//                model.has_gz = [[NSNumber alloc] initWithInt:0];;
//                model.count_fans--;
//            }
            [self.dataArrayM removeObject:model];
            
            //[self.dataArrayM replaceObjectAtIndex:row withObject:model];
            if(self.dataArrayM.count == 0) {
                [self setIsShowEmptyView:YES];
            }
            
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
    
}

-(void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self setIsShow404View:NO];
    [self.tableView.mj_header beginRefreshing];
}



@end
