//
//  KKBetDetailViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBetDetailViewController.h"
#import "KKBetDetailHeaderView.h"

#import "KKBetDetailModel.h"
#import "KKBetDetailCell.h"
#import "KKBetDetailTableViewCell.h"

@interface KKBetDetailViewController ()
<
UITableViewDelegate,UITableViewDataSource
>

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (nonatomic, strong) UIButton *cancalOrderButton;
@property (nonatomic, strong) KKBetDetailHeaderView * headerView;
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger show;

@property (nonatomic, strong) NSArray * titleArray;

@end

@implementation KKBetDetailViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArrayM[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == self.dataArrayM.count - 1 && self.status == 0){
        return 60;
    }else{
        return 0.01;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * label = [[UILabel alloc] init];
    label.font = MCFont(15);
    label.textColor = MCUIColorMain;
    label.frame = CGRectMake(0, 0, MCScreenWidth, 40);
    if(section <=2){
      label.text = [NSString stringWithFormat:@"    %@",self.titleArray[section]];
    }
    
    return label;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section == self.dataArrayM.count - 1 && self.status == 0){
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor = MCMineTableViewBgColor;
        bgView.frame = CGRectMake(0, 0, 0, 60);
        [bgView addSubview:self.cancalOrderButton];
        [self.cancalOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(8);
            make.right.equalTo(bgView).offset(-20);
            make.left.equalTo(bgView).offset(20);
            make.height.mas_equalTo(44);
        }];
        return bgView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    KKBetDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKBetDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (self.show != 1) {
        if (indexPath.section == 1) {
            KKBetDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"promptCell" forIndexPath:indexPath];
            cell.model = self.dataArrayM[indexPath.section][indexPath.row];
            return cell;
        } else {
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.backgroundColor = MCMineTableCellBgColor;
            cell.model = self.dataArrayM[indexPath.section][indexPath.row];
        }
    } else {
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.backgroundColor = MCMineTableCellBgColor;
        cell.model = self.dataArrayM[indexPath.section][indexPath.row];
    }
    
    
    
    return cell;
}



#pragma mark - 点击事件
- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.dataArrayM removeAllObjects];
    [self sendNetWorking];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"bet/bet-info"];
    
    NSDictionary * parameter = @{
                                 @"order_number" : self.order_number
                                 };
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
        // 头部信息
        NSString * lottery_name = data[@"lottery_name"];
        NSString * lottery_qh = [NSString stringWithFormat:@"第%@期",data[@"lottery_qh"]];
        NSString * prof_or_loss = [NSString stringWithFormat:@"%@元",data[@"prof_or_loss"]]; // 盈亏
        NSInteger status = [data[@"status"] integerValue];
        NSInteger show = [data[@"show_hm"] integerValue];
        self.show = show;
        NSString * statusStr;
        if (status == 0) {
            statusStr = @"未开奖";
        } else if (status == 1) {
            statusStr = @"未中奖";
        } else if (status == 2) {
            statusStr = @"撤销";
        } else if (status == 3) {
            statusStr = @"中奖";
        } else if (status == 4) {
            statusStr = @"订单异常";
        }
        self.status = status;
        
        self.headerView.periodicalLabel.text = lottery_qh;
        self.headerView.nameLabel.text = lottery_name;
        self.headerView.statusLabel.text = statusStr;
        self.headerView.moneyLabel.text = prof_or_loss;
        
        // 基本信息
        CGFloat bet_money = [data[@"bet_money"] floatValue];
        NSString * bet_moneyStr = [NSString stringWithFormat:@"%.2f元",bet_money];
        NSString * order_number = data[@"order_number"];
        NSString * bet_time = data[@"bet_time"];
        
        // 投注内容
        NSString * wf_name = [NSString stringWithFormat:@"[%@]",data[@"wf_name"]];
        NSString * bet_times = [NSString stringWithFormat:@"[%@]",data[@"bet_times"]];
        NSString * bet_number = data[@"bet_number"];
        NSString * betDetailStr = [NSString stringWithFormat:@"%@%@",wf_name,bet_times];
        
        // 返点信息
        NSString * kj_number = data[@"kj_number"];
        NSString * win_money = [NSString stringWithFormat:@"%@元",data[@"win_money"]];
        NSString * max_return_point = [NSString stringWithFormat:@"%@%@",data[@"max_return_point"],@"%"]; // 派彩返点
        NSString * max_return_money = [NSString stringWithFormat:@"%@元",data[@"max_return_money"]];
        if (kj_number == nil) {
            kj_number = @"";
        }
        
