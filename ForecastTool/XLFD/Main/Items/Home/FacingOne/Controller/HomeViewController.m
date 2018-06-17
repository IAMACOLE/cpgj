//
//  HomeViewController.m
//  Kingkong_ios
//
//  Created by 222 on 2018/3/15.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "HomeViewController.h"

#import "AnotherVersionHomeCollectionViewCell.h"
#import "HomeButtonModel.h"
#import "HomeCollectionViewHeadCell.h"
#import "HomeCollectionViewWinningCell.h"
#import "UserRankModel.h"

#import "SDCycleScrollView.h"

#import "AutoScrollLabel.h"
#import <SDWebImage/UIImage+GIF.h>
#import "HomepageBannerModel.h"
#import "BannerButtonModel.h"
#import "RodiaView.h"
#import <SDWebImage/UIButton+WebCache.h>

#import "CMMessageTipsView.h"
#import "WMDragView.h"

#import "SignInView.h"

#import "LotteryDetailPK10ViewController.h"
#import "LotteryDetailLHCViewController.h"
#import "LotteryDetailBJ28ViewController.h"
#import "LotteryDetailTabViewController.h"
#import "LotteryDetail11X5ViewController.h"
#import "LotteryDetailK3ViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SDCycleScrollViewDelegate, GrantsButtonDelegate, UpdateModelDataSource>

@property (nonatomic, strong) UICollectionView *customCollectionView;
@property (nonatomic, strong) UICollectionView *footerCollectionView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *subDataArray;
@property (nonatomic, strong) NSArray *userRankArray;
//判断获取锁盘时间的网络请求是否都请求完成 getRockTimeCount == self.oneLevelItems_typeArray.count
@property (nonatomic, assign) NSInteger getRockTimeCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *redEnvelopeTimer;
@property (nonatomic, strong) NSString *gifURL;

@property(nonatomic,strong)NSMutableArray * bannerArrayM;//横幅数组
@property(nonatomic ,assign) NSInteger selectIndex; //选择了那个按钮
@property(nonatomic ,assign) NSInteger selectSection;//选择了哪行
@property (nonatomic,strong) NSDictionary *radioDic;

@property (nonatomic,strong) NSMutableArray *footerPromptAry;
@property (nonatomic, strong) NSMutableDictionary *redEnvelopeDict;

//headerView item
@property (nonatomic, strong) UIImageView *bannerBgView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView *headBlackView;
@property (nonatomic, strong) UIImageView *headBlackViewBGView;
@property (nonatomic, strong) UIImageView *subTitleView;
@property (nonatomic, strong) UILabel *promptTextLabel;
@property (nonatomic, strong) AutoScrollLabel *radioLabel;
@property (nonatomic, strong) UIButton *radioButton;
@property (nonatomic, strong) RodiaView *radioView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView *headImageViewTop;
@property (nonatomic, strong) UIButton *headImageButton;

//cell
@property (nonatomic, strong) UIView *cellBgView;//data数据为空时占位
@property (nonatomic, assign) BOOL hasData;
//footerView
@property (nonatomic, strong) CMMessageTipsView *tipsView;
@property (nonatomic, strong) UIButton *redEnvelopeButton;
@property (nonatomic, strong) UILabel *redEnvelopeTimeLabel;
@property (nonatomic, strong) WMDragView *redEnvelopeView;
@property (nonatomic, strong) UIView *footerPromptView;

@property (nonatomic, strong) SignInView *signInView;

@end

@implementation HomeViewController

static NSString *cycleCellName = @"cycleCell";
static NSString *cellName = @"cell";
static NSString *cellName2 = @"cell2";
static NSString *cellName3 = @"cell3";
static NSString *footerCellName = @"footerCell";
static NSString *headerView = @"header";
static NSString *footHeaderView = @"footHeader";
static NSString *footerViewName = @"footer";
static NSInteger numberOfItemsInSection = 3;
CGFloat itemHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self basicSetting];
	[self configureUI];
    [self networkSetting];
//    [self homeContentStatus];
    [self getAllCollectionItems:YES isRefresh:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = NO;
	NSString *content = self.radioDic[@"title"];
	if (content.length > 0) {
		self.radioLabel.text = content;
	} else {
//		self.promptTextLabel = [[UILabel alloc] init];
//		self.promptTextLabel.textAlignment = NSTextAlignmentCenter;
//		self.promptTextLabel.font = [UIFont systemFontOfSize:12];
//		self.promptTextLabel.text = @"数据加载中";
//		[self.promptTextLabel sizeToFit];
//		[self.promptTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.center.equalTo(self.headBlackView);
//		}];
	}
    [self getGif];
	NSString * token = [MCTool BSGetUserinfo_token];
	if (token.length > 0 && [AppDelegate sharedApplicationDelegate].isSignIn) {
        [AppDelegate sharedApplicationDelegate].isSignIn = NO;
        [self judgeIsOrNotShowSignInView];
		
        [self getUserRanking];
	}
    
    [self numberUnreadMessages];
}

#pragma mark - 基本设置

- (void)basicSetting {

	[self setControllerBgView];
	[self setTabBarTransparent];
	self.tabBarItem.title = @"大厅";
	self.navigationItem.leftBarButtonItem = self.customLeftItem;
	self.navigationItem.rightBarButtonItem = self.noticeButtonItem;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeSendNetWork) name:@"RELOADHOMEPAGE" object:nil];
	self.dataArray = [NSMutableArray array];
	HomeButtonModel *model = [[HomeButtonModel alloc] init];
	for (int i=0; i < 4; i++) {
		[self.dataArray addObject:model];
	}
	itemHeight = MCScreenWidth / 3;
}



