//
//  LotteryDetailLHCViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryDetailLHCViewController.h"
#import "LotteryDetailLHCCollectionViewCell.h"
#import "ChaseLotteryViewController.h"
#import "HistoryOfTheLotteryView.h"
#import "KeyBoardView.h"
#import "HeadView.h"
#import "LHCFooterView.h"
#import "BouncedView.h"
#import "LHCLotteryModel.h"
#import "GameSelectModel.h"
#import "GameSelectViewController.h"
#import "KKAccountDetailToolTipView.h"
#import "NextTheLotteryModel.h"
#import "HistpryOfTheLotteryModel.h"
#import "ChaseLotteryViewController.h"
#import "WaveColorCollerctionViewCell.h"
#import "RodiaView.h"
#import "HeadButton.h"
#import "LotteryAlgorithm.h"
#import "LHCBettingViewController.h"
#import "LHCManager.h"
#import "LHCCollectionReusableView.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ChineseZodiacCollerctionViewCell.h"
#import "KKLotteryDetailScrollView.h"
#import "KKLotteryDetailHeaderView.h"
#import "LotteryTimeView.h"
#import "BaseLotterHistoryMananger.h"
#import "KKTrend_historyViewController.h"
#define kReuseCollectionCell @"collectionCell4"
#define kCellReuseWave @"waveCell"
#define kHeaderReuseId @"Header"
#define kCellReuseChinese @"chinsesCell"
@interface LotteryDetailLHCViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LHCFooterViewDelegate,HeadViewDelegate,LotteryDetail4CollectionViewCellDelegate,LotteryTimeViewDelegate>

@property(nonatomic,strong)LotteryTimeView *timeView;
@property(nonatomic ,strong)HeadView *headView;
@property(nonatomic,strong)LHCFooterView *footView;
@property(nonatomic,strong)   KKAccountDetailToolTipView *toolTipView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)GameSelectModel *model;
@property (nonatomic,strong)BouncedView *bounceView;
@property(nonatomic,strong)NextTheLotteryModel *nextLotteryModel;

@property(nonatomic,strong)NSString *bet_number;//投注的号码
@property(nonatomic,assign) BOOL isCaps;
@property(nonatomic ,strong)NSArray *wf_pl;
@property(nonatomic,assign)NSInteger selectAllCount;//选择了多少注
@property(nonatomic,copy)NSString *selectTitleStr;
@property(nonatomic,strong)RodiaView *rodiaView;

@property(nonatomic,strong)UIView *tableHeadView;
@property(nonatomic,strong)NSMutableArray *playdDataArray;//所有玩法
@property(nonatomic,strong)NSMutableArray *playTitleArray;//玩法的名称

@property(nonatomic,strong)NSMutableArray *ChineseZodiacArray;
@property(nonatomic,strong)LHCCollectionReusableView *headCellView;
@property(nonatomic,assign)BOOL isChineseHX;//是否是合肖

@property(nonatomic,assign)NSInteger judgeSelectRow;//判断选多少个号码算一注

@property(nonatomic,strong)KKLotteryDetailScrollView *detailScrollView;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation LotteryDetailLHCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadLotteryTime];
    
    [self regiestNotic];
    [self sendNetWorkingAllPlay];
    [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(18, 18) target:self selected:@selector(leftItemClicked) image:@"Reuse_Back" isLeft:YES];
    
    [self startTimer];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isCaps = YES;
    [self stopTimer];
}


-(void)startTimer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(startDaoji) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
}
-(void)stopTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)startDaoji{
    [BaseLotterHistoryMananger getLotteryHistoryDataWithLotteryId:self.lottery_id successBlock:^(NSMutableArray *dataSource) {
        _detailScrollView.dataSource = dataSource;
    }];
}


- (void)leftItemClicked {
    LHCManager *manage = [LHCManager sharedManager];
    if (manage.LHCDataArray.count>0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"退出将取消开始选择的号码是否退出?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [manage.LHCDataArray removeAllObjects];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alertController addAction:confirmAction];
        [alertController addAction:cancelAction];
        
        [self.navigationController presentViewController:alertController animated:true completion:nil];
 
    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)regiestNotic{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadLotteryTime) name:@"RELOADSSCTIME" object:nil];
}
-(void)dealloc{
    //只要注册通知一定要移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.selectAllCount = 0;
    [self deleteClick];
}

