//
//  KKBetRecordViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBetRecordViewController.h"

#import "KKBetRecordModel.h"
#import "KKBetRecordCell.h"
#import "KKBetRecordToolTipView.h"

#import "KKBetDetailViewController.h"

@interface KKBetRecordViewController ()
<
UITableViewDelegate,UITableViewDataSource,
KKBetRecordToolTipViewDelegate
>
{
    NSInteger _pageNumber;
    NSInteger _data_type;   // 1:当天 2:最近三天 3:最近一周 4:最近一月 如果不传，默认为1
    NSString * _status;      // 投注订单的状态 0:全部   1：未开奖    2：未中奖 3：撤销  4：中奖    5：异常  6：追号
    NSInteger _lastButtonIndex;
}


@property (nonatomic, strong) UIButton * navTitleButton;

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;

@property (nonatomic, strong) KKBetRecordToolTipView * toopLipView;


@end

@implementation KKBetRecordViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    KKBetRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKBetRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArrayM[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    KKBetRecordModel * model = self.dataArrayM[indexPath.row];
    KKBetDetailViewController * betDetail = [[KKBetDetailViewController alloc] init];
    betDetail.order_number = model.order_number;
    [self.navigationController pushViewController:betDetail animated:YES];
 
}

#pragma mark - CustomDelegate
- (void)KKBetRecordToolTipViewMethod_closeView {
    self.navTitleButton.selected = NO;
}

- (void)KKBetRecordToolTipViewMethod_selectedItem:(NSString *)statusStr andIndex:(NSInteger)index {
    _pageNumber = 1;
    _status = statusStr;
    _lastButtonIndex = index;
    self.navTitleButton.selected = NO;
    
    [self.dataArrayM removeAllObjects];
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
}

#pragma mark - 点击事件

- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.dataArrayM removeAllObjects];
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
}

- (void)rightItemClicked {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *other_oneAction = [UIAlertAction actionWithTitle:@"今天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 1;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
    }];
    UIAlertAction *other_twoAction = [UIAlertAction actionWithTitle:@"最近三天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 2;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
    }];
    UIAlertAction *other_threeAction = [UIAlertAction actionWithTitle:@"最近一周" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 3;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
    }];
    UIAlertAction *other_fourAction = [UIAlertAction actionWithTitle:@"最近一月" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 4;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:other_oneAction];
    [alertController addAction:other_twoAction];
    [alertController addAction:other_threeAction];
    [alertController addAction:other_fourAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)navTitleButtonClicked {
    self.navTitleButton.selected = !self.navTitleButton.isSelected;
    
    if (self.navTitleButton.isSelected == YES) {
        [self.toopLipView removeFromSuperview];
        self.toopLipView = nil;
		[self.view addSubview:self.toopLipView];
        [self.toopLipView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(self.view);
        }];
        self.toopLipView.index = _lastButtonIndex;
    } else {
        [self.toopLipView removeFromSuperview];
        self.toopLipView = nil;
    }
}

#pragma mark - 网络请求
- (void)sendNetWorkingWithPageNumber:(NSInteger)pageNumber andData_type:(NSInteger)type andStatus:(NSString *)status {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"bet/bet-list"];
    
    NSDictionary * parameter;
    
    if (status.length == 0) {
       parameter = @{
                     @"page_no" : @(pageNumber),
                     @"page_size" : @"10",
                     @"data_type" : @(type)
                     };
    } else {
        parameter = @{
                      @"status" : status,
                      @"page_no" : @(pageNumber),
                      @"page_size" : @"10",
                      @"data_type" : @(type)
                      };
    }
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        
        [self setIsShow404View:NO];
        
        NSArray * dataArray = (NSArray *)data;
        if (dataArray.count == 0 && self.dataArrayM.count == 0) {
            self.isShowEmptyView = YES;
        } else {
            [self setIsShowEmptyView:NO];
            if (pageNumber == 1) {
                [self.dataArrayM removeAllObjects];
            }
            self.isShowEmptyView = NO;
            for (NSDictionary * dict in data) {
                KKBetRecordModel * model = [[KKBetRecordModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArrayM addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
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
//    self.view.backgroundColor = MCUIColorLightGray;
    
    [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(21, 18) target:self selected:@selector(rightItemClicked) image:@"Mine_accountDetail_more" isLeft:NO];
    _pageNumber = 1;
    _data_type = 4;
    _status = @"";
    self.navigationItem.titleView = self.navTitleButton;
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - setter & getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.backgroundColor = MCMineTableCellBgColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNumber = 1;
            [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNumber ++;
            [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type andStatus:_status];
        }];
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

- (UIButton *)navTitleButton {
    if (_navTitleButton == nil) {
        self.navTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.navTitleButton.titleLabel.font = MCFont(18);
        self.navTitleButton.frame = CGRectMake(0, 0, 123, 30);
        [self.navTitleButton setTitle:@"投注记录" forState:UIControlStateNormal];
        [self.navTitleButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.navTitleButton setImage:[UIImage imageNamed:@"Reuse_arrow_bottom"] forState:UIControlStateNormal];
        [self.navTitleButton setImage:[UIImage imageNamed:@"Reuse_arrow_top"] forState:UIControlStateSelected];
		_navTitleButton.adjustsImageWhenHighlighted = false;
        [self.navTitleButton addTarget:self action:@selector(navTitleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.navTitleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, 10)];
        [self.navTitleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 33)];
    } return _navTitleButton;
}

- (KKBetRecordToolTipView *)toopLipView {
    if (_toopLipView == nil) {
        self.toopLipView = [[KKBetRecordToolTipView alloc] init];
        self.toopLipView.backgroundColor = [UIColor clearColor];
        self.toopLipView.customDelegate = self;
    } return _toopLipView;
}

@end
