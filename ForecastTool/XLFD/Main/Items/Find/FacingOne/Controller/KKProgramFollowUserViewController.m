//
//  KKProgramFollowUserViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramFollowUserViewController.h"
#import "KKProgramFollowUserHeadView.h"
#import "KKProgramFollowUserTableViewCell.h"
#import "KKGDUserModel.h"
@interface KKProgramFollowUserViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)  KKProgramFollowUserHeadView *headView;
@end

@implementation KKProgramFollowUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initUI];
}

-(void)initUI {
    
    self.page = 1;
    self.pageSize = 20;
    

  
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gdUserModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKProgramFollowUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKProgramFollowUserTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        // cell.delegate = self;

        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.row = indexPath.row;
    KKGDUserModel *model = [self.gdUserModelArray objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    return cell;
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-gd-detail"];
    
    NSDictionary * parameter = @{
                                 @"page_no":@(self.page),
                                 @"page_size":@(self.pageSize),
                                 @"user_flag" : self.findModel.user_flag,
                                 @"gd_number" : self.findModel.gd_number,
                                 };
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
       
        //self.gdUserModelArray = [KKGDUserModel arrayOfModelsFromDictionaries:[data objectForKey:@"gd_user"] error:nil];
        
        NSArray * dataArray = (NSArray *)[data objectForKey:@"gd_user"];
       
        if (self.page != 1) {
            [self.gdUserModelArray addObjectsFromArray:[KKGDUserModel arrayOfModelsFromDictionaries:dataArray error:nil]];
            
            if (dataArray.count < self.pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }else{
            if (dataArray.count == 0) {
                [self setIsShowEmptyView:YES];
            }
            self.gdUserModelArray = [KKGDUserModel arrayOfModelsFromDictionaries:dataArray error:nil];
           // [self.tableView.mj_header endRefreshing];
            
            [self.tableView.mj_footer endRefreshing];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            ///
             [self.tableView reloadData];
        });
    
        
    } dislike:^(id data) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.rowHeight = 22;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        //_tableView.scrollEnabled = NO;
         _tableView.backgroundColor = [UIColor clearColor];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page++;
            [self sendNetWorking];
        }];
    }
    return _tableView;
}

-(KKProgramFollowUserHeadView *)headView {
    if(_headView == nil) {
        _headView = [[KKProgramFollowUserHeadView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.frame = CGRectMake(15, 0, MCScreenWidth-30, 24);
    }
    
    return _headView;
}

-(NSMutableArray *)gdUserModelArray {
    if (_gdUserModelArray == nil) {
        _gdUserModelArray = [[NSMutableArray alloc] init];
    }
    return _gdUserModelArray;
}



@end
