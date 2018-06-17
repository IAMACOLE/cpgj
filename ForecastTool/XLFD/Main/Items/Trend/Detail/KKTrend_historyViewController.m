//
//  KKTrend_historyViewController.m
//  Kingkong_ios
//
//  Created by goulela on 2017/6/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKTrend_historyViewController.h"

#import "KKTrendModel.h"

#import "KKTrend_roundCell.h"
#import "KKTrend_rectangularCell.h"

@interface KKTrend_historyViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    NSInteger _pageNumber;
}
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;

@end

@implementation KKTrend_historyViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];

    [self addTableView];
    
    [self sendNetWorkingWithPageNumber:_pageNumber];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKTrendModel * model = self.dataArrayM[indexPath.section];
    NSString * show_type = model.show_type;
    
    if ([show_type isEqualToString:@"4"]) { // 绿色矩形
        static NSString * identifier = @"KKTrend_rectangularCell";
        KKTrend_rectangularCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[KKTrend_rectangularCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView* subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        cell.isHideArrowView = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.model = model;
        return cell;
        
    } else {  // 圆
        static NSString * identifier = @"roundcell";
        KKTrend_roundCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[KKTrend_roundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView* subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        cell.isHideArrowView = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.model = model;
        return cell;

    }
}
#pragma mark - 点击事件
- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.dataArrayM removeAllObjects];
    [self sendNetWorkingWithPageNumber:_pageNumber];
}

#pragma mark - 网络请求
- (void)sendNetWorkingWithPageNumber:(NSInteger)pageNumber {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"cp/kj-trend-history"];
    
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 @"page_no"    : @(pageNumber),
                                 @"page_size"  : @"10"
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        
        if (pageNumber == 1) {
            [self.dataArrayM removeAllObjects];
        }
        
        [self setIsShow404View:NO];
        NSArray * dataArray = (NSArray *)data;
        if (dataArray.count == 0 && self.dataArrayM.count == 0) {
            [self setIsShowEmptyView:YES];
        } else {
            [self setIsShowEmptyView:NO];
            for (NSDictionary * dict in data) {
                KKTrendModel * model = [[KKTrendModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArrayM addObject:model];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self setIsShow404View:YES];
    }];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = self.lottery_name;
    _pageNumber = 1;

    
}

- (void)addTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.estimatedSectionFooterHeight = 10;
        self.tableView.backgroundColor = [UIColor clearColor];
        UIView *headerView = [UIView new];
        headerView.frame = CGRectMake(0, 0, MCScreenWidth, 10);
        self.tableView.tableHeaderView = headerView;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNumber = 1;
            [self sendNetWorkingWithPageNumber:_pageNumber];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNumber ++;
            [self sendNetWorkingWithPageNumber:_pageNumber];
        }];
        
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

@end