- (void)setControllerBgView {
    self.bgImageView.image = [UIImage imageNamed:@"bgImageView_Image1"];
}

- (void)setTabBarTransparent {
	self.tabBarController.tabBar.backgroundImage = [UIImage new];
	self.tabBarController.tabBar.shadowImage = [UIImage new];
}

#pragma mark 创建倒计时
- (void)createTimer:(BOOL)isReFresh {
	if (isReFresh) {
		[self.timer invalidate];
	}
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
	for (id object in self.dataArray) {
		HomeButtonModel *model = (HomeButtonModel *)object;
		model.dataSource = self;
		[model countDownWithlottery_id:model.lottery_type];
		for (id subObject in model.sub_lottery) {
			HomeButtonModel *subModel = (HomeButtonModel *)subObject;
			subModel.dataSource = self;
			[subModel countDownWithlottery_id:subModel.lottery_type];
		}
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIME object:nil];
	if (self.selectedIndexPath != nil) {
		[self updateSubCollectionViewData];
	}
}

#pragma mark - 更新子collectionView数据
- (void)updateSubCollectionViewData {
	NSInteger index = self.selectedIndexPath.section * numberOfItemsInSection + self.selectedIndexPath.row;
	HomeButtonModel *model = self.dataArray[index];
	self.subDataArray = model.sub_lottery;
	[self.customCollectionView reloadData];
	[self.footerCollectionView reloadData];
}

#pragma mark - 网络设置
- (void)networkSetting {
	
	[self getWinningInfo];
	[self sendNetworking_banner];
	[self getGif];
	[self judgeRedEnvelope];

}

-(void)homeContentStatus{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"/v2/app-pac-version/get-set"];
    NSDictionary * parameter = @{
                                 @"type" : @"type_shenhe",
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:[MCTool getCurrentVC] isShowHUD:NO isShowTabbar:YES success:^(id data) {
        NSDictionary *dataDic = data;
        if([dataDic[@"on_off"] intValue]){
            [self networkSetting];
        }else{
            [self judgeRedEnvelope];
        }
        
    } dislike:^(id data) {
        [self judgeRedEnvelope];
        
    } failure:^(NSError *error) {
        [self judgeRedEnvelope];
        
    }];
    
}

-(void)noticeSendNetWork{
	NSString *token = [MCTool BSGetUserinfo_token];
	if (token.length > 0) {
		[self getUserRanking];
	}
}

-(void)reSendNetWork:(BOOL)isShowHUD{
	[self getAllCollectionItems:isShowHUD isRefresh:YES];
	//    [self getUrlList];
	//    [self getWinningInfo];
	[self judgeRedEnvelope];
	//    [self sendNetworking_banner];
	NSString * token = [MCTool BSGetUserinfo_token];
	if (token.length > 0) {
		[self getUserRanking];
	}
	
}

#pragma mark 所有的彩票类型
- (void)getAllCollectionItems:(BOOL)isShowHUD isRefresh:(BOOL)isRefresh {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/gc/get-cp-type"];
	NSDictionary *param = @{};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:isShowHUD isShowTabbar:YES success:^(id data) {
		[self.dataArray removeAllObjects];
		NSArray *ary = (NSArray *)data;
		[self setIsShow404View:NO];
//        [self setIsShowEmptyView:NO];
        [self.customCollectionView.mj_header endRefreshing];
		if (ary.count == 0) {
			self.hasData = false;
			HomeButtonModel *model = [[HomeButtonModel alloc] init];
			for (int i=0; i < 4; i++) {
				[self.dataArray addObject:model];
			}
			if (!isRefresh) {
				[self.customCollectionView.mj_header endRefreshing];
			} else {
				[self getRadioContent];
			}
			return;
		}
		self.hasData = true;
		NSMutableArray *oneLevelItems_typeArray = [NSMutableArray array];
		for (int i=0; i<ary.count; i++) {
			NSDictionary *dict = ary[i];
			HomeButtonModel *model = [[HomeButtonModel alloc] initWithDictionary:dict error:nil];
			model.countNumStr = model.remarks;
			NSMutableArray *subItemArray = [NSMutableArray array];
			for (int j=0; j<model.sub_lottery.count; j++) {
				NSDictionary * subItemDict = model.sub_lottery[j];
				HomeButtonModel *subItemModel = [[HomeButtonModel alloc] initWithDictionary:subItemDict error:nil];
				if ([model.sub_lottery_flag isEqual:@"0"]) {
					model.lottery_id = subItemModel.lottery_id;
					continue;
				}
				subItemModel.lottery_type = model.lottery_type;
				[subItemArray addObject:subItemModel];
			}
			model.sub_lottery = subItemArray;
			[self.dataArray addObject:model];
			[oneLevelItems_typeArray addObject:model.lottery_type];
		}
		self.getRockTimeCount = 0;
		[self getEndTimeWithArray:oneLevelItems_typeArray isRefresh:isRefresh];
	} dislike:^(id data) {
		[self.customCollectionView.mj_header endRefreshing];
	} failure:^(NSError *error) {
		[self.customCollectionView.mj_header endRefreshing];
		[self setIsShow404View:YES];
	}];
}

- (int)changeTimeStrToInt:(NSString *)lock_time {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *endDate = [dateFormatter dateFromString:lock_time];
	NSDate *currentDate = [NSDate date];
	NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:currentDate];
	return (int)timeInterval;
}