//获取所有玩法
- (void)sendNetWorkingAllPlay {
    
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cz-wf-lhc28"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 };
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSString *title = nil;
        NSString *name = nil;
        [self.playdDataArray removeAllObjects];
        for (NSDictionary *dict in data) {
            [self.playTitleArray addObject:dict[@"name"]];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArr = dict[@"wf"];
            for (int i=0 ; i<dataArr.count ; i++) {
                NSDictionary *dict1 = dataArr[i];
//                if ([dict1[@"wf_flag"]  isEqual: @"xglhc_tema_xuma"]) {
//                    self.wf_flag = dict1[@"wf_flag"];
//                    self.wf_pl = dict1[@"wf_pl"];
//                    title = dict[@"name"];
//                    name = dict1[@"name"];
//                }
                GameSelectDetailModel *model = [[GameSelectDetailModel alloc]initWithDictionary:dict1 error:nil];
                [array addObject:model];
            }
            [self.playdDataArray addObject:array];
        }
        NSArray *modelArr = [[NSUserDefaults standardUserDefaults]objectForKey:self.lottery_id];
        if(modelArr.count){
            NSString *wf_flag = modelArr[0];
            //检查所有已请求到的完法中有没有上次做存的玩法
            for (int i = 0; i < self.playdDataArray.count; i ++) {
                NSArray *a = [self.playdDataArray objectAtIndex:i];
                for (int j = 0; j < a.count; j ++) {
                    GameSelectDetailModel *model  = [a objectAtIndex:j];
                    if ([model.wf_flag isEqualToString:wf_flag]) {
                        self.wf_flag = modelArr[0];
                        self.wf_pl = modelArr[1];
                        name = modelArr[2];
                        title = modelArr[3];
                        self.judgeSelectRow = [modelArr[4] integerValue];
                        break;
                    }
                }
            }
        }
        if (self.wf_flag.length == 0||self.wf_pl.count == 0) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.lottery_id];
            if (self.playdDataArray.count > 0) {
                for (int i = 0;  i < self.playdDataArray.count ; i++) {
                    NSArray *array = [self.playdDataArray objectAtIndex:i];
                    if (array.count > 0) {
                        GameSelectDetailModel *model  = [array objectAtIndex:0];
                        self.wf_flag = model.wf_flag;
                        self.wf_pl = model.wf_pl;
                        name = model.name;
                        title = model.name;
                        self.judgeSelectRow = [model.selectRow integerValue];
                        break;
                    }
                }
            }
        }
        
        
