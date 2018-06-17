//
//  LotteryDetailBJ28ViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/17.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryDetailBJ28ViewController.h"
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
#import "BJ28TMBSCollectionViewCell.h"
#import "LotteryDetailModel.h"
#import "ChineseZodiacCollerctionViewCell.h"
#import "KKShakeActionManager.h"
#import "KKLotteryDetailScrollView.h"
#import "KKLotteryDetailHeaderView.h"
#import "LotteryTimeView.h"
#import "BaseLotterHistoryMananger.h"
#import "KKTrend_historyViewController.h"
#define kReuseCollectionCell @"collectionCell4"
#define kCellReuseWave @"waveCell"
#define kCellReuseChinese @"chinsesCell"
@interface LotteryDetailBJ28ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LHCFooterViewDelegate,HeadViewDelegate,LotteryDetail4CollectionViewCellDelegate,LotteryTimeViewDelegate>

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
@property(nonatomic,assign)BOOL isChineseHX;//是否是合肖
@property(nonatomic,assign)NSInteger judgeSelectRow;//判断选多少个号码算一注

@property(nonatomic,strong)KKLotteryDetailScrollView *detailScrollView;

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation LotteryDetailBJ28ViewController

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
//                if ([dict1[@"wf_flag"]  isEqual: @"xy28_tmtm_tm"]) {
//                    self.wf_flag = dict1[@"wf_flag"];
//                    self.wf_pl = dict1[@"wf_pl"];
//                    title = dict[@"name"];
//                    name = dict1[@"name"];
//
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
                        break;
                    }
                }
            }
        }

        [self sendNetWorking:name andtitle:title];
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
      
        self.judgeSelectRow = [model.selectRow integerValue];
        [self.dataArray removeAllObjects];
        [self.ChineseZodiacArray removeAllObjects];
        self.wf_flag = model.wf_flag;
        self.wf_pl = model.wf_pl;
        [self sendNetWorking:model.name andtitle:model.title];
    };
    [self.navigationController pushViewController:gameSelectVc animated:YES];

}
-(void)promptClick:(UIButton *)sender{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"wf-explain/xy28-wf"];
    
    if (![urlStr isEqualToString:@""]) {
        MCH5ViewController * vc = [[MCH5ViewController alloc] init];
        vc.url = urlStr;
        vc.titleStr = @"玩法说明";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
 
}
-(void)reloadLotteryTime{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cp-lock-time"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        self.nextLotteryModel = [[NextTheLotteryModel alloc]initWithDictionary:data error:nil];
        [self.timeView setPeriod:[NSString stringWithFormat:@"距离%@期开奖",self.nextLotteryModel.lottery_qh] andTime:self.nextLotteryModel.lock_time andEndTimer:self.nextLotteryModel.plan_kj_time];
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
 
     if ([self.wf_flag isEqual:@"xy28_tmb3_b3"]){
        [self.dataArray removeAllObjects];
        NSDictionary *dict = self.wf_pl[0];
        for (int i=0; i<28; i++) {
            LHCLotteryModel *model = [[LHCLotteryModel alloc]init];
            model.award_money = dict[@"award_money"];
            
            model.pl_name = [NSString stringWithFormat:@"%d",i];
            model.pl_flag = dict[@"pl_flag"];
            model.wf_flag = self.wf_flag;
            model.species = [NSString stringWithFormat:@"%@-%@",title,wf_pl];
            model.isAlreadyGetData = YES;
            [self.dataArray addObject:model];
        }
    }
    
    [self.collectionView reloadData];
    
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.wf_flag isEqual:@"xy28_tmb3_b3"]){
//      return  CGSizeMake(MCScreenWidth/3, 50);
//    }
     return CGSizeMake(MCScreenWidth/7, MCScreenWidth/7+20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if ([self.wf_flag isEqual:@"xy28_tmb3_b3"]){
//        BJ28TMBSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseWave forIndexPath:indexPath];
//        cell.model = _dataArray[indexPath.item];
//        return cell;
//    }
    
    LotteryDetailLHCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCollectionCell forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.dataArray[indexPath.item];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bj28LotteryHeaderView" forIndexPath:indexPath];
        for (UIView *view in headerView.subviews) {
            [view removeFromSuperview];
        }
        [headerView addSubview:self.headView];
        return headerView;
    
    }else{
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(MCScreenWidth, 40);
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
    
    for (LotteryDetailModel *model in self.dataArray) {
        if (model.isSelect) {
            self.selectAllCount ++;
        }
    }
    if([self.wf_flag isEqual:@"xy28_tmb3_b3"]){
        if(self.selectAllCount >= 3){
            [self.footView.timesLabel setTitle:@"1注" forState:UIControlStateNormal];
            return;
        }else if (self.selectAllCount < 3){
            [self.footView.timesLabel setTitle:@"0注" forState:UIControlStateNormal];
        }
    }else{
        [self.footView.timesLabel setTitle:[NSString stringWithFormat:@"%ld注",(long)self.selectAllCount] forState:UIControlStateNormal];
    }
    
}
//投注按钮的点击
-(void)bettingClick{
    
    LHCManager *manager = [LHCManager sharedManager];
    NSInteger count = 0;
    if ([self.wf_flag isEqual:@"xy28_tmb3_b3"]){
        NSMutableString *plName = [[NSMutableString alloc]init];
        [manager.LHCDataArray removeAllObjects];
        for (LHCLotteryModel *model in self.dataArray) {
            if(model.isSelect){
                [plName appendFormat:@"%@,",model.pl_name];
//                [manager.LHCDataArray addObject:model];
                count++;
            }
        }
        [plName deleteCharactersInRange:NSMakeRange([plName length]-1, 1)];

        LHCLotteryModel *chineseModel = self.dataArray[0];
        LHCLotteryModel *tempModel = [LHCLotteryModel new];
        tempModel.pl_name = plName;
        tempModel.number = chineseModel.number;
        tempModel.isSelect = chineseModel.isSelect;
        tempModel.titleStr = chineseModel.titleStr;
        tempModel.award_money = chineseModel.award_money;
        tempModel.flag = chineseModel.flag;
        tempModel.value = chineseModel.value;
        tempModel.species = chineseModel.species;
        tempModel.money = chineseModel.money;
        tempModel.wf_flag = chineseModel.wf_flag;
        tempModel.pl_flag = chineseModel.pl_flag;
        [manager.LHCDataArray addObject:tempModel];
    }else{
        for (LHCLotteryModel *model in self.dataArray) {
            if (model.isSelect) {
                [manager.LHCDataArray addObject:model];
            }
        }
    }
   
    if(count != 3 && [self.wf_flag isEqual:@"xy28_tmb3_b3"]){
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请选择三组号码"];
        return;
    }else if (manager.LHCDataArray.count == 0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请选择一组号码"];
        return;
    }
    
    LHCBettingViewController *LHCBettingVc = [[LHCBettingViewController alloc]init];
    LHCBettingVc.lottery_id = self.lottery_id;
    LHCBettingVc.lottery_qh = self.nextLotteryModel.lottery_qh;
    LHCBettingVc.dataArray = manager.LHCDataArray;
    [self.navigationController pushViewController:LHCBettingVc animated:YES];

}

//删除按钮
-(void)deleteClick{
//    if ([self.wf_flag isEqual:@"xy28_tmb3_b3"]) {
//         [self.footView.timesLabel setTitle:@"1注" forState:UIControlStateNormal];
//        return;
//    }
    [self.footView.timesLabel setTitle:@"0注" forState:UIControlStateNormal];
   // _footView.timesLabel.text = @"0注";
    for (LotteryDetailModel *model in self.dataArray) {
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
    LHCLotteryModel *model =  self.dataArray[0];
    if(!model.isAlreadyGetData){
        return;
    }
    [KKShakeActionManager shakeActionWithLotteryType:@"北京28" dataArray:self.dataArray wf_flag:self.wf_flag selectedDigitArr:nil];
    [self.collectionView reloadData];
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
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = MCMineTableCellBgColor;
        [self.collectionView registerClass:[LotteryDetailLHCCollectionViewCell class] forCellWithReuseIdentifier:kReuseCollectionCell];
        [self.collectionView registerNib:[UINib nibWithNibName:@"BJ28TMBSCollectionViewCell" bundle:[NSBundle mainBundle] ] forCellWithReuseIdentifier:kCellReuseWave];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bj28LotteryHeaderView"];
        self.collectionView.collectionViewLayout = layout;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
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
        _ChineseZodiacArray = [NSMutableArray arrayWithCapacity:0];
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