#pragma mark 获取锁盘时间
- (void)getEndTimeWithArray:(NSMutableArray *)array isRefresh:(BOOL)isRefresh {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/gc/sub-lottery-locktime"];
	for (int i=0; i<array.count; i++) {
		NSDictionary *param = @{@"lottery_type": array[i]};
		[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
			self.getRockTimeCount += 1;
			NSArray *ary = (NSArray *)data;
			for (int j=0; j<ary.count; j++) {
				NSDictionary *dataArrayItem = ary[j];
				NSString *lock_time = dataArrayItem[@"lock_time"];
				for (HomeButtonModel *model in self.dataArray) {
					NSString *lottery_id = dataArrayItem[@"lottery_id"];
					if ([lottery_id containsString:@"lhc"] && [model.lottery_type isEqual:@"6"]) {
						model.countNumStr = dataArrayItem[@"lock_time"];
						break;
					}
					if ([model.lottery_type isEqual:@"10"]) {
						model.countNum = [self changeTimeStrToInt:lock_time];
					}
					for (HomeButtonModel *subModel in model.sub_lottery) {
						if (subModel.lottery_id == dataArrayItem[@"lottery_id"]) {
							
							if ([lock_time containsString:@":"]) {
								subModel.countNum = [self changeTimeStrToInt:lock_time];
								subModel.countNumStr = subModel.remarks;
							} else {
								subModel.countNumStr = dataArrayItem[@"lock_time"];
							}
							break;
						}
					}
				}
			}
			if (self.getRockTimeCount == array.count) {
				[self createTimer:isRefresh];
				[self.customCollectionView reloadData];
				if (!isRefresh) {
					[self getRadioContent];
				}
				[self.customCollectionView.mj_header endRefreshing];
			}
		} dislike:^(id data) {
			
		} failure:^(NSError *error) {
			
		}];
	}
}

#pragma mark 获取首页用户排名
- (void)getUserRanking {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/user-info/get-user-rank"];
	NSString * token = [MCTool BSGetUserinfo_token];
	NSDictionary *param = @{@"user_token": token};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
		NSDictionary *dataDict = (NSDictionary *)data;
		if (dataDict.allKeys.count > 0) {
			UserRankModel *model = [[UserRankModel alloc] init];
            model.today_flow_money = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"today_flow_money"]];
			model.today_profit_loss = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"today_profit_loss"]];
			model.user_ranking = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"user_ranking"]];
			self.userRankArray = @[model];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.customCollectionView reloadData];
			});
		}
	} dislike:^(id data) {
	} failure:^(NSError *error) {
		
	}];
}

#pragma mark 获取广播内容
- (void)getRadioContent {
	NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/notice"];
	NSDictionary * parameter = @{@"data" : @(1)};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
		self.radioDic = data;
		dispatch_async(dispatch_get_main_queue(), ^{
			self.radioLabel.text = data[@"title"];
			[self.promptTextLabel removeFromSuperview];
		});
	} dislike:^(id data) {
	} failure:^(NSError *error) {
		
	}];
}
#pragma mark 获取banner内容
- (void)sendNetworking_banner {
	NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/image-list"];
	NSDictionary * parameter = @{@"data" : @(1)};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
		NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];
		self.bannerArrayM = [NSMutableArray array];
		for (NSDictionary *dict in data) {
			HomepageBannerModel *model = [[HomepageBannerModel alloc]initWithDictionary:dict error:nil];
			[self.bannerArrayM addObject:model];
			[arrayM addObject:[NSString stringWithFormat:@"%@",model.image_url]];
		}
		self.cycleScrollView.imageURLStringsGroup = arrayM;
		
	} dislike:^(id data) {
	} failure:^(NSError *error) {
		
	}];
}
#pragma mark 首页动态图
- (void)getGif {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/gc/syad-image"];
	NSDictionary *param = @{@"type": @"03"};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
		NSDictionary *dict = (NSDictionary *)data;
        NSString *imageUrl = data[@"image_url"];
		self.gifURL = [dict objectForKey:@"turn_url"];
		NSString *urlStr = [dict objectForKey:@"reserved"];//reserved
		NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
		[self.headImageView setImage:[UIImage sd_animatedGIFWithData:imgData]];
        [self.headImageViewTop setImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]]];
	} dislike:^(id data) {
    } failure:^(NSError *error) {
        self.headImageView.clipsToBounds = YES;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.headImageView.image = [UIImage imageNamed:@"HomeViewController_placeholder_image"];
	}];
}

#pragma mark 获取中奖通知
- (void)getWinningInfo {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"/v2/gc/betwin-notice"];
	NSString * token = [MCTool BSGetUserinfo_token];
	NSDictionary *param = @{@"user_token": token};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
		NSMutableArray * dataAry = (NSMutableArray *)data;
		self.footerPromptAry = [NSMutableArray array];
		for (int i=0; i < dataAry.count; i++) {
			NSDictionary *dataItemDict = dataAry[i];
			NSString *content = [dataItemDict objectForKey:@"content"];
			[self.footerPromptAry addObject:content];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tipsView showTips:self.footerPromptAry];
		});
	} dislike:^(id data) {
	} failure:^(NSError *error) {
		
	}];
}