//        if(modelArr.count){
//            self.wf_flag = modelArr[0];
//            self.wf_pl = modelArr[1];
//            name = modelArr[2];
//            title = modelArr[3];
//            self.judgeSelectRow = [modelArr[4] integerValue];
//        }
        [self sendNetWorking:name andtitle:title];
        if ([self.wf_flag isEqual:@"xglhc_zhxiao_zx"]|| [self.wf_flag hasSuffix:@"lx"]||[self.wf_flag isEqual:@"xglhc_texiao_tx"]||[self.wf_flag isEqual:@"xglhc_hexiao_hx"]){
            [self createChineseZodiacData];
        }
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)switchClick:(UIButton *)sender {
    GameSelectViewController *gameSelectVc = [[GameSelectViewController alloc]init];
    gameSelectVc.dataArray = self.playdDataArray;
    gameSelectVc.titleArray = self.playTitleArray;
    gameSelectVc.lottery_id = self.lottery_id;
    gameSelectVc.selectItemClick = ^(GameSelectDetailModel *model){
        self.isChineseHX = NO;
        self.judgeSelectRow = [model.selectRow integerValue];
        [self.dataArray removeAllObjects];
        [self.ChineseZodiacArray removeAllObjects];
        self.wf_flag = model.wf_flag;
        self.wf_pl = model.wf_pl;
        [self sendNetWorking:model.name andtitle:model.title];
  
        if ([self.wf_flag isEqual:@"xglhc_zhxiao_zx"]|| [self.wf_flag hasSuffix:@"lx"]||[self.wf_flag isEqual:@"xglhc_texiao_tx"]||[self.wf_flag isEqual:@"xglhc_hexiao_hx"]){
            [self createChineseZodiacData];
        }
        
    };

    [self.navigationController pushViewController:gameSelectVc animated:YES];

}
-(void)promptClick:(UIButton *)sender {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"wf-explain/lhc-wf"];
    
    if (![urlStr isEqualToString:@""]) {
        
        MCH5ViewController * vc = [[MCH5ViewController alloc] init];
        vc.url = urlStr;
        vc.titleStr = @"玩法说明";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)createChineseZodiacData{
    //加载生肖数据把value和flag赋值给Model
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/sx-lhc"];
    NSDictionary *parameters = @{
                                 @"tel" :@""
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameters andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSArray *dataArr = data;
        [self.ChineseZodiacArray removeAllObjects];
        for (int i =0; i<12; i++) {
            NSDictionary *dict = dataArr[i];

            if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"]|| [self.wf_flag hasSuffix:@"lx"]) {
                LHCLotteryModel *model = [[LHCLotteryModel alloc]init];
                LHCLotteryModel *lhcModel = self.dataArray[0];
                model.award_money = lhcModel.award_money;
                model.value = dict[@"value"];
                model.flag = dict[@"flag"];
                model.isAlreadyGetData = YES;
                [self.ChineseZodiacArray addObject:model];
            }else{
            LHCLotteryModel *lhcModel;
            //判断是否只有一组数据，一组数据就加载第一个
            if (self.dataArray.count == 1) {
                lhcModel = self.dataArray[0];
            }else{
               lhcModel = self.dataArray[i];
            }
            lhcModel.value = dict[@"value"];
            lhcModel.flag = dict[@"flag"];
            }
        }
     
        [self.collectionView reloadData];
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)reloadLotteryTime{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cp-lock-time"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        self.nextLotteryModel = [[NextTheLotteryModel alloc]initWithDictionary:data error:nil];
        [self.timeView setPeriod:[NSString stringWithFormat:@"距%@期开奖",self.nextLotteryModel.lottery_qh] andTime:self.nextLotteryModel.lock_time andEndTimer:self.nextLotteryModel.plan_kj_time];
        self.isCaps = NO;
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}
-(void)sendNetWorking:(NSString *)wf_pl andtitle:(NSString *)title{
    [self.dataArray removeAllObjects];
    for (NSDictionary *dict in self.wf_pl) {
        LHCLotteryModel *model = [[LHCLotteryModel alloc]init];
        model.award_money = dict[@"award_money"];
        model.pl_name = dict[@"pl_name"];
        model.pl_flag = dict[@"pl_flag"];
        model.wf_flag = self.wf_flag;
        model.isAlreadyGetData = YES;
        model.species = [NSString stringWithFormat:@"%@-%@",title,wf_pl];
        [self.dataArray addObject:model];
    }
    
    NSString *strPlayValue = wf_pl;
    if (strPlayValue.length <= 3) {
        strPlayValue = [NSString stringWithFormat:@"%@   ",strPlayValue];
    }
    NSString *str1 = [NSString stringWithFormat:@"当前玩法:%@",strPlayValue];
    self.headView.currentPlayLabel.text = str1;
    
    if ([self.wf_flag hasPrefix:@"xglhc_lm"] ||[self.wf_flag isEqual:@"xglhc_zxbz_zxbz"]) {
        [self.dataArray removeAllObjects];
        NSDictionary *dict = self.wf_pl[0];
        for (int i=1; i<50; i++) {
            LHCLotteryModel *model = [[LHCLotteryModel alloc]init];
            model.award_money = dict[@"award_money"];
            if (i<10) {
               model.pl_name = [NSString stringWithFormat:@"0%d",i];
            }else{
            model.pl_name = [NSString stringWithFormat:@"%d",i];
            }
            model.pl_flag = dict[@"pl_flag"];
            model.wf_flag = self.wf_flag;
            model.isAlreadyGetData = YES;
            model.species = [NSString stringWithFormat:@"%@-%@",title,wf_pl];
            [self.dataArray addObject:model];
        }
    }
    if ([self.wf_flag hasSuffix:@"lw"]) {
        [self.dataArray removeAllObjects];
        NSDictionary *dict = self.wf_pl[0];
        for (int i=0; i<10; i++) {
            LHCLotteryModel *model = [[LHCLotteryModel alloc]init];
            model.award_money = dict[@"award_money"];
            model.pl_name = [NSString stringWithFormat:@"%d尾",i];
            model.pl_flag = dict[@"pl_flag"];
            model.wf_flag = self.wf_flag;
            model.isAlreadyGetData = YES;
            model.species = [NSString stringWithFormat:@"%@-%@",title,wf_pl];
            [self.dataArray addObject:model];
        }
    }
    if (![self.wf_flag isEqual:@"xglhc_sebo_sebo"]){
         [self.collectionView reloadData];
        
    }
    [_detailScrollView updateFrameWithDataCount:self.dataArray.count andRowHeight:0];
}
-(void)initUI{
    
    [self.view addSubview:self.timeView];
    self.collectionView.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 30 - 64);
    CGFloat footerH = IS_IPHONE_X ? 42+30 : 42;
    KKLotteryDetailScrollView *detailScrollView = [[KKLotteryDetailScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, MCScreenHeight - 30 - footerH -64) HeaderView:[KKLotteryDetailHeaderView new]headerHeight:300 viewController:self subView:self.collectionView];
    [self.view addSubview:detailScrollView];
    _detailScrollView = detailScrollView;
    
    [self.view addSubview:self.footView];
    
    [BaseLotterHistoryMananger getLotteryHistoryDataWithLotteryId:self.lottery_id successBlock:^(NSMutableArray *dataSource) {
        _detailScrollView.dataSource = dataSource;
    }];
    
    WeakObject(self);
    //点击历史面板
    _detailScrollView.didClickShowMoreDataBtnBlock = ^{
        KKTrend_historyViewController * history = [[KKTrend_historyViewController alloc] init];
        history.lottery_id = weakObject.lottery_id;
        history.lottery_name = weakObject.titleStr;
        [weakObject.navigationController pushViewController:history animated:YES];
    };
}


