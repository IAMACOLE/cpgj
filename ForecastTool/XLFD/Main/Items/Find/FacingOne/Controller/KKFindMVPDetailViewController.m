//
//  KKFindMVPDetailViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/20.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindMVPDetailViewController.h"
#import "KKFollowTableViewCell.h"
#import "KKFindMVPDetailHeadView.h"
#import "KKMVPPeopleModel.h"
#import "KKFindModel.h"
#import "KKFindDetailViewController.h"
@interface KKFindMVPDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (assign, nonatomic) int page_no;
@property (assign, nonatomic) int page_size;
@property(nonatomic,strong)KKFindMVPDetailHeadView *headView;
@property(nonatomic,strong)KKMVPPeopleModel *infoModel;
@end

@implementation KKFindMVPDetailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //刷新用户信息
    if (self.dataArrayM.count > 0) {
        [self sendNetWorking];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];

}

- (void)basicSetting {
    self.titleString = self.model.nick_name;
    self.page_no = 1;
    self.page_size = 20;
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
-(void)sendNetWorking {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-others-gd"];
    
    NSDictionary * parameter = @{
                                 @"user_flag":self.model.user_flag,
                                 @"page_no" : @(self.page_no),
                                 @"page_size" : @(self.page_size),
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
       
        NSArray * dataArray = (NSArray *)[data objectForKey:@"gd_list"];
        
        if (self.page_no != 1) {
            [self.dataArrayM addObjectsFromArray:[KKMyFollowModel arrayOfModelsFromDictionaries:dataArray error:nil]];
            
            
            if (dataArray.count < self.page_size) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
           
        }else{
            
            self.infoModel = [[KKMVPPeopleModel alloc] initWithDictionary:[data objectForKey:@"ds_info"] error:nil];
            UIView *tableHeadView = [[UIView alloc] init];
            tableHeadView.frame = CGRectMake(0, 0, MCScreenWidth, self.headView.frame.size.height + 4);
            tableHeadView.backgroundColor = [UIColor clearColor];
            [tableHeadView addSubview:self.headView];
            self.tableView.tableHeaderView = tableHeadView;
            [self.headView buildWithData:self.infoModel];
            
            UIView *boomView = [[UIView alloc] init];
            boomView.backgroundColor = MCUIColorFromRGB(0xDFCFC7);
            boomView.frame = CGRectMake(0, self.headView.frame.size.height, MCScreenWidth, 4);
            [tableHeadView addSubview:boomView];
            
            
            self.dataArrayM = [KKMyFollowModel arrayOfModelsFromDictionaries:dataArray error:nil];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
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

-(void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self setIsShow404View:NO];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark -  UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKFollowTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    KKMyFollowModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    
    //cell.model = self.dataArrayM[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KKFindModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    
    KKFindDetailViewController *viewController = [[KKFindDetailViewController alloc] init];
    viewController.model =  model;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArrayM count];
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.rowHeight = 135;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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

- (KKFindMVPDetailHeadView *)headView {
    if (_headView == nil) {
        _headView = [[KKFindMVPDetailHeadView alloc] init];
//        _headView.delegate = self;
        _headView.backgroundColor = [UIColor clearColor];
        _headView.frame = CGRectMake(0, 0, MCScreenWidth, 75 + 10);

    } return _headView;
}


-(void)didClickAttention:(KKFindDetailHeadView *)view {
    if([MCTool BSJudge_userIsLoginWith:self]){
        //        user_token    true
        //        user_flag    true    对方用户名    test
        //        status    true    1关注2取消关注
        
        //has_gz    是否关注(0未关注1已关注3隐藏关注按钮)，登录状态下返回
        NSInteger status;
        KKMVPPeopleModel *model = self.infoModel;
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
                
                model.has_gz = [[NSNumber alloc] initWithInt:1];
                model.count_fans++;
            }else {
                model.has_gz = [[NSNumber alloc] initWithInt:0];;
                model.count_fans--;
            }
            [self.headView buildWithData:model];
     
        } dislike:^(id data) {
          
        } failure:^(NSError *error) {
           
        }];
    }
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}


@end