#pragma mark 判断是否有红包
- (void) judgeRedEnvelope {
	self.redEnvelopeDict =[MCTool BSGetObjectForKey:BSLuckyMoneyState];
	NSInteger on_off = (NSUInteger)self.redEnvelopeDict[@"on_off"];
	if (on_off > 0) {
		[self addRedEnvelopeView:self.redEnvelopeDict];
	}
}
#pragma mark 判断是否展示签到
- (void)judgeIsOrNotShowSignInView {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/activity/today-is-received"];
	NSDictionary *param = @{@"hd_flag":@"hd_qiandao"};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
		NSDictionary *dataDict = (NSDictionary *)data;
		if (![dataDict[@"is_received"] isEqual:@"1"]) {
			[self addSignInView];
		}
	} dislike:^(id data) {
	} failure:^(NSError *error) {
		
	}];
}


#pragma mark - UI设置
- (void) configureUI {
	[self setCollectionView];
}
#pragma mark 设置CollectionView宽高
- (void)setCollectionView {
	[self.view addSubview:self.customCollectionView];
	[self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view);
		make.right.equalTo(self.view).offset(-kAdapterFontSize(20));
		make.left.equalTo(self.view).offset(kAdapterFontSize(20));
		make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
	}];
}

- (void)addHeaderModuleWithHeaderView:(UICollectionReusableView *)view {
	[view addSubview:self.bannerBgView];
	[self.bannerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(view);
		make.width.centerX.equalTo(view);
		make.height.mas_equalTo(MCScreenWidth * 0.5);
	}];
	[view addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo( self.bannerBgView);
        make.width.mas_equalTo(MCScreenWidth - kAdapterFontSize(35) * 2);
        make.height.mas_equalTo(MCScreenWidth * 0.4);
    }];
	[view addSubview:self.headBlackView];
	[self.headBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.bannerBgView.mas_bottom).offset(kAdapterFontSize(2));
		make.left.mas_equalTo(view).with.offset(0);
		make.right.mas_equalTo(view).with.offset(0);
		make.height.mas_equalTo(kAdapterFontSize(25));
	}];
	[self.headBlackView addSubview:self.headBlackViewBGView];
	[self.headBlackViewBGView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.headBlackView);
	}];
	[self.headBlackView addSubview:self.subTitleView];
	[self.subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headBlackView).with.offset(kAdapterFontSize(10));
		make.centerY.equalTo(self.headBlackView);
		make.size.mas_equalTo(CGSizeMake(kAdapterFontSize(20), kAdapterFontSize(20)));
	}];
	
	[self.headBlackView addSubview:self.radioLabel];
	[self.radioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headBlackView).with.offset(kAdapterFontSize(35));
		make.centerY.mas_equalTo(self.headBlackView);
		make.right.mas_equalTo(self.headBlackView).with.offset(-kAdapterFontSize(10));
		make.height.mas_equalTo(20);
	}];
	
	[self.headBlackView addSubview:self.radioButton];
	[self.radioButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.headBlackView);
	}];
	
	[view addSubview:self.headImageView];
	[self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.headBlackView.mas_bottom);
		make.left.equalTo(view);
		make.right.equalTo(view);
		make.bottom.equalTo(view);
	}];
    
    [self.headImageView addSubview:self.headImageViewTop];
    [self.headImageViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(self.headImageView.mas_height).multipliedBy(0.9);
        make.width.mas_equalTo(self.headImageView).multipliedBy(0.9);
    }];
	
	[view addSubview:self.headImageButton];
	[self.headImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.headImageView);
	}];
}

- (void)addRedEnvelopeView {
	[self.view addSubview:self.redEnvelopeView];
	[self.redEnvelopeView addSubview:self.redEnvelopeButton];
	[self.redEnvelopeButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.redEnvelopeView);
		make.centerX.equalTo(self.redEnvelopeView);
		make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.12, [UIScreen mainScreen].bounds.size.width * 0.12));
	}];
	[self.redEnvelopeView addSubview:self.redEnvelopeTimeLabel];
	[self.redEnvelopeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.redEnvelopeButton.mas_bottom);
		make.left.right.bottom.equalTo(self.redEnvelopeView);
	}];
}

- (void)addFloatingView {
	[self.view addSubview:self.footerPromptView];
	[self.footerPromptView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.customCollectionView.mas_bottom);
		make.bottom.equalTo(self.view);
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		
	}];
	UIView *topLine = [[UIView alloc] init];
	topLine.backgroundColor = MCUIColorWithRGB(235, 233,216,1.0);
	[self.footerPromptView addSubview:topLine];
	[topLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.equalTo(self.footerPromptView);
		make.height.mas_equalTo(0.5);
	}];
	UIImageView *imgView = [[UIImageView alloc] init];
	imgView.image = [UIImage imageNamed:@"中奖公告"];
	[self.footerPromptView addSubview:imgView];
	[imgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.footerPromptView).offset(2);
		make.centerY.mas_equalTo(self.footerPromptView);
		make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.1, [UIScreen mainScreen].bounds.size.width * 0.07));
	}];
	[self.footerPromptView addSubview:self.tipsView];
	
	
}

- (void)addRedEnvelopeView: (NSDictionary *)dataDict {
	[self.redEnvelopeButton sd_setImageWithURL:[NSURL URLWithString:dataDict[@"image_url"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"index-2-2-1"]];
	NSString *countDownNumStr = [dataDict objectForKey:@"reserved"];
	__block int countDowmNum = [self changeTimeStrToInt:countDownNumStr];
	[self.redEnvelopeTimer invalidate];
	self.redEnvelopeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
		countDowmNum -= 1;
		self.redEnvelopeTimeLabel.text = [self currentTimeString:countDowmNum];
		if (countDowmNum <= 0) {
			[timer invalidate];
			[self.redEnvelopeView removeFromSuperview];
		}
	}];
	[self addRedEnvelopeView];
}

