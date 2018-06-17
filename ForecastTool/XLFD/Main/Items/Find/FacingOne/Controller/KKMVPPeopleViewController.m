//
//  KKFindMVPPeopleViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMVPPeopleViewController.h"
#import "KKMVPPeopleTabelViewCell.h"
#import "KKMVPPeopleModel.h"
#import "KKFindMVPDetailViewController.h"
@interface KKMVPPeopleViewController () <UITableViewDelegate,UITableViewDataSource,KKMVPPeopleTabelViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(assign,nonatomic)NSInteger page_no;
@property(assign,nonatomic)NSInteger order_by;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (nonatomic, strong)UIImageView *tableViewBg;

@end

@implementation KKMVPPeopleViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self basicSetting];
    [self initUI];
}
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"大神榜";
    self.page_no = 1;
    self.order_by = 1;
    self.bgImageView.image = [UIImage imageNamed:@"bgImageView_Image3"];
}
-(void)initUI {
    
    [self.view addSubview:self.tableViewBg];
    [self.tableViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(MCScreenWidth * 0.75);
        make.top.mas_equalTo(30);
        make.bottom.mas_equalTo(-60);
    }];
    [self.tableView.mj_header beginRefreshing];
    
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorColor = MCUIColorFromRGB(0xBFB8A1);
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.rowHeight = 65;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self sendNetWorking];
        }];
        self.tableView.tableFooterView = [UIView new];
    } return _tableView;
}
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

#pragma mark -  UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDcell = @"cell";
    KKMVPPeopleTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKMVPPeopleTabelViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     KKMVPPeopleModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    cell.row = indexPath.row;
    [cell buildWithData:model];
    cell.delegate = self;
    cell.isShowRanking = YES;
    cell.backgroundColor = [UIColor clearColor];
    //cell.model = self.dataArrayM[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KKMVPPeopleModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    KKFindMVPDetailViewController *viewController = [[KKFindMVPDetailViewController alloc] init];
    viewController.model = model;
    [self.navigationController pushViewController:viewController animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArrayM count];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-dsb-rank"];
    NSDictionary * parameter = @{
                                 @"status":@(1),
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
            if(model.has_gz.integerValue == 0) {
                model.has_gz = [[NSNumber alloc] initWithInt:1];;
                model.count_fans++;
            }else {
                model.has_gz = [[NSNumber alloc] initWithInt:0];;
                 model.count_fans--;
            }
            
            
            [self.dataArrayM replaceObjectAtIndex:row withObject:model];
            [self.tableView reloadData];
        } dislike:^(id data) {
           
            
        } failure:^(NSError *error) {
          
        }];
    }
}

-(UIImageView *)tableViewBg{
    if(_tableViewBg == nil){
        _tableViewBg = [UIImageView new];
        _tableViewBg.image = [UIImage imageNamed:@"find-starsList-bg2"];
    }
    return _tableViewBg;
}

@end
