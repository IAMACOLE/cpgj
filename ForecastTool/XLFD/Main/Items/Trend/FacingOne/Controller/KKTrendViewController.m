//
//  KKTrendViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/3/31.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKTrendViewController.h"

#import "KKTrendModel.h"
#import "KKTrend_roundCell.h"
#import "KKTrend_rectangularCell.h"

#import "KKTrend_historyViewController.h"
#import "KKTrendHeadView.h"



@interface KKTrendViewController ()
<
UITableViewDelegate,UITableViewDataSource,
KKTrend_roundCellDelegate,
KKTrend_rectangularCellDelegate
>

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (nonatomic, strong) KKTrendHeadView *headView;

@end

@implementation KKTrendViewController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.headView stopRollingAnimation];
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorking];
    [self getLotteryWinnings];
    [self initUI];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        cell.index = indexPath.section;
        cell.customDelegate = self;
        
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        cell.index = indexPath.section;
        cell.customDelegate = self;
        
        return cell;

    }
    
}

#pragma mark - CustomDelegate
- (void)KKTrend_roundCell_jumpWithIndex:(NSInteger)index {
    KKTrendModel * model = self.dataArrayM[index];
    KKTrend_historyViewController * history = [[KKTrend_historyViewController alloc] init];
    history.lottery_id = model.lottery_id;
    history.lottery_name = model.lottery_name;
    [self.navigationController pushViewController:history animated:YES];
}

- (void)KKTrend_rectangularCell_jumpWithIndex:(NSInteger)index {
    KKTrendModel * model = self.dataArrayM[index];
    KKTrend_historyViewController * history = [[KKTrend_historyViewController alloc] init];
    history.lottery_id = model.lottery_id;
    history.lottery_name = model.lottery_name;
    [self.navigationController pushViewController:history animated:YES];
}

#pragma mark - 点击事件
- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self sendNetWorking];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
 
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"cp/kj-trend"];
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
        [self.dataArrayM removeAllObjects];
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
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } dislike:^(id data) {
        [self.tableView.mj_header endRefreshing];

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self setIsShow404View:YES];
    }];
}

- (void)getLotteryWinnings{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"/cp/accumulated-winning"];
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
        [self.headView reloadDataWithNewNumberString:data[@"money"]];
    } dislike:^(id data) {
         
    } failure:^(NSError *error) {
         
    }];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"开奖信息";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 42, 30);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setImage:[UIImage imageNamed:@"icon-trend-noice"] forState:UIControlStateNormal];
    
    [btn setTitle:@"开奖推送" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -3, -2)];
    [btn addTarget:self action:@selector(noticeClick) forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}


#pragma mark - UI布局
- (void)initUI {
    [self addTableView];
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
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = self.headView;
        self.tableView.estimatedSectionFooterHeight = 5;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self sendNetWorking]; 
            [self getLotteryWinnings];
        }];
    } return _tableView;
}


- (KKTrendHeadView *)headView {
    if (_headView == nil) {
        self.headView = [[KKTrendHeadView alloc] init];
    
        self.headView.frame = CGRectMake(0, 0, MCScreenWidth, 64);
        self.headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}


- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

@end
