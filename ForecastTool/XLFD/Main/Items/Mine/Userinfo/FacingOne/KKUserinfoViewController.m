//
//  KKUserinfoViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/3/31.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKUserinfoViewController.h"

#import "KKUserinfoModel.h"
#import "KKUserinfoCell.h"

#import "KKAlterLoginPasswordViewController.h"
#import "KKBingingBankcardViewController.h"
#import "KKAlterDrawMoneyViewController.h"
#import "KKUserAvatarViewController.h"
#import "KKUserNickNameViewController.h"

#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface KKUserinfoViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    NSInteger _isSettingDrawMoneyPassword; //
}
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;

@property (nonatomic, strong) UIButton * moneyButton;


@property (nonatomic, strong) UIButton * exitButton;


@end

@implementation KKUserinfoViewController

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
    
    [self basicSetting];
    [self initUI];
    [self sendNetWorking];
}

- (void)reloadData {
    [self sendNetWorking];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor = MCMineTableViewBgColor;
        bgView.frame = CGRectMake(0, 0, 0, 75);
        
        UIView * whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = MCMineTableCellBgColor;
        whiteView.frame = CGRectMake(0, 0, MCScreenWidth, 68);
        [bgView addSubview:whiteView];
        

        [whiteView addSubview:self.moneyButton];
        
        return bgView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = CGRectMake(0, 0, 0, 50);
    [bgView addSubview:self.exitButton];
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(10);
        make.right.equalTo(bgView).offset(-20);
        make.bottom.equalTo(bgView);
        make.left.equalTo(bgView).offset(20);
    }];
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    KKUserinfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKUserinfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = MCMineTableCellBgColor;
    cell.model = self.dataArrayM[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        KKUserAvatarViewController * avatar = [[KKUserAvatarViewController alloc] init];
        [self.navigationController pushViewController:avatar animated:YES];
    
    } else {
        KKUserNickNameViewController *nickName = [[KKUserNickNameViewController alloc] init];
        [self.navigationController pushViewController:nickName animated:YES];
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
        NSArray * array = @[
  @{@"icon":[UIImage imageNamed:@"avatarIcon"],@"name":@"头像",@"detail":@"更换",@"isBinding":@""},
  @{@"icon":[UIImage imageNamed:@"nickName"],@"name":@"昵称",@"detail":@"立即设置",@"isBinding":@""}
  ];
        for (NSDictionary * dict in array) {
            KKUserinfoModel * model = [[KKUserinfoModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArrayM addObject:model];
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
    self.titleString = @"个人信息";
    
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
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = MCMineTableViewBgColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        [self.moneyButton setTitleColor:MCUIColorBlack forState:UIControlStateNormal];
        [self.moneyButton setImage:[UIImage imageNamed:@"balance"] forState:UIControlStateNormal];
        self.moneyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.moneyButton.userInteractionEnabled = NO;
    } return _moneyButton;
}

- (UIButton *)exitButton {
    if (_exitButton == nil) {
        _exitButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _exitButton.backgroundColor = MCUIColorMain;
        _exitButton.titleLabel.font = MCFont(16);
        [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_exitButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        _exitButton.layer.cornerRadius = 5;
        _exitButton.layer.masksToBounds = YES;
        [_exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _exitButton;
}

@end

