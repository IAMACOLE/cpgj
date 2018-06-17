//
//  KKNewMineViewController.m
//  Kingkong_ios
//
//  Created by 222 on 2018/2/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKNewMineViewController.h"
#import "MineCollectionViewCell.h"
#import "KKMineModel.h"

#import "KKMineHeaderView.h"

#import "KKUserinfoViewController.h"
#import "KKDrawMoneyViewController.h"
#import "KKAccountDetailViewController.h"
#import "KKBetRecordViewController.h"
#import "KKRechargeRecordViewController.h"
#import "KKExtractRecordViewController.h"
#import "KKFollowViewController.h"
#import "KKMyMVPPeopleViewController.h"
#import "KKSafeCenterViewController.h"
#import "KKNotificationSettingViewController.h"
#import "KKMoreViewController.h"

@interface KKNewMineViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KKMineHeaderViewClickDelegate>

@property (nonatomic, strong) UICollectionView *customCollectionView;
@property (nonatomic, strong) KKMineHeaderView *collectionHeaderView;

@property (nonatomic, strong) NSMutableArray *dataArray;
	
@property (nonatomic, strong) UIImageView *collectionViewBg;

@end

@implementation KKNewMineViewController
static NSString *cellName = @"cell";
static NSString *headerViewName = @"header";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"个人中心";
    [self basicSetting];
    [self configureUI];
    [self netWorkSetting];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeHeaderView];
    [KKBalanceManager getBalance:^(NSString *balance) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.collectionHeaderView.balanceContent.text = [NSString stringWithFormat:@"%@元", balance];
        });
    }];
    
    [self numberUnreadMessages];
}


#pragma mark - 基本设置
- (void)basicSetting {
	
    self.bgImageView.image = [UIImage imageNamed:@"bgHomeImageView_Image"];
    self.view.backgroundColor = MCUIColorWhite;
    self.navigationItem.leftBarButtonItem = self.customLeftItem;
    self.navigationItem.rightBarButtonItem = self.noticeButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeaderView) name:@"RELOADHOMEPAGE" object:nil];
}


#pragma mark - 网络设置
- (void)netWorkSetting {
    NSArray *array = @[
              @{@"title":@"提现",@"image":@"Mine_drawMoney"},
              @{@"title":@"账户明细",@"image":@"Mine_accountDetail"},
              @{@"title":@"投注记录",@"image":@"Mine_betRecord"},
              @{@"title":@"充值记录",@"image":@"Mine_rechargeRecord"},
              @{@"title":@"提现记录",@"image":@"Mine_extractRecord"},
              @{@"title":@"我的跟单",@"image":@"Mine_follow"},
              @{@"title":@"我的关注",@"image":@"Mine_attention"},
              @{@"title":@"安全中心",@"image":@"Mine_security"},
              @{@"title":@"消息通知设置",@"image":@"Mine_notice"},
              @{@"title":@"更多",@"image":@"Mine_more"},
              ];
    self.dataArray = [NSMutableArray array];
    for (NSDictionary *dataItem in array) {
        KKMineModel *model = [[KKMineModel alloc] initWithDictionary:dataItem error:nil];
        [self.dataArray addObject:model];
    }
    [self.customCollectionView reloadData];
}

- (void)changeHeaderView {
    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        [self.collectionHeaderView isLogin:YES];
    } else {
        [self.collectionHeaderView isLogin:NO];
    }
}

#pragma mark - UI设置
- (void)configureUI {
    
    [self.view addSubview:self.collectionViewBg];
    [self.collectionViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70 * 5 + 10);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(MCScreenWidth * 0.5);
    }];
    
    [self.view addSubview:self.customCollectionView];
    [self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
    }];
}

- (void)addHeaderView:(UICollectionReusableView *)view {
    [view addSubview:self.collectionHeaderView];
    [self.collectionHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(view);
    }];
}

