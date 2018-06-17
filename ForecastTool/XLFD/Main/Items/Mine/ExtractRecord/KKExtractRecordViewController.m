//
//  KKExtractRecordViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKExtractRecordViewController.h"

#import "KKAccountDetailModel.h"
#import "KKExtractRecordCell.h"

@interface KKExtractRecordViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    NSInteger _pageNumber;
    NSInteger _data_type;   // 1:当天 2:最近三天 3:最近一周 4:最近一月 如果不传，默认为1
}

@property (nonatomic, strong) UIButton * navTitleButton;

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;


@end

@implementation KKExtractRecordViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    
    [self initUI];
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
    KKExtractRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKExtractRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//    cell.backgroundColor = MCUIColorLightGray;
    cell.model = self.dataArrayM[indexPath.row];

    return cell;
}


#pragma mark - 点击事件

- (void)rightItemClicked {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *other_oneAction = [UIAlertAction actionWithTitle:@"今天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 1;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    UIAlertAction *other_twoAction = [UIAlertAction actionWithTitle:@"最近三天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 2;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    UIAlertAction *other_threeAction = [UIAlertAction actionWithTitle:@"最近一周" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 3;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    UIAlertAction *other_fourAction = [UIAlertAction actionWithTitle:@"最近一月" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 4;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:other_oneAction];
    [alertController addAction:other_twoAction];
    [alertController addAction:other_threeAction];
    [alertController addAction:other_fourAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.dataArrayM removeAllObjects];
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
}

#pragma mark - 网络请求
- (void)sendNetWorkingWithPageNumber:(NSInteger)pageNumber andData_type:(NSInteger)type {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/coin-info"];
    
    NSDictionary * parameter = @{
                                 @"page_no"   : @(_pageNumber),
                                 @"page_size" : @(10),
                                 @"data_type" : @(type),
                                 @"status"    : @"06"
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
        NSArray * dataArray = (NSArray *)data;
        if (dataArray.count == 0 && self.dataArrayM.count == 0) {
            self.isShowEmptyView = YES;
        } else {
            if (pageNumber == 1) {
                [self.dataArrayM removeAllObjects];
            }
            self.isShowEmptyView = NO;
            for (NSDictionary * dict in data) {
                KKAccountDetailModel * model = [[KKAccountDetailModel alloc] init];
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
    self.titleString = @"提现记录";
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
        self.tableView.backgroundColor = MCMineTableViewBgColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNumber = 1;
            [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNumber ++;
            [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
        }];
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}


@end