//        self.titleArray = @[@"基本信息",@"投注内容",@"返点信息"];
        NSArray * array = [NSArray array];
        if (self.show == 1) {
            array = @[
                      @[@{@"name": @"投注金额",@"detail":bet_moneyStr},@{@"name": @"订单编号",@"detail":order_number},@{@"name": @"投注时间",@"detail":bet_time}],
                      @[@{@"name": betDetailStr,@"detail":@""},@{@"name": bet_number,@"detail":@""}],
                      @[@{@"name": @"开奖号码",@"detail":kj_number},@{@"name": @"中奖金额",@"detail":win_money},@{@"name": @"盈亏",@"detail":prof_or_loss},@{@"name": @"派彩返点",@"detail":max_return_point},@{@"name": @"返点金额",@"detail":max_return_money}]
                      ];
        } else {
            array = @[
                      @[@{@"name": @"投注金额",@"detail":bet_moneyStr},@{@"name": @"订单编号",@"detail":order_number},@{@"name": @"投注时间",@"detail":bet_time}],
                      @[@{@"name": bet_number,@"detail":@""}],
                      @[@{@"name": @"开奖号码",@"detail":kj_number},@{@"name": @"中奖金额",@"detail":win_money},@{@"name": @"盈亏",@"detail":prof_or_loss},@{@"name": @"派彩返点",@"detail":max_return_point},@{@"name": @"返点金额",@"detail":max_return_money}]
                      ];
        }
        
        [self.dataArrayM removeAllObjects];
        for (NSArray * subArray in array) {
            NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary * dict in subArray) {
                KKBetDetailModel * model = [[KKBetDetailModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [arrayM addObject:model];
            }
            [self. dataArrayM addObject:arrayM];
        }
        
        [self.tableView reloadData];
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        [self setIsShow404View:YES];

    }];
}


#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"投注详情";
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)cancalOrderButtonClicked{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/bet/undo-order"];
    NSDictionary * parameter = @{
                                   @"order_number" : self.order_number
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"撤单成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:YES];
        });
       
    } dislike:^(id data) {
        [self sendNetWorking];
    } failure:^(NSError *error) {
        [self sendNetWorking];
    }];
}

#pragma mark - setter & getter


- (UIButton *)cancalOrderButton {
    if (_cancalOrderButton == nil) {
        _cancalOrderButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _cancalOrderButton.backgroundColor = [UIColor colorWithRed:218/255.0 green:28/255.0 blue:54/255.0 alpha:1/1.0];
        _cancalOrderButton.titleLabel.font = MCFont(16);
        [_cancalOrderButton setTitle:@"撤单" forState:UIControlStateNormal];
        [_cancalOrderButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        _cancalOrderButton.layer.cornerRadius = 5;
        _cancalOrderButton.layer.masksToBounds = YES;
        [_cancalOrderButton addTarget:self action:@selector(cancalOrderButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _cancalOrderButton;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = MCMineTableViewBgColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableHeaderView = self.headerView;
        self.tableView.sectionHeaderHeight = 40;
        self.tableView.sectionFooterHeight = 10;
        [self.tableView registerClass:[KKBetDetailTableViewCell class] forCellReuseIdentifier:@"promptCell"];
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

- (KKBetDetailHeaderView *)headerView {
    if (_headerView == nil) {
        self.headerView = [[KKBetDetailHeaderView alloc] init];
        self.headerView.backgroundColor = MCMineTableCellBgColor
        ;
        self.headerView.frame = CGRectMake(0, 0, 0, 75);
    } return _headerView;
}

-(NSArray *)titleArray{
    if(_titleArray == nil){
        _titleArray = @[@"基本信息",@"投注内容",@"返点信息"];
    }
    return _titleArray;
}

@end