#pragma mark 头部按钮点击跳转页面
- (void)buttonClickToPushController {
    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        KKUserinfoViewController * userinfoViewController = [[KKUserinfoViewController alloc] init];
        [self.navigationController pushViewController:userinfoViewController animated:YES];
    } else {
        KKLoginViewController *login = [[KKLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}
	
#pragma mark collectionView 每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
#pragma mark collectionView 多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ceil((double)self.dataArray.count / 2);
}
#pragma mark collectionView item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MCScreenWidth / 2 - 40, 68);
}
#pragma mark collectionView header大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(MCScreenWidth - 50, MCScreenWidth * 0.5);
    } else {
        return CGSizeZero;
    }
}
#pragma mark collectionView item最小内边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark collectionView headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
     UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewName forIndexPath:indexPath];
    [self addHeaderView:headerView];
    return headerView;
}
#pragma mark collectionView cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.section * 2 + indexPath.row;
    MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    if (index < self.dataArray.count) {
        [cell loadData:self.dataArray[index] AndIndexPath:indexPath];
    }
    return cell;
}
#pragma mark collectionView 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section * 2 + indexPath.row;
    if (index != 9) {
        NSString * token = [MCTool BSGetUserinfo_token];
        if (token.length == 0) {
            KKLoginViewController *login = [[KKLoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            return;
        }
    }
    if (index == 0) {
        KKDrawMoneyViewController * drawMoneyViewController = [[KKDrawMoneyViewController alloc] init];
        [self.navigationController pushViewController:drawMoneyViewController animated:YES];
    } else if (index == 1) {
        KKAccountDetailViewController * accountDetailViewController = [[KKAccountDetailViewController alloc] init];
        [self.navigationController pushViewController:accountDetailViewController animated:YES];
        
    } else if (index == 2) {
        KKBetRecordViewController * betRecord = [[KKBetRecordViewController alloc] init];
        [self.navigationController pushViewController:betRecord animated:YES];
        
    } else if (index == 3) {
        KKRechargeRecordViewController * rechargeRecordViewController = [[KKRechargeRecordViewController alloc] init];
        [self.navigationController pushViewController:rechargeRecordViewController animated:YES];
        
    } else if (index == 4) {
        KKExtractRecordViewController * extractRecordViewController = [[KKExtractRecordViewController alloc] init];
        [self.navigationController pushViewController:extractRecordViewController animated:YES];
    } else if (index == 5) {
        KKFollowViewController *viewController = [[KKFollowViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (index == 6) {
        KKMyMVPPeopleViewController *viewController = [[KKMyMVPPeopleViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (index == 7) {
        KKSafeCenterViewController *viewController = [[KKSafeCenterViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (index == 8) {
        KKNotificationSettingViewController * notificationViewController = [[KKNotificationSettingViewController alloc] init];
        [self.navigationController pushViewController:notificationViewController animated:YES];
    } else if (index == 9) {
        KKMoreViewController * moreViewController = [[KKMoreViewController alloc] init];
        [self.navigationController pushViewController:moreViewController animated:YES];
    }
}

#pragma mark - 懒加载

- (KKMineHeaderView *)collectionHeaderView {
    if (_collectionHeaderView == nil) {
        _collectionHeaderView = [[KKMineHeaderView alloc] init];
        _collectionHeaderView.delegate = self;
    }
    return _collectionHeaderView;
}

- (UICollectionView *)customCollectionView {
    if (_customCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(25, 0, MCScreenWidth - 50, MCScreenHeight) collectionViewLayout:layout];
        _customCollectionView.showsHorizontalScrollIndicator = NO;
        _customCollectionView.showsVerticalScrollIndicator = NO;
        _customCollectionView.alwaysBounceVertical = YES;
        _customCollectionView.dataSource = self;
        _customCollectionView.delegate = self;
        _customCollectionView.scrollEnabled = NO;
        [_customCollectionView registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:cellName];
        [_customCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewName];
        _customCollectionView.contentInset = UIEdgeInsetsMake(5, 10, 0, 10);
        _customCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _customCollectionView;
}

-(UIImageView *)collectionViewBg{
    if(_collectionViewBg == nil){
        _collectionViewBg = [UIImageView new];
        _collectionViewBg.image = [UIImage imageNamed:@"collectionViewBg"];
    }
    return _collectionViewBg;
}


@end