- (NSString *)currentTimeString:(int)countNum {
	if (countNum <= 0) {
		return @"00:00:00";
	} else {
		int day = (int)countNum / (24 * 3600);
		int hours =  (int)countNum / 3600 % 24;
		int minutes =  (int)(countNum - day * 24 * 3600 - hours * 3600) / 60;
		int seconds = (int)(countNum - day * 24 * 3600 - hours * 3600 - minutes*60);
		NSString *str;
		if (day > 0) {
			str = [NSString stringWithFormat:@"%02d天%02d:%02d:%02d",day ,hours, minutes, seconds];
		} else {
			str = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
		}
		return str;
	}
}

- (void)addSignInView {
	self.signInView = [[SignInView alloc] init];
	[UIApplication.sharedApplication.keyWindow addSubview:self.signInView];
	[self.signInView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(UIApplication.sharedApplication.keyWindow);
	}];
}
#pragma mark - 点击事件
#pragma mark 重新请求网络按钮点击
- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
//    [super KKAbnormalNetworkView_hitReloadButtonMethod];
	[self networkSetting];
    [self getAllCollectionItems:YES isRefresh:NO];
}

#pragma mark 点击广播
- (void)radioClick {
	[self.view.window addSubview:self.radioView];
	self.radioView.type_topLabel.text = self.radioDic[@"content"];
	[self.radioView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.view.window);
	}];
}
#pragma mark 点击新人礼包
- (void)imgClick {
	if (self.gifURL.length > 0) {
		MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
        NSString *token = [MCTool BSGetUserinfo_token];
        if(token.length == 0){
           mch5Vc.url = self.gifURL;
        }else{
           mch5Vc.url = [NSString stringWithFormat:@"%@?user_token=%@",self.gifURL,token];
        }
		[self.navigationController pushViewController:mch5Vc animated:YES];
	}
}

#pragma mark 点击红包
- (void)redEnvelopeClick {
	if (![[self.redEnvelopeDict objectForKey:@"turn_url"] isEqualToString:@""]) {
		MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
        NSString *token = [MCTool BSGetUserinfo_token];
        if(token.length == 0){
            mch5Vc.url = [self.redEnvelopeDict objectForKey:@"turn_url"];
        }else{
            mch5Vc.url = [NSString stringWithFormat:@"%@?user_token=%@",[self.redEnvelopeDict objectForKey:@"turn_url"],token];
        }
		
		[self.navigationController pushViewController:mch5Vc animated:YES];
	}
}

#pragma mark - 代理事件
#pragma mark SDCycleScrollViewDelegate
// 点击图片代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
	HomepageBannerModel *model = self.bannerArrayM[index];
	
	if (![model.target_url isEqualToString:@""]) {
		MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
        NSString *token = [MCTool BSGetUserinfo_token];
        if(token.length == 0){
            mch5Vc.url = model.target_url;
        }else{
            mch5Vc.url = [NSString stringWithFormat:@"%@?user_token=%@", model.target_url,token];
        }
		
		[self.navigationController pushViewController:mch5Vc animated:YES];
	}
	
}

#pragma mark BannerDetailTableViewCellDelegate
-(void)BannerDetailTableViewCellButtonClick:(NSInteger)row andSection:(NSInteger)section{
	MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
	BannerButtonModel *model = self.dataArray[self.selectSection][self.selectIndex];
	NSArray *detailArr = model.child;
	NSDictionary * dict = detailArr[row];
	
	if (![dict[@"target"] isEqualToString:@""]) {
		mch5Vc.titleStr = dict[@"name"];
		mch5Vc.url = dict[@"target"];
		[self.navigationController pushViewController:mch5Vc animated:YES];
		
	}
}
#pragma mark 获取单个锁盘时间
- (void)getlockTimeWithLotteryId:(NSString *)lotteryId {
	NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"gc/cp-lock-time"];
	NSDictionary *param = @{@"lottery_id": lotteryId};
	[MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSArray *dataArr = (NSArray *)data;
        if(dataArr.count == 0){
            return ;
        }
        for (HomeButtonModel *model in self.dataArray) {
            if ([model.lottery_type isEqual:lotteryId]) {
                for(NSDictionary *dataDict in dataArr){
                    for (HomeButtonModel *subModel in model.sub_lottery) {
                        if ([subModel.lottery_id isEqual:dataDict[@"lottery_id"]]) {
                            subModel.countNum = [self changeTimeStrToInt:dataDict[@"lock_time"]];
                            break;
                        }
                    }
                }
            }
            
        }
	} dislike:^(id data) {
	} failure:^(NSError *error) {
	}];
}