#pragma mark UICollectionView
// 返回 头部/尾部 视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"]){
            self.headCellView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderReuseId forIndexPath:indexPath];
            self.headCellView.hidden = NO;
            [self.headCellView addSubview:self.headView];
            return self.headCellView;
        }else{
            UICollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"normalHeader" forIndexPath:indexPath];
            for (UIView *view in headerView.subviews) {
                [view removeFromSuperview];
            }
           [headerView addSubview:self.headView];
            return headerView;
        }
        
        
        
    }else{
        return nil;
    }
        //创建头视图
    
    
}
//设置section头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"]){
        return CGSizeMake(MCScreenWidth, 80);
    }
    return CGSizeMake(MCScreenWidth, 40);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"] ||[self.wf_flag hasSuffix:@"lx"]){
        return self.ChineseZodiacArray.count;
    }
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.wf_flag isEqual:@"xglhc_sebo_banbo"]||[self.wf_flag isEqual:@"xglhc_sebo_bbanbo"]||([self.wf_flag hasPrefix:@"xglhc_zhmat"] && ![self.wf_flag hasSuffix:@"t"])||[self.wf_flag isEqual:@"xglhc_zoxiao_zx"]||[self.wf_flag isEqual:@"xglhc_tema_qita"]) {
        return CGSizeMake(MCScreenWidth/3, MCScreenWidth/7+20);
    }else if ([self.wf_flag isEqual:@"xglhc_sebo_sebo"] ||[self.wf_flag isEqual:@"xglhc_wuxing_wx"]){
        return CGSizeMake((MCScreenWidth) / 3, (MCScreenWidth) / 3 *1.4);
    }else if ([self.wf_flag isEqual:@"xglhc_zhxiao_zx"]|| [self.wf_flag hasSuffix:@"lx"]||[self.wf_flag isEqual:@"xglhc_texiao_tx"]||[self.wf_flag isEqual:@"xglhc_hexiao_hx"]){
        return CGSizeMake((MCScreenWidth) / 3, (MCScreenWidth) / 3 *0.9);
    }else{
        return CGSizeMake(MCScreenWidth/7, MCScreenWidth/7+20);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.wf_flag isEqual:@"xglhc_sebo_sebo"]||[self.wf_flag isEqual:@"xglhc_wuxing_wx"]){
        NSArray *dataArr;
        if ([self.wf_flag isEqual:@"xglhc_wuxing_wx"] ) {
            dataArr = @[@[@"03",@"04",@"17",@"18",@"25",@"26",@"33",@"34",@"47",@"48"],@[@"07",@"08",@"15",@"16",@"29",@"30",@"37",@"38",@"45",@"46"],@[@"05",@"06",@"13",@"14",@"21",@"22",@"35",@"36",@"43",@"44"],@[@"01",@"02",@"09",@"10",@"23",@"24",@"31",@"32",@"39",@"40"],@[@"11",@"12",@"19",@"20",@"27",@"28",@"41",@"42",@"49"]];
        }else{
            dataArr = @[@[@"01",@"02",@"07",@"08",@"12",@"13",@"18",@"19",@"23",@"24",@"29",@"30",@"34",@"35",@"40",@"45",@"46"],@[@"03",@"04",@"09",@"10",@"14",@"15",@"20",@"25",@"26",@"31",@"36",@"37",@"41",@"42",@"47",@"48"],@[@"05",@"06",@"11",@"16",@"17",@"21",@"22",@"27",@"28",@"32",@"33",@"38",@"39",@"43",@"44",@"49"]];
        }
        
        WaveColorCollerctionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseWave forIndexPath:indexPath];
        cell.dataArray = dataArr[indexPath.row];
        cell.selectBlock = ^{
            self.selectAllCount = 0;
            for (LHCLotteryModel *model in self.dataArray) {
                if (model.isSelect) {
                    self.selectAllCount ++;
                }
            }
            [self.footView.timesLabel setTitle:[NSString stringWithFormat:@"%ld注",(long)self.selectAllCount] forState:UIControlStateNormal];
        };
        cell.model = self.dataArray[indexPath.row];
        return cell;
        
    }else if ([self.wf_flag isEqual:@"xglhc_zhxiao_zx"] || [self.wf_flag hasSuffix:@"lx"]||[self.wf_flag isEqual:@"xglhc_texiao_tx"]||[self.wf_flag isEqual:@"xglhc_hexiao_hx"]){
        ChineseZodiacCollerctionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseChinese forIndexPath:indexPath];
        //判断是否选择的是合肖
        cell.selectBlock = ^(BOOL isChineseHX){
            
            self.isChineseHX = isChineseHX;
            self.selectAllCount = 0;
            for (LHCLotteryModel *model in self.ChineseZodiacArray) {
                if (model.isSelect) {
                    self.selectAllCount ++;
                }
            }
            if (self.isChineseHX &&self.selectAllCount>1 &&self.selectAllCount<12) {
                LHCLotteryModel *chineseModel = self.dataArray[self.selectAllCount-2];
                self.headCellView.timeLabel.text = [NSString stringWithFormat:@"赔率:%@",chineseModel.award_money];
            }
            
            for (LHCLotteryModel *model in self.dataArray) {
                if (model.isSelect) {
                    self.selectAllCount ++;
                }
                
                [self.footView.timesLabel setTitle:[NSString stringWithFormat:@"%ld注",(long)self.selectAllCount] forState:UIControlStateNormal];
                
            }
        };
        cell.isChineseHX = NO;
        if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"]) {
            cell.isChineseHX = YES;
            cell.model = self.ChineseZodiacArray[indexPath.row];
        }else if([self.wf_flag hasSuffix:@"lx"]){
            cell.model = self.ChineseZodiacArray[indexPath.row];
        }else{
            cell.model = self.dataArray[indexPath.row];
        }
        
        return cell;
        
    }
    LotteryDetailLHCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCollectionCell forIndexPath:indexPath];
    if ([self.wf_flag hasPrefix:@"xglhc_lm"]) {
        cell.timeLabel.hidden = YES;
    }else{
        cell.timeLabel.hidden = NO;
    }
    cell.delegate = self;
    if ([self.wf_flag isEqual:@"xglhc_sebo_banbo"]||[self.wf_flag isEqual:@"xglhc_sebo_bbanbo"]||([self.wf_flag hasPrefix:@"xglhc_zhmat"] && ![self.wf_flag hasSuffix:@"t"])||[self.wf_flag isEqual:@"xglhc_zoxiao_zx"]||[self.wf_flag isEqual:@"xglhc_tema_qita"]) {
        cell.isLongCell = YES;
    }else{
        cell.isLongCell = NO;
    }
    cell.model = self.dataArray[indexPath.item];
    return cell;
    
}

