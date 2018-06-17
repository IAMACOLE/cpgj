//
//  KKUserinfoViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/3/31.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKSafeCenterViewController.h"

#import "KKUserinfoModel.h"
#import "KKUserinfoCell.h"

#import "KKAlterLoginPasswordViewController.h"
#import "KKBingingBankcardViewController.h"
#import "KKAlterDrawMoneyViewController.h"

#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface KKSafeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _isSettingDrawMoneyPassword; //
}
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;

@property (nonatomic, strong) UIButton * moneyButton;


@property (nonatomic, strong) UIButton * exitButton;


@end

@implementation KKSafeCenterViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:BSNotification_reloadPersonalInformation object:nil];
    
    [self sendNetWorking];
    
    [self basicSetting];
    
    [self initUI];
}

- (void)reloadData {
    [self sendNetWorking];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArrayM[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        UILabel * label = [[UILabel alloc] init];
        label.font = MCFont(14);
        label.textColor = MCUIColorMiddleGray;
        label.text = @"    账户保护";
        label.frame = CGRectMake(0, 0, 0, 40);
        return label;
    } else {
    
        UILabel * label = [[UILabel alloc] init];
        label.font = MCFont(14);
        label.textColor = MCUIColorMiddleGray;
        label.text = @"    资金保护";
        label.frame = CGRectMake(0, 0, 0, 40);
        return label;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    KKUserinfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKUserinfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = MCMineTableCellBgColor;
    cell.model = self.dataArrayM[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        KKAlterLoginPasswordViewController * password = [[KKAlterLoginPasswordViewController alloc] init];
        password.isSettingPassword = ![MCTool BSGetUserinfo_password_status];
        [self.navigationController pushViewController:password animated:YES];
    
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        KKBingingBankcardViewController * binging = [[KKBingingBankcardViewController alloc] init];
        [self.navigationController pushViewController:binging animated:YES];
       

    } else if (indexPath.section == 1 && indexPath.row == 1) {

        KKAlterDrawMoneyViewController * drawMoney = [[KKAlterDrawMoneyViewController alloc] init];
        drawMoney.isChange = _isSettingDrawMoneyPassword;
        [self.navigationController pushViewController:drawMoney animated:YES];
    
    }
}

#pragma mark - 点击事件
- (void)exitButtonClicked {
    [MCTool BSRemoveObjectforKey:BSUserinfo];
    [self.navigationController popViewControllerAnimated:YES];
    
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:0];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BSNotification_ChangeLoginStatus object:nil];
}

- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self sendNetWorking];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/user-info"];
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
        
        [self.dataArrayM removeAllObjects];
        
        double balance = [data[@"balance"] doubleValue];
        
        NSString * moneyStr = [NSString stringWithFormat:@"  余额: %.2f元",balance];
        [self.moneyButton setTitle:moneyStr forState:UIControlStateNormal];
        
        
        NSString * bank_status = data[@"bank_status"];
        NSString * binding;
        NSString * detail;
        if ([bank_status isEqualToString:@"0"]) {
            binding = @"未绑定";
            detail = @"绑定银行卡以便提现";
        } else {
            binding = @"已绑定";
            detail = @"查看银行卡信息";
        }
        

        NSString * bank_passwd_status = data[@"bank_passwd_status"];
        NSString * passwordStr;
        if ([bank_passwd_status isEqualToString:@"0"]) {
            passwordStr = @"未设置";
            _isSettingDrawMoneyPassword = 0;
        } else {
            passwordStr = @"已设置";
            _isSettingDrawMoneyPassword = 1;
        }
        
        
        NSArray * array = @[
                            @[
                                @{@"icon":[UIImage imageNamed:@"lock"],@"name":@"登录密码",@"detail":@"建议定期修改",@"isBinding":@""},
                                ],
                            @[
                                @{@"icon":[UIImage imageNamed:@"bankCard"],@"name":@"银行卡",@"detail":detail,@"isBinding":binding},
                                @{@"icon":[UIImage imageNamed:@"withdrawalPassword"],@"name":@"提款密码",@"detail":@"保证资金更安全",@"isBinding":passwordStr}
                                ]
                            ];
        
        for (NSArray * subArray in array) {
            NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary * dict in subArray) {
                KKUserinfoModel * model = [[KKUserinfoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [arr addObject:model];
            }
            [self.dataArrayM addObject:arr];
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
    self.titleString = @"安全中心";
    
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - setter & getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = MCMineTableViewBgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 30;
        _tableView.sectionFooterHeight = 0.01;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
//        self.tableView.tableHeaderView = view;
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

- (UIButton *)moneyButton {
    if (_moneyButton == nil) {
        self.moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moneyButton.frame = CGRectMake(20, 0, MCScreenWidth - 20, 68);
        self.moneyButton.titleLabel.font = MCFont(16);
        [self.moneyButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.moneyButton setImage:[UIImage imageNamed:@"Recharge_money"] forState:UIControlStateNormal];
        self.moneyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.moneyButton.userInteractionEnabled = NO;
    } return _moneyButton;
}

- (UIButton *)exitButton {
    if (_exitButton == nil) {
        self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exitButton.backgroundColor = MCUIColorWhite;
        self.exitButton.titleLabel.font = MCFont(16);
        [self.exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [self.exitButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _exitButton;
}

@end