#pragma mark 点击补助金
- (void)grantsButtonClick {
    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        if (![[MCTool BSGetObjectForKey:BSConfig_bzjlq_url] isEqualToString:@""]) {
            MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
            NSString * token = [MCTool BSGetUserinfo_token];
            if (token.length > 0) {
                mch5Vc.url = [NSString stringWithFormat:@"%@?user_token=%@", [MCTool BSGetObjectForKey:BSConfig_bzjlq_url],token];
            }else{
                mch5Vc.url = [MCTool BSGetObjectForKey:BSConfig_bzjlq_url];
            }
            
            [self.navigationController pushViewController:mch5Vc animated:YES];
        }
    } else {
        KKLoginViewController *login = [[KKLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark collectionView 每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (collectionView == self.customCollectionView && section == ceil((double)(self.dataArray.count)/numberOfItemsInSection)) {
		return 1;
	} else if (collectionView == self.customCollectionView && section == ceil((double)(self.dataArray.count)/numberOfItemsInSection) + 1) {
		return 1;
	} else if (collectionView == self.customCollectionView && section == ceil((double)(self.dataArray.count)/numberOfItemsInSection) - 1) {
        if (self.dataArray.count %3 == 0 &&self.dataArray.count >3) {
            return 3;
        }else{
            return self.dataArray.count % 3;
        }
	} else {
		return numberOfItemsInSection;
	}
}
#pragma mark collectionView 多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	if (collectionView == self.customCollectionView) {
		return ceil((double)self.dataArray.count / numberOfItemsInSection) + 2;
	} else {
		return ceil((double)self.subDataArray.count / numberOfItemsInSection);
	}
}
#pragma mark collectionView item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (collectionView == self.customCollectionView && indexPath.section == ceil((double)(self.dataArray.count)/ numberOfItemsInSection)) {
		return CGSizeMake(MCScreenWidth - kAdapterFontSize(20) * 2, MCScreenWidth / 10);
	} else if (collectionView == self.customCollectionView && indexPath.section == ceil((double)(self.dataArray.count)/ numberOfItemsInSection) + 1) {
		return CGSizeMake(MCScreenWidth - kAdapterFontSize(20) * 2, MCScreenWidth / 5);
	} else {
		return CGSizeMake((MCScreenWidth - kAdapterFontSize(20) * 2 ) / numberOfItemsInSection, itemHeight);
	}
}
#pragma mark collectionView header大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
	if (collectionView == self.customCollectionView) {
		if (section == 0) {
			return CGSizeMake(MCScreenWidth, MCScreenWidth * 0.85);
		} else if (section == ceil((double)(self.dataArray.count) / numberOfItemsInSection) || section == ceil((double)(self.dataArray.count) / numberOfItemsInSection) + 1) {
			return CGSizeMake(MCScreenWidth, MCScreenWidth * 0.02);
		} else {
			return CGSizeZero;
		}
	} else {
		return CGSizeZero;
	}
	
}
#pragma mark collectionView footer大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
	if (collectionView == self.customCollectionView) {
		if (self.selectedIndexPath != nil && self.selectedIndexPath.section == section) {
			return CGSizeMake(MCScreenWidth, itemHeight * ceil((double)self.subDataArray.count / numberOfItemsInSection));
		} else {
			return CGSizeZero;
		}
	} else {
		return CGSizeZero;
	}
}
#pragma mark collectionView item最小内边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 0;
}
#pragma mark collectionView footerView和headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	if (collectionView == self.customCollectionView) {
		if ([kind isEqual:UICollectionElementKindSectionHeader]) {
			if (indexPath.section == ceil((double)(self.dataArray.count)/numberOfItemsInSection) || indexPath.section == ceil((double)(self.dataArray.count)/numberOfItemsInSection) + 1) {
				UICollectionReusableView *twoHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footHeaderView forIndexPath:indexPath];
				for (UIView *view in twoHeaderView.subviews) {
					[view removeFromSuperview];
				}
				twoHeaderView.backgroundColor = [UIColor clearColor];
				return twoHeaderView;
			}else if (indexPath.section == 0) {
				UICollectionReusableView *oneHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerView forIndexPath:indexPath];
				oneHeaderView.backgroundColor = [UIColor clearColor];
				[self addHeaderModuleWithHeaderView:oneHeaderView];
				return oneHeaderView;
			} else {
				return nil;
			}
		} else {
			UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewName forIndexPath:indexPath];
			for (UIView *view in footerView.subviews) {
				[view removeFromSuperview];
			}
			UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
			self.footerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MCScreenWidth - 40, itemHeight * ceil((double)self.subDataArray.count / numberOfItemsInSection)) collectionViewLayout:layout];
			self.footerCollectionView.backgroundColor = MCUIColorFromRGB(0xE6D9D2);
			self.footerCollectionView.dataSource = self;
			self.footerCollectionView.delegate = self;
			[self.footerCollectionView registerClass:[AnotherVersionHomeCollectionViewCell class] forCellWithReuseIdentifier:footerCellName];
			[footerView addSubview: self.footerCollectionView];
			footerView.clipsToBounds = YES;
			return footerView;
		}
	} else {
		return nil;
	}
}
#pragma mark collectionView cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger index = indexPath.section * numberOfItemsInSection + indexPath.row;
	if (collectionView == self.customCollectionView) {
		if (indexPath.section == ceil((double)(self.dataArray.count)/numberOfItemsInSection)) {
			HomeCollectionViewWinningCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName3 forIndexPath:indexPath];
			[cell.contentView addSubview:self.tipsView];
			[cell.contentView bringSubviewToFront:self.tipsView];
			return cell;
		} else if (indexPath.section == ceil((double)(self.dataArray.count)/numberOfItemsInSection) + 1) {
			HomeCollectionViewHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName2 forIndexPath:indexPath];
			if (self.userRankArray.count > 0) {
				[cell loadData:self.userRankArray.firstObject];
			} else {
				[cell loadData:self.userRankArray];
			}
			cell.delegate = self;
			return cell;
		}
		AnotherVersionHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
		if (self.dataArray.count > index) {
			[cell loadData:self.dataArray[index] indexPath:indexPath];
		} else {
			[cell loadData:nil indexPath:indexPath];
		}
		cell.contentView.backgroundColor = [UIColor clearColor];
		if (indexPath == self.selectedIndexPath) {
			cell.isHiddened = NO;
		} else {
			cell.isHiddened = YES;
		}
		return cell;
	} else {
		AnotherVersionHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:footerCellName forIndexPath:indexPath];
		if (index < self.subDataArray.count) {
			[cell loadData:self.subDataArray[index] indexPath:indexPath];
		}
		cell.contentView.backgroundColor = MCUIColorFromRGB(0xE6D9D2);
		return cell;
	}
}
#pragma mark collectionView 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger index = indexPath.section * numberOfItemsInSection + indexPath.row;
	if (index >= self.dataArray.count) {
		return;
	}
	if (collectionView == self.customCollectionView) {
		if (indexPath.section == ceil((double)(self.dataArray.count)/numberOfItemsInSection)) {
			return;
		}
		HomeButtonModel *model;
		if (self.dataArray.count > index) {
			model = self.dataArray[index];
		}
        
		if ([model.lottery_type  isEqual:@"10"]) {
			LotteryDetailPK10ViewController *lotteryPk10Vc = [[LotteryDetailPK10ViewController alloc]init];
			lotteryPk10Vc.lottery_id = model.lottery_id;
			lotteryPk10Vc.titleStr = model.lottery_label;
			[self.navigationController pushViewController:lotteryPk10Vc animated:YES];
			return;
		}
		if ([model.lottery_type isEqual:@"6"]) {
			LotteryDetailLHCViewController *lotteryKL10FVc = [[LotteryDetailLHCViewController alloc]init];
			lotteryKL10FVc.lottery_id = model.lottery_id;
			lotteryKL10FVc.titleStr = model.lottery_label;
			[self.navigationController pushViewController:lotteryKL10FVc animated:YES];
			return;
		}
		
		if (self.selectedIndexPath == indexPath) {
			self.selectedIndexPath = nil;
		} else {
			self.selectedIndexPath = indexPath;
			HomeButtonModel *model = self.dataArray[index];
			self.subDataArray = model.sub_lottery;
		}
		[self.customCollectionView reloadData];
		[self.footerCollectionView reloadData];
	} else {
		HomeButtonModel *model;
		if (self.subDataArray.count > index) {
			model = self.subDataArray[index];
		}
		if ([model.lottery_name containsString:@"28"]) {
			LotteryDetailBJ28ViewController *controller = [[LotteryDetailBJ28ViewController alloc]init];
			controller.lottery_id = model.lottery_id;
			controller.titleStr = model.lottery_name;
			controller.lottery_type = model.lottery_type;
			[self.navigationController pushViewController:controller animated:YES];
			return;
		}
		if ([model.lottery_name containsString:@"时时彩"]) {
			LotteryDetailTabViewController *lotteryDetailTabVc = [[LotteryDetailTabViewController alloc]init];
			lotteryDetailTabVc.titleStr = model.lottery_name;
			lotteryDetailTabVc.lottery_id = model.lottery_id;
			lotteryDetailTabVc.lottery_type = model.lottery_type;
			[self.navigationController pushViewController:lotteryDetailTabVc animated:YES];
			return;
		}
		if ([model.lottery_name containsString:@"11选5"]) {
			LotteryDetail11X5ViewController *lotteryKL10FVc = [[LotteryDetail11X5ViewController alloc]init];
			lotteryKL10FVc.lottery_id = model.lottery_id;
			lotteryKL10FVc.titleStr = model.lottery_name;
			lotteryKL10FVc.lottery_type = model.lottery_type;
			[self.navigationController pushViewController:lotteryKL10FVc animated:YES];
			return;
		}
		if ([model.lottery_name containsString:@"快"]) {
			LotteryDetailK3ViewController *lotteryKL10FVc = [[LotteryDetailK3ViewController alloc]init];
			lotteryKL10FVc.lottery_id = model.lottery_id;
			lotteryKL10FVc.titleStr = model.lottery_name;
			lotteryKL10FVc.lottery_type = model.lottery_type;
			[self.navigationController pushViewController:lotteryKL10FVc animated:YES];
			return;
		}
	}
}

