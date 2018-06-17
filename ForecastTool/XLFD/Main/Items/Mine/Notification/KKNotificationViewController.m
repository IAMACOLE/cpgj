//
//  KKNotificationViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKNotificationViewController.h"

#import "KKNotificationModel.h"
#import "KKNotificationCell.h"
#import "KKMessageDetailsView.h"
#import "KKMessageDetailsViewController.h"

@interface KKNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;
}

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;



@end

@implementation KKNotificationViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = 1;
    [self basicSetting];
    
    [self sendNetWorkingWithPage:_pageNumber];
    
    [self initUI];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    KKNotificationModel * model = self.dataArrayM[indexPath.row];
    
//    CGFloat height = [model.content boundingRectWithSize:CGSizeMake(MCScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : MCFont(12)} context:nil].size.height;
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    KKNotificationCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKNotificationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = MCUIColorLightGray;
    cell.model = self.dataArrayM[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKMessageDetailsView *mdv = [[KKMessageDetailsView alloc]init];
    mdv.model = self.dataArrayM[indexPath.row];
    mdv.deleteItemClick = ^(KKNotificationModel *model) {
        for (int i = 0; i <self.dataArrayM.count; i++) {
            KKNotificationModel *nm = [self.dataArrayM objectAtIndex:i];
            if ([nm.lottery_id isEqualToString:model.lottery_id]) {
                [self.dataArrayM removeObjectAtIndex:i];
                break;
            }
        }
        if (self.dataArrayM.count == 0) {
            [self setIsShowEmptyView:YES];
        }
        [self.tableView reloadData];
    };
    
    mdv.readItemClick = ^(KKNotificationModel *model) {
        for (int i = 0; i <self.dataArrayM.count; i++) {
            KKNotificationModel *nm = [self.dataArrayM objectAtIndex:i];
            if ([nm.lottery_id isEqualToString:model.lottery_id]) {
                nm.is_read = @"1";
                break;
            }
        }
        [self.tableView reloadData];
    };
    
    mdv.loginClick = ^{
        KKLoginViewController *login = [[KKLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    };
    [self.view.window addSubview:mdv];
    [mdv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.window);
    }];
    
//    KKMessageDetailsViewController *mdvc = [[KKMessageDetailsViewController alloc]init];
//    mdvc.model = self.dataArrayM[indexPath.row];
//    [self.navigationController pushViewController:mdvc animated:YES];
}


#pragma mark - 点击事件
- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.dataArrayM removeAllObjects];
    [self sendNetWorkingWithPage:_pageNumber];
}


#pragma mark - 网络请求
- (void)sendNetWorkingWithPage:(NSInteger)pageNumber {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/message"];
    
    NSDictionary * parameter = @{
                                 @"page_size" : @"10",
                                 @"page_no" : @(pageNumber)
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
        NSArray * dataArray = (NSArray *)data;
       
        if (pageNumber == 1) {
            [self.dataArrayM removeAllObjects];
        }
        
        if (dataArray.count == 0 && self.dataArrayM.count == 0) {
            [self setIsShowEmptyView:YES];
        } else {
            [self setIsShowEmptyView:NO];
            
            for (NSDictionary * dict in dataArray) {
                KKNotificationModel * model = [[KKNotificationModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.lottery_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
                [self.dataArrayM addObject:model];
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"通知列表";
    _pageNumber = 1;
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
        self.tableView.backgroundColor = MCUIColorLightGray;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNumber = 1;
            [self sendNetWorkingWithPage:_pageNumber];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNumber ++;
            [self sendNetWorkingWithPage:_pageNumber];
        }];
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

@end