//展示历史记录
-(void)clickDownImgBtn{
    [_detailScrollView scrollToChangeStatus];
}

//从新刷新数据
-(void)endTimeReloadData{
    self.isCaps = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadLotteryTime];
    });
    
}
//本期已封顶
-(void)endTimeResponder{
    self.isCaps = YES;
    [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"本期已封单"];
}

-(BOOL)judgeIsBet{
    if (self.selectAllCount==0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请选择一组号码"];
        return NO;
    }
    return YES;
}
-(void)selectNumber{
    self.selectAllCount = 0;
    NSArray *arr = nil;
    if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"] ||[self.wf_flag hasSuffix:@"lx"]){
        arr = self.ChineseZodiacArray;
    }else{
        arr = self.dataArray;
    }
    for (LHCLotteryModel *model in arr) {
        if (model.isSelect) {
            self.selectAllCount ++;
        }
    }
    [self.footView.timesLabel setTitle:[NSString stringWithFormat:@"%ld注",self.selectAllCount] forState:UIControlStateNormal];
    
}
//投注按钮的点击
-(void)bettingClick{
    
    if (self.judgeSelectRow>self.selectAllCount) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:[NSString stringWithFormat:@"请选择%ld个号码",self.judgeSelectRow]];
        return;

    } if (self.judgeSelectRow<self.selectAllCount &&self.judgeSelectRow>0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:[NSString stringWithFormat:@"请选择%ld个号码",self.judgeSelectRow]];
        return;
    }
   
    LHCManager *manager = [LHCManager sharedManager];
    if(!self.isAddOtherWager){
      [manager.LHCDataArray removeAllObjects];
    }
    
   //选择合肖
    if (self.isChineseHX) {
        if (self.selectAllCount<2) {
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"最少选择2个号码"];
            return;
            
        } if (self.selectAllCount>11) {
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"最多选择11个号码"];
            return;
        }
         NSMutableString *str = [[NSMutableString alloc]init];
        for (LHCLotteryModel *model in self.ChineseZodiacArray) {
           
            if (model.isSelect) {
                [str appendFormat:@"%@",model.flag];
            }
        }
       
        LHCLotteryModel *chineseModel = self.dataArray[self.selectAllCount-2];
        chineseModel.pl_name = str;
        [manager.LHCDataArray addObject:chineseModel];
    }
    NSMutableString *str = [[NSMutableString alloc]init];
    for (LHCLotteryModel *model in self.dataArray) {
        if (model.isSelect &&self.judgeSelectRow ==0) {
            [manager.LHCDataArray addObject:model];
        }else if (model.isSelect &&self.judgeSelectRow>0){
           [str appendFormat:@"%@,",model.pl_name];
        }
    }
    if (str.length>0) {
        [str deleteCharactersInRange:NSMakeRange([str length]-1, 1)];
        LHCLotteryModel *model = self.dataArray[0];
        LHCLotteryModel *modelNew = [model copy];
        modelNew.pl_name = str;
      
        [manager.LHCDataArray addObject:modelNew];
        str =nil;
    }
    //添加生肖
    for (LHCLotteryModel *model in self.ChineseZodiacArray) {
        if (model.isSelect &&self.judgeSelectRow ==0 &&!self.isChineseHX) {
            [manager.LHCDataArray addObject:model];
        }else if (model.isSelect &&self.judgeSelectRow>0){
            [str appendFormat:@"%@,",model.flag];
        }
    }
    if (str.length>0) {
        [str deleteCharactersInRange:NSMakeRange([str length]-1, 1)];
        LHCLotteryModel *model = self.dataArray[0];
        LHCLotteryModel *modelNew = [model copy];
        modelNew.pl_name = str;
        [manager.LHCDataArray addObject:modelNew];
        str =nil;
        
    }
    if (manager.LHCDataArray.count == 0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请选择一组号码"];
        return;
    }
    
    LHCBettingViewController *LHCBettingVc = [[LHCBettingViewController alloc]init];
    LHCBettingVc.lottery_id = self.lottery_id;
    LHCBettingVc.wf_pl = self.wf_pl;
    LHCBettingVc.lottery_qh = self.nextLotteryModel.lottery_qh;
    LHCBettingVc.dataArray = manager.LHCDataArray;
    [self.navigationController pushViewController:LHCBettingVc animated:YES];

}