#pragma mark - 懒加载

- (UIView *)cellBgView {
	if (_cellBgView == nil) {
		_cellBgView = [[UIView alloc] init];
		_cellBgView.backgroundColor = [UIColor whiteColor];
	}
	return _cellBgView;
}

- (UIImageView *)bannerBgView {
	if (_bannerBgView == nil) {
		_bannerBgView = [[UIImageView alloc] init];
		_bannerBgView.image = [UIImage imageNamed:@"bannerBG"];
		_bannerBgView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _bannerBgView;
}

- (SDCycleScrollView *)cycleScrollView {
	if (_cycleScrollView == nil) {
		_cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
		_cycleScrollView.infiniteLoop = YES;
		_cycleScrollView.autoScrollTimeInterval = 3;
		_cycleScrollView.pageControlDotSize = CGSizeMake(5, 5);
		_cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"Home_banner_long"];
		_cycleScrollView.pageDotImage = [UIImage imageNamed:@"Home_banner_short"];
		_cycleScrollView.layer.cornerRadius = kAdapterFontSize(5);
		_cycleScrollView.layer.masksToBounds = true;
	}
	return _cycleScrollView;
}

- (UIView *)headBlackView {
	if (_headBlackView == nil) {
		_headBlackView = [[UIView alloc] init];
		_headBlackView.backgroundColor = [UIColor clearColor];
		_headBlackView.layer.masksToBounds = true;
	}
	return _headBlackView;
}

