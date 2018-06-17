//
//  KKMyInvolvedFollowViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMyInvolvedFollowViewController.h"
#import "KKFollowTableViewCell.h"
#import "KKMyFollowModel.h"
#import "KKFindDetailViewController.h"
@interface KKMyInvolvedFollowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (assign, nonatomic) int page_no;
@property (assign, nonatomic) int page_size;
@end

@implementation KKMyInvolvedFollowViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.dataArrayM.count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}
#pragma mark - UI布局
- (void)initUI {
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
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


#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.page_no = 1;
    self.page_size = 20;
//    
//    self.emptyView.imageView.image = [UIImage imageNamed:@"Reuse_empty"];
//    self.emptyView.backgroundColor = MCUIColorFromRGB(0xF4F4F4);
    self.emptyView.imageView.contentMode = UIViewContentModeCenter;
    [self.emptyView.label setHidden:YES];
}



#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-myjoin-gd"];

    NSDictionary * parameter = @{
                                 @"page_no" : @(self.page_no),
                                 @"page_size" : @(self.page_size),
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
     [self setIsShow404View:NO];
     
    

        NSArray * dataArray = (NSArray *)data;
        
       
        
        if (self.page_no != 1) {
            [self.dataArrayM addObjectsFromArray:[KKMyFollowModel arrayOfModelsFromDictionaries:dataArray error:nil]];
            if (dataArray.count < self.page_size) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }else{
            if (dataArray.count == 0) {
                [self setIsShowEmptyView:YES];
            }
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

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

@end