//删除按钮
-(void)deleteClick{
    [self.footView.timesLabel setTitle:@"0注" forState:UIControlStateNormal];
   // _footView.timesLabel.text = @"0注";
    for (LHCLotteryModel *model in self.dataArray) {
            model.isSelect = 0;
        }
  
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
       
    });
    
}

#pragma mark 点击历史投注按钮
-(void)historyClick{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"cp/kj-trend-history"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 @"page_no" : @"1",
                                 @"page_size"   : @"10",
                                 
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in data) {
            HistpryOfTheLotteryModel *model = [[HistpryOfTheLotteryModel alloc]initWithDictionary:dict error:nil];
            [array addObject:model];
        }
        HistoryOfTheLotteryView *historyView = [[HistoryOfTheLotteryView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, MCScreenHeight)];
        historyView.dataArray = array;
        historyView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:historyView];
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)shakeAction{
    NSArray *arr = nil;
    if ([self.wf_flag isEqual:@"xglhc_hexiao_hx"] ||[self.wf_flag hasSuffix:@"lx"]){
        arr = self.ChineseZodiacArray;
    }else{
        arr = self.dataArray;
    }
    LHCLotteryModel *model = arr[0];
    if(!model.isAlreadyGetData){
        return;
    }
    
    //设置震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSLog(@"%@",self.wf_flag);
    
    int allCount = 0;
    //色波
    if([self.wf_flag isEqual:@"xglhc_sebo_sebo"]){
        allCount = 3;
        //正码其他
    }else if([self.wf_flag isEqual:@"xglhc_zhma_qt"] || [self.wf_flag isEqual:@"xglhc_7sebo_7sb"]){
        allCount = 4;
        //五行
    }else if([self.wf_flag isEqual:@"xglhc_wuxing_wx"]){
        allCount = 5;
        //总肖
    }else if([self.wf_flag isEqual:@"xglhc_zoxiao_zx"]){
        allCount = 8;
        //正一特大小 正二特大小 正三特大小 正四特大小 正五特大小 正六特大小
    }else if([self.wf_flag isEqual:@"xglhc_zhmat_z1tdx"] || [self.wf_flag isEqual:@"xglhc_zhmat_z2tdx"] || [self.wf_flag isEqual:@"xglhc_zhmat_z3tdx"] || [self.wf_flag isEqual:@"xglhc_zhmat_z4tdx"]|| [self.wf_flag isEqual:@"xglhc_zhmat_z5tdx"]|| [self.wf_flag isEqual:@"xglhc_zhmat_z6tdx"]){
        allCount = 9;
        //尾数 二连尾 三连尾 四连尾 五连尾
    }else if([self.wf_flag isEqual:@"xglhc_pt1xws_ws"] || [self.wf_flag isEqual:@"xglhc_lxlw_2lw"] || [self.wf_flag isEqual:@"xglhc_lxlw_3lw"] || [self.wf_flag isEqual:@"xglhc_lxlw_4lw"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lw"]){
        allCount = 10;
        //半波 半半波 特肖 合肖 二连肖 三连肖 四连肖 五连肖 一肖
    }else if([self.wf_flag isEqual:@"xglhc_pt1xws_1x"] ||[self.wf_flag isEqual:@"xglhc_sebo_banbo"] || [self.wf_flag isEqual:@"xglhc_sebo_bbanbo"]|| [self.wf_flag isEqual:@"xglhc_texiao_tx"]|| [self.wf_flag isEqual:@"xglhc_hexiao_hx"] || [self.wf_flag isEqual:@"xglhc_zhxiao_zx"] || [self.wf_flag isEqual:@"xglhc_lxlw_2lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_3lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_4lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lx"]){
        allCount = 12;
        //正码一 正码二 正码三 正码四 正码五 正码六
    }else if([self.wf_flag isEqual:@"xglhc_zhma1d6_zm1"] || [self.wf_flag isEqual:@"xglhc_zhma1d6_zm2"] || [self.wf_flag isEqual:@"xglhc_zhma1d6_zm3"] || [self.wf_flag isEqual:@"xglhc_zhma1d6_zm4"] || [self.wf_flag isEqual:@"xglhc_zhma1d6_zm5"]|| [self.wf_flag isEqual:@"xglhc_zhma1d6_zm6"]){
        allCount = 13;
        //头尾数
    }else if([self.wf_flag isEqual:@"xglhc_tws_tws"]){
        allCount = 15;
        //特码其他
    }else if([self.wf_flag isEqual:@"xglhc_tema_qita"]){
        allCount = 20;
        //特码 正码  正一特 正二特 正三特 正四特 正五特 正六特 自选不中 三中二 三全中 二全中 二中特 特串 四全中
    }else{
        allCount = 49;
    }
    NSMutableArray *allNum = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
    NSMutableArray *allNum2 = [NSMutableArray array];
    for(int i = 0 ;i < 49;i++){
        [allNum2 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSMutableArray *allNum3 = [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    NSMutableArray *selectNum = [NSMutableArray array];
    if([self.wf_flag isEqual:@"xglhc_hexiao_hx"] ||[self.wf_flag isEqual:@"xglhc_lxlw_2lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_3lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_4lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_2lw"] || [self.wf_flag isEqual:@"xglhc_lxlw_3lw"] || [self.wf_flag isEqual:@"xglhc_lxlw_4lw"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lw"]){
        int count = 11;
        if([self.wf_flag isEqual:@"xglhc_hexiao_hx"]||[self.wf_flag isEqual:@"xglhc_lxlw_2lx"]){
            count = 10;
        }else if([self.wf_flag isEqual:@"xglhc_lxlw_3lx"]){
            count = 9;
        }else if([self.wf_flag isEqual:@"xglhc_lxlw_4lx"]||[self.wf_flag isEqual:@"xglhc_lxlw_2lw"]){
            count = 8;
        }else if([self.wf_flag isEqual:@"xglhc_lxlw_5lx"]||[self.wf_flag isEqual:@"xglhc_lxlw_3lw"]){
            count = 7;
        }else if([self.wf_flag isEqual:@"xglhc_lxlw_4lw"]){
            count = 6;
        }else if([self.wf_flag isEqual:@"xglhc_lxlw_5lw"]){
            count = 5;
        }
        if([self.wf_flag isEqual:@"xglhc_hexiao_hx"] ||[self.wf_flag isEqual:@"xglhc_lxlw_2lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_3lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_4lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lx"]){
            for(int k = allCount;k > count;k--){
                int newNum = arc4random() % k;
                [selectNum addObject:allNum[newNum]];
                [allNum removeObject:allNum[newNum]];
            }
        }else{
            for(int k = allCount;k > count;k--){
                int newNum = arc4random() % k;
                [selectNum addObject:allNum3[newNum]];
                [allNum3 removeObject:allNum3[newNum]];
            }
        }
        
    }else if([self.wf_flag isEqual:@"xglhc_zxbz_zxbz"]||[self.wf_flag isEqual:@"xglhc_lm_3z2"]||[self.wf_flag isEqual:@"xglhc_lm_3qz"]||[self.wf_flag isEqual:@"xglhc_lm_2qz"]||[self.wf_flag isEqual:@"xglhc_lm_2zt"]||[self.wf_flag isEqual:@"xglhc_lm_tc"]||[self.wf_flag isEqual:@"xglhc_lm_4qz"]){
        int count = 11;
        if([self.wf_flag isEqual:@"xglhc_zxbz_zxbz"]){
            count = 43;
        }else if([self.wf_flag isEqual:@"xglhc_lm_3z2"]||[self.wf_flag isEqual:@"xglhc_lm_3qz"]){
            count = 46;
        }else if([self.wf_flag isEqual:@"xglhc_lm_2qz"]||[self.wf_flag isEqual:@"xglhc_lm_2zt"]||[self.wf_flag isEqual:@"xglhc_lm_tc"]){
            count = 47;
        }else{
            count = 45;
        }
        
        for(int k = allCount;k > count;k--){
            int newNum = arc4random() % k;
            [selectNum addObject:allNum2[newNum]];
            [allNum2 removeObject:allNum2[newNum]];
        }
    }
    
    //生成随机数
    int newNum = arc4random() % allCount;

    NSMutableArray *dataArr = nil;
    if([self.wf_flag isEqual:@"xglhc_hexiao_hx"] ||[self.wf_flag hasSuffix:@"lx"]){
        dataArr = self.ChineseZodiacArray;
    }else{
        dataArr = self.dataArray;
    }
    for( LHCLotteryModel *model in  dataArr){
        model.isSelect = NO;
    }
    
    NSArray *cellsArr = self.collectionView.visibleCells;
    for(int i = 0;i < dataArr.count;i++){
        //获得collectionview所有的cell 对 随机数对应的按钮 和 已经被选中的按钮进行点击
        if([self.wf_flag isEqual:@"xglhc_sebo_sebo"] || [self.wf_flag isEqual:@"xglhc_texiao_tx"]|| [self.wf_flag isEqual:@"xglhc_hexiao_hx"]||[self.wf_flag isEqual:@"xglhc_wuxing_wx"]|| [self.wf_flag isEqual:@"xglhc_zhxiao_zx"]||[self.wf_flag isEqual:@"xglhc_lxlw_2lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_3lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_4lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lx"]){
            ChineseZodiacCollerctionViewCell *cell = cellsArr[i];
            for(UIView *view in cell.subviews){
                if([view isKindOfClass:[UIButton class]]){
                    UIButton *btn = (UIButton *)view;
                    if(btn.selected){
                        [cell seleButtonClick:btn];
                    }
                    if([self.wf_flag isEqual:@"xglhc_hexiao_hx"]||[self.wf_flag isEqual:@"xglhc_lxlw_2lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_3lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_4lx"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lx"]){
                        for(NSString *numStr in selectNum){
                            if(numStr.integerValue == i){
                                [cell seleButtonClick:btn];
                            }
                        }
                    }else{
                        if(i == newNum){
                            [cell seleButtonClick:btn];
                        }
                    }
                }
            }
        }else{
            if([self.wf_flag isEqual:@"xglhc_zxbz_zxbz"]|| [self.wf_flag isEqual:@"xglhc_lxlw_2lw"] || [self.wf_flag isEqual:@"xglhc_lxlw_3lw"] || [self.wf_flag isEqual:@"xglhc_lxlw_4lw"]|| [self.wf_flag isEqual:@"xglhc_lxlw_5lw"]||[self.wf_flag isEqual:@"xglhc_lm_3z2"]||[self.wf_flag isEqual:@"xglhc_lm_3qz"]||[self.wf_flag isEqual:@"xglhc_lm_2qz"]||[self.wf_flag isEqual:@"xglhc_lm_2zt"]||[self.wf_flag isEqual:@"xglhc_lm_tc"]||[self.wf_flag isEqual:@"xglhc_lm_4qz"]){
                for(NSString *numStr in selectNum){
                    if(numStr.integerValue == i){
                        LHCLotteryModel *model = dataArr[i];
                        model.isSelect = YES;
                    }
                }
                [self.collectionView reloadData];
            }else{
                if(i == newNum){
                    LHCLotteryModel *model = dataArr[i];
                    model.isSelect = YES;
                    [self.collectionView reloadData];
                }
            }
        }
        
    }
    [self selectNumber];
}
#pragma mark 摇一摇功能代理方法
-(void)shakeActionClick{
    [self shakeAction];
}

#pragma mark 摇一摇功能
/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇了");
    [self shakeAction];
}

/**
 *  摇动结束
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion ==UIEventSubtypeMotionShake ) {
        
    }
    NSLog(@"摇动结束");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(HeadView *)headView{
    if (!_headView) {
        self.headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 40)];
        self.headView.delegate = self;
    }
    return _headView;
}
-(LHCFooterView *)footView{
    if (!_footView) {
        if (IS_IPHONE_X) {
            _footView = [[LHCFooterView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-42-64 - 30, MCScreenWidth, 42 + 30)];
        }else{
            _footView = [[LHCFooterView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-42-64, MCScreenWidth, 42)];
        }
        _footView.delegate = self;
    }
    return _footView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for(int i = 1;i < 50;i++){
            LHCLotteryModel *model = [LHCLotteryModel new];
            model.pl_name = [NSString stringWithFormat:@"%d",i];
            model.award_money = @"1.00";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        self.collectionView.backgroundColor = MCMineTableCellBgColor;
        [self.collectionView registerClass:[LotteryDetailLHCCollectionViewCell class] forCellWithReuseIdentifier:kReuseCollectionCell];
        [self.collectionView registerClass:[WaveColorCollerctionViewCell class] forCellWithReuseIdentifier:kCellReuseWave];
        
        [self.collectionView registerClass:[ChineseZodiacCollerctionViewCell class] forCellWithReuseIdentifier:kCellReuseChinese];
        self.collectionView.collectionViewLayout = layout;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        // 注册头部视图
        [self.collectionView registerClass:[LHCCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseId];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"normalHeader"];
    }
    return _collectionView;
}

- (KKAccountDetailToolTipView *)toolTipView {
    if (_toolTipView == nil) {
        self.toolTipView = [[KKAccountDetailToolTipView alloc] init];
        self.toolTipView.backgroundColor = [UIColor clearColor];
    } return _toolTipView;
}
-(BouncedView *)bounceView{
    if (!_bounceView) {
        _bounceView = [[BouncedView alloc]init];
        _bounceView.backgroundColor = [UIColor clearColor];
    }
    return _bounceView;
}
-(RodiaView *)rodiaView{
    if (!_rodiaView) {
        _rodiaView = [[RodiaView alloc]init];
        _rodiaView.backgroundColor = [UIColor clearColor];
    }
    return _rodiaView;
}
-(NSMutableArray *)playdDataArray{
    if (!_playdDataArray) {
        _playdDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _playdDataArray;
}
-(NSMutableArray *)playTitleArray{
    if (!_playTitleArray) {
        _playTitleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _playTitleArray;
}
-(NSMutableArray *)ChineseZodiacArray{
    if (!_ChineseZodiacArray) {
        _ChineseZodiacArray = [NSMutableArray arrayWithCapacity:0];;
    }
    return _ChineseZodiacArray;
}

-(LotteryTimeView *)timeView{
    if (!_timeView) {
        self.timeView = [[LotteryTimeView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 30)];
        self.timeView.backgroundColor = MCUIColorLighttingBrown;
        self.timeView.delegate = self;
    }
    return _timeView;
}
@end