- (UIImageView *)headBlackViewBGView {
	if (_headBlackViewBGView == nil) {
		_headBlackViewBGView = [[UIImageView alloc] init];
		_headBlackViewBGView.image = [UIImage imageNamed:@"图层"];
		_headBlackViewBGView.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _headBlackViewBGView;
}

- (UIImageView *)subTitleView {
	if (_subTitleView == nil) {
		_subTitleView = [[UIImageView alloc] init];
		_subTitleView.image = [UIImage imageNamed:@"消息推送"];
		_subTitleView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _subTitleView;
}

- (AutoScrollLabel *)radioLabel {
	if (_radioLabel == nil) {
		_radioLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, MCScreenWidth, 21)];
		_radioLabel.textColor = MCUIColorBlack;
		_radioLabel.font = MCFont(kAdapterFontSize(12));
	}
	return _radioLabel;
}

- (UIButton *)radioButton {
	if (_radioButton == nil) {
		_radioButton = [[UIButton alloc] init];
		_radioButton.backgroundColor = [UIColor clearColor];
		[_radioButton addTarget:self action:@selector(radioClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _radioButton;
}

- (RodiaView *)radioView {
	if (_radioView == nil) {
		_radioView = [[RodiaView alloc] init];
		_radioView.backgroundColor = [UIColor clearColor];
	}
	return _radioView;
}

- (UIImageView *)headImageView {
	if (_headImageView == nil) {
		_headImageView = [[UIImageView alloc] init];
	}
	return _headImageView;
}

- (UIImageView *)headImageViewTop{
    if(_headImageViewTop == nil){
        _headImageViewTop = [UIImageView new];
    }
    return _headImageViewTop;
}

- (UIButton *)headImageButton {
	if (_headImageButton == nil) {
		_headImageButton = [[UIButton alloc] init];
		[_headImageButton addTarget:self action:@selector(imgClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _headImageButton;
}

- (CMMessageTipsView *)tipsView {
	if (_tipsView == nil) {
		_tipsView = [[CMMessageTipsView alloc] initWithFrame:CGRectMake(MCScreenWidth * 0.1 + kAdapterFontSize(10), MCScreenWidth * 0.025, MCScreenWidth * 0.9 - kAdapterFontSize(40), kAdapterFontSize(20))];
		_tipsView.backgroundColor = [UIColor clearColor];
		_tipsView.Delay = 2;
	}
	return _tipsView;
}

- (UIButton *)redEnvelopeButton {
	if (_redEnvelopeButton == nil) {
		_redEnvelopeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		NSString *imgName = @"index-2-2-1";
		UIImage *img = [UIImage imageNamed:imgName];
		[_redEnvelopeButton setImage:img forState:UIControlStateNormal];
		[_redEnvelopeButton setTitle:@"" forState:UIControlStateNormal];
		_redEnvelopeButton.backgroundColor = [UIColor clearColor];
		[_redEnvelopeButton addTarget:self action:@selector(redEnvelopeClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _redEnvelopeButton;
}

- (UILabel *)redEnvelopeTimeLabel {
	if (_redEnvelopeTimeLabel == nil) {
		_redEnvelopeTimeLabel = [[UILabel alloc] init];
		_redEnvelopeTimeLabel.textAlignment = NSTextAlignmentCenter;
		_redEnvelopeTimeLabel.textColor = [UIColor colorWithRed:255/255.0 green:32/255.0 blue:0/255.0 alpha:1.0];
		_redEnvelopeTimeLabel.font = MCFont(kAdapterFontSize(12));
	}
	return _redEnvelopeTimeLabel;
}

- (WMDragView *)redEnvelopeView {
	if (_redEnvelopeView == nil) {
		_redEnvelopeView = [[WMDragView alloc] initWithFrame:CGRectMake(MCScreenWidth * 0.7, MCScreenHeight * 0.7, MCScreenWidth * 0.23, MCScreenWidth * 0.15)];
		_redEnvelopeView.isKeepBounds = YES;
		_redEnvelopeView.backgroundColor = [UIColor clearColor];
	}
	return _redEnvelopeView;
}

- (UIView *)footerPromptView {
	if (_footerPromptView == nil) {
		_footerPromptView = [[UIView alloc] init];
		_footerPromptView.backgroundColor = [UIColor whiteColor];
	}
	return _footerPromptView;
}


- (UICollectionView *)customCollectionView {
	if (_customCollectionView == nil) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		
		_customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_customCollectionView.showsHorizontalScrollIndicator = false;
		_customCollectionView.showsVerticalScrollIndicator = false;
		_customCollectionView.alwaysBounceVertical = true;
		_customCollectionView.dataSource = self;
		_customCollectionView.delegate = self;
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            [self networkSetting];
            [self getAllCollectionItems:YES isRefresh:YES];
        }];
        header.stateLabel.textColor = [UIColor whiteColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
        _customCollectionView.mj_header = header;
		[_customCollectionView registerClass:[AnotherVersionHomeCollectionViewCell class] forCellWithReuseIdentifier:cellName];
		[_customCollectionView registerClass:[HomeCollectionViewHeadCell class] forCellWithReuseIdentifier:cellName2];
		[_customCollectionView registerClass:[HomeCollectionViewWinningCell class] forCellWithReuseIdentifier:cellName3];
		[_customCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerView];
		[_customCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:footHeaderView];
		[_customCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewName];
		_customCollectionView.backgroundColor = [UIColor clearColor];
	}
	return _customCollectionView;
}
@end
