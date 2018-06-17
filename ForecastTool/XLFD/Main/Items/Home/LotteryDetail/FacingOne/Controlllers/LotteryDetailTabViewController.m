//
//  LotteryDetailTabViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryDetailTabViewController.h"
#import "ChaseLotteryV2ViewController.h"
#import "HistoryOfTheLotteryView.h"
#import "KeyBoardView.h"
#import "HeadView.h"
#import "FootView.h"
#import "BouncedView.h"
#import "LotteryDetailModel.h"
#import "GameSelectModel.h"
#import "GameSelectViewController.h"
#import "KKAccountDetailToolTipView.h"
#import "NextTheLotteryModel.h"
#import "HistpryOfTheLotteryModel.h"
#import "RodiaView.h"
#import "HeadButton.h"
#import "LotteryAlgorithm.h"
#import "BettingView.h"
#import "KKBettingResultView.h"
#import "KKBetRecordViewController.h"
#import "EarnCommissionsBouncedView.h"
#import "KKBettingSelectedTableViewCell.h"
#import "KKLotteryTitleDataModel.h"
#import "KKLotteryDataModel.h"
#import "KKShakeActionManager.h"
#import "KKSSCBaseTableViewCell.h"
#import "KKLotteryDetailScrollView.h"
#import "KKLotteryDetailHeaderView.h"
#import "LotteryTimeView.h"
#import "BaseLotterHistoryMananger.h"
#import "KKTrend_historyViewController.h"
@interface LotteryDetailTabViewController ()<UITableViewDelegate,UITableViewDataSource,FootViewDelegate,KeyBoardViewDelegate,HeadViewDelegate,EarnCommissionsBouncedViewDelegate,KKSSCBaseTableViewCellDelegate,LotteryTimeViewDelegate>
@property(nonatomic ,strong)HeadView *headView;
@property(nonatomic,strong)FootView *footView;
@property(nonatomic,strong)LotteryTimeView *timeView;
@property(nonatomic,strong)KKAccountDetailToolTipView *toolTipView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *balanceStr;
@property(nonatomic,strong)NSMutableArray *dataArrayM;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)GameSelectModel *model;
@property (nonatomic, strong)EarnCommissionsBouncedView *ecBounceView;
@property (nonatomic,strong)BouncedView *bounceView;
@property (nonatomic,strong)BettingView *bettingView;
@property(nonatomic,strong)NextTheLotteryModel *nextLotteryModel;
@property(nonatomic,assign)CGFloat selectMoneryModel; //选择的金钱的模式
@property(nonatomic,strong)NSString *bet_number;//投注的号码
@property(nonatomic,assign) BOOL isCaps;
@property(nonatomic ,strong)NSArray *wf_pl;
@property(nonatomic,assign)NSInteger selectAllCount;//选择了多少注
@property(nonatomic,copy)NSString *selectTitleStr;
@property(nonatomic,strong)RodiaView *rodiaView;

@property(nonatomic,strong)UIBarButtonItem *cancelButton;

@property(nonatomic,strong)UIView *tableHeadView;

@property(nonatomic,strong)NSMutableArray *playdDataArray;//所有玩法
@property(nonatomic,strong)NSMutableArray *playTitleArray;

@property(nonatomic,strong)NSMutableArray *selectedDigitArr;

@property(nonatomic,strong)NSMutableArray *titleDataArr;
@property(nonatomic,strong)UITableView *titleTableView;
@property(nonatomic,assign)BOOL isPushToWFViewController;

@property(nonatomic,strong)KKLotteryDetailScrollView *detailScrollView;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation LotteryDetailTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self interfaceDataRefreshed];
    
    [self basicSetting];
    [self initUI];
    [self getDataOfLotteryKinds];
    self.selectMoneryModel = 1.00;
    [self regiestNotic];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    [self startTimer];
    
    if (self.isCaps) {
        [self interfaceDataRefreshed];
    }
    
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

#pragma mark 界面数据刷新，有新一期的时候才刷新，不然不刷新数据
-(void)interfaceDataRefreshed{
    self.selectAllCount = 0;
    if(!self.isPushToWFViewController){
        [self sendNetWorkingAllPlay];
    }
    
    [self reloadLotteryTime];
    NSString * token = [MCTool BSGetUserinfo_token];
    
    if (token.length > 0) {
        [self getBalance];
    }
}

-(void)regiestNotic{
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadLotteryTime) name:@"RELOADSSCTIME" object:nil];
}
-(void)dealloc{
    //只要注册通知一定要移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//获取所有玩法
- (void)sendNetWorkingAllPlay {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cz-wf"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        
        [self.playdDataArray removeAllObjects];
        for (NSDictionary *dict in data) {
            [self.playTitleArray addObject:dict[@"name"]];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArr = dict[@"wf"];
            for (int i=0 ; i<dataArr.count ; i++) {
                NSDictionary *dict = dataArr[i];
//                if ([dict[@"wf_flag"]  isEqual: @"ssc_5xdwd"]) {
//                    self.wf_flag = dict[@"wf_flag"];
//                    self.wf_pl = dict[@"wf_pl"];
//                }
                GameSelectDetailModel *model = [[GameSelectDetailModel alloc]initWithDictionary:dict error:nil];
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
                        break;
                    }
                }
            }
        }
        [self sendNetWorking:self.wf_flag];
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
    
}

-(void)getDataOfLotteryKinds{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gc/sub-lottery-info"];
    NSDictionary * parameter = @{
                                 @"lottery_type" : self.lottery_type,
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        [self.titleDataArr removeAllObjects];
        for(NSDictionary *dict in (NSArray *)data){
            KKLotteryTitleDataModel *model = [[KKLotteryTitleDataModel alloc]initWithDictionary:dict error:nil];
            [self.titleDataArr addObject:model];
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.titleTableView){
        [self.titleTableView removeFromSuperview];
        self.titleTableView = nil;
    }
}

-(void)titleViewClick{
    if(self.titleTableView){
        [self.titleTableView removeFromSuperview];
        self.titleTableView = nil;
        
    }else{
        
        UITableView *tableView = [UITableView new];
        self.titleTableView = tableView;
        [self.view.window addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 2000;
        tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(-5);
            make.top.mas_equalTo(self.navigationItem.titleView.mas_bottom);
            make.width.mas_equalTo(120);
            NSInteger row = self.titleDataArr.count;
            make.height.mas_equalTo(row * 30);
        }];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[KKBettingSelectedTableViewCell class] forCellReuseIdentifier:@"titleCell"];
    }
}

-(void)basicSetting{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
}
-(void)switchClick:(UIButton *)sender {
    GameSelectViewController *gameSelectVc = [[GameSelectViewController alloc]init];
    gameSelectVc.dataArray = self.playdDataArray;
    gameSelectVc.titleArray = self.playTitleArray;
    gameSelectVc.lottery_id = self.lottery_id;
    gameSelectVc.selectItemClick = ^(GameSelectDetailModel *model){
        self.wf_flag = model.wf_flag;
        self.wf_pl = model.wf_pl;
        [self sendNetWorking:model.wf_flag];
        
        [self changeBouns];
    };
    self.isPushToWFViewController = YES;
    [self.navigationController pushViewController:gameSelectVc animated:YES];
 
}

-(void)promptClick:(UIButton *)sender {
    [self.bounceView removeFromSuperview];
    self.bounceView = nil;
    self.bounceView.type_bottomLabel.text = self.model.title;
    self.bounceView.changeMoney_bottomLabel.text = self.model.explain;
    self.bounceView.totalMoney_bottomLabel.text = self.model.example;
    [self.view.window addSubview:self.bounceView];
    
    [self.bounceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view.window);
    }];
}

-(void)getBalance{
    [KKBalanceManager getBalance:^(NSString *balance) {
        self.footView.balanceLabel.text = [NSString stringWithFormat:@"余额:%@元",balance];
        self.balanceStr = balance;
    }];
}
-(void)reloadLotteryTime{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cp-lock-time"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        self.nextLotteryModel = [[NextTheLotteryModel alloc]initWithDictionary:data error:nil];
        [self.timeView setPeriod:[NSString stringWithFormat:@"距%@期截止:",self.nextLotteryModel.show_qh] andTime:self.nextLotteryModel.lock_time andEndTimer:self.nextLotteryModel.plan_kj_time];
        self.isCaps = NO;
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}
-(void)sendNetWorking:(NSString *)wf_class {
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"0注0.00元"];
    [str2 addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(0,1)];
    [str2 addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,4)];
    self.footView.bettingMoneyLabel.text = [str2 string];
    
    [self.dataArray removeAllObjects];
    [self.dataArrayM removeAllObjects];
    
    NSDictionary *dic = [MCTool getWF_classDict:wf_class];
    self.model = [[GameSelectModel alloc]initWithDictionary:dic error:nil];
    
    NSString *str1 = [NSString stringWithFormat:@"当前玩法:%@",_model.title];
    
    self.headView.currentPlayLabel.text = str1;
    
    NSDictionary *dict = self.wf_pl[0];
    
    NSString *str5 = [NSString stringWithFormat:@"单注奖金:%@元",dict[@"award_money"]];
    NSMutableAttributedString *bonusStr = [[NSMutableAttributedString alloc] initWithString:str5];
    [bonusStr addAttribute:NSForegroundColorAttributeName value:MCUIColorGray range:NSMakeRange(3,str5.length-4)];
    
    self.footView.bonusLabel.text = [bonusStr string];
    self.footView.timesTextField.text = @"1";
    NSArray *titleArr = self.model.param[@"titles"];
    for (NSString *str in titleArr) {
        [self.dataArray addObject:str];
    }
    for (int i=0; i<titleArr.count; i++) {
        if ([wf_class  isEqual: @"ssc_lhd"]) {
            
            NSArray *titleArr = @[@[@"十个",@"百个",@"百十",@"千个",@"千十",@"千百",@"万个",@"万十",@"万百",@"万千"],@[@"龙",@"虎",@"合"]];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (NSString *str in titleArr[i]) {
                LotteryDetailModel *model = [[LotteryDetailModel alloc]init];
                model.number = str;
                [arr addObject:model];
            }
            KKLotteryDataModel *dataModel = [KKLotteryDataModel new];
            dataModel.dataSource = arr;
            dataModel.selectedBtnIndex = -1;
            dataModel.isAlreadyGetData = YES;
            [self.dataArrayM addObject:dataModel];
        }else if([wf_class hasPrefix:@"ssc_dxds"]){
            NSArray *titleArr = @[@"大",@"小",@"单",@"双"];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (NSString *str in titleArr) {
                LotteryDetailModel *model = [[LotteryDetailModel alloc]init];
                model.number = str;
                [arr addObject:model];
            }
            KKLotteryDataModel *dataModel = [KKLotteryDataModel new];
            dataModel.dataSource = arr;
            dataModel.selectedBtnIndex = -1;
            dataModel.isAlreadyGetData = YES;
            [self.dataArrayM addObject:dataModel];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (int j= [self.model.param[@"begin"] intValue]; j<[self.model.param[@"end"] intValue]+1; j++) {
                LotteryDetailModel *model = [[LotteryDetailModel alloc]init];
                model.number = [NSString stringWithFormat:@"%d",j];
                [arr addObject:model];
            }
            KKLotteryDataModel *dataModel = [KKLotteryDataModel new];
            dataModel.dataSource = arr;
            dataModel.selectedBtnIndex = -1;
            dataModel.isAlreadyGetData = YES;
            [self.dataArrayM addObject:dataModel];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat rowHeight = [self rowHeightWithDataSourceWithIndex:0];
        [self.tableView reloadData];
        [self.detailScrollView updateFrameWithDataCount:self.dataArray.count andRowHeight:rowHeight];
    });
}
-(void)initUI{
    [self.view addSubview:self.timeView];

    self.tableView.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 30 - 64);
    self.tableView.tableHeaderView = self.headView;
    CGFloat footerH = IS_IPHONE_X ? 81+30 : 81;
    KKLotteryDetailScrollView *detailScrollView = [[KKLotteryDetailScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, MCScreenHeight - 30 - footerH -64) HeaderView:[KKLotteryDetailHeaderView new]headerHeight:300 viewController:self subView:self.tableView];
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

#pragma mark UITableView
-(void)selectTitleClick:(UIButton *)sender{
    
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    for (UIView *view in self.tableHeadView.subviews) {
        if (view.tag>=1000) {
            UIButton *btn = (UIButton *)view;
            if (btn.selected) {
                [mutableStr appendFormat:@"%@,", [NSString stringWithFormat:@"%ld",btn.tag-1000]];
            }
        }
    }
    self.selectTitleStr = mutableStr;
    if (self.selectTitleStr.length>0) {
        self.selectTitleStr = [self.selectTitleStr substringToIndex:([self.selectTitleStr length]-1)];
    }

    [self selectNumber];
}

-(CGFloat)rowHeightWithDataSourceWithIndex:(NSInteger)index{
    CGFloat btnWidth = kAdapterWith(42);
    NSArray *comArr = [self.wf_flag componentsSeparatedByString:@"_"];
    if ([comArr[1] isEqual:@"dxds"]) {
        return 16 + btnWidth;
    }
    if ([self.wf_flag  isEqual: @"ssc_lhd"]) {
        if(index == 0) {
            return  16+btnWidth*2+5;
        }
        else{
            return  30+btnWidth;
        }
    }
    KKLotteryDataModel *dataModel = self.dataArrayM[index];;
    CGFloat row = dataModel.dataSource.count % 6 ? dataModel.dataSource.count /6 + 1: dataModel.dataSource.count /6;
    return  16 + row * kAdapterWith(42) + (row - 1) * 5 + 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 2000){
        KKLotteryTitleDataModel *titlemodel = self.titleDataArr[indexPath.row];
        self.lottery_id = titlemodel.lottery_id;
        self.titleStr = titlemodel.lottery_name;
        [tableView removeFromSuperview];
        [self reloadLotteryTime];
        [self sendNetWorkingAllPlay];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag == 1000){
        return self.dataArray.count;
    }else{
        return self.titleDataArr.count;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 1000 && self.model.param[@"num_location"]) {
        self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 59)];
        self.tableHeadView.userInteractionEnabled = YES;
        NSInteger ben_lenth = [self.model.calculate[@"base_len"] integerValue];
        NSArray *titleArray = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
        for (int i =0; i<titleArray.count; i++) {
            HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(i*MCScreenWidth/titleArray.count, 0, MCScreenWidth/titleArray.count, 59)];
            btn.backgroundColor = MCMineTableViewBgColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"Reuse_notSelectd"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"Reuse_selected"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(selectTitleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.tag = 1000+i;
            [self.tableHeadView addSubview:btn];
            if (i>=titleArray.count-ben_lenth) {
                [self selectTitleClick:btn];
            }
        }
        return self.tableHeadView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.model.param[@"num_location"]) {
        return 60;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1000){
        return  [self rowHeightWithDataSourceWithIndex:indexPath.row];
    }else{
        return 30;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == 1000){
        static NSString *CellIdentifier = @"cell";
        KKSSCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.wf_flag = self.wf_flag;
        cell.dataModel = self.dataArrayM[indexPath.row];
        cell.cellTitle = self.dataArray[indexPath.row];
        cell.delegate = self;
        return cell;
    }else{
        KKBettingSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        KKLotteryTitleDataModel *titlemodel = self.titleDataArr[indexPath.row];
        cell.backgroundColor = MCMineTableCellBgColor;
        cell.selectedNumLabel.text = titlemodel.lottery_name;
        return cell;
    }
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

#pragma mark 点击了数字回调算选了多少住
-(void)selectNumber{
    self.selectAllCount = 0;
    NSMutableString *str5  = [NSMutableString stringWithCapacity:0];
    for (KKLotteryDataModel *dataModel in self.dataArrayM) {
        NSArray *arr = dataModel.dataSource;
        for (LotteryDetailModel *model in arr) {
            if (model.isSelect) {
                [str5 appendFormat:@"%@", model.number];
                self.selectAllCount ++;
            }
        }
        [str5 appendFormat:@","];
        self.bet_number = str5;
        //判断只有一组数据的时候是否需要逗号
        if (self.dataArrayM.count == 1) {
         NSMutableString *str6  = [NSMutableString stringWithCapacity:0];
            for (LotteryDetailModel *model in arr) {
                if (model.isSelect) {//判断投注是否需要逗号
                    if (self.model.calculate[@"num_separator"]) {
                       [str6 appendFormat:@"%@%@", model.number,self.model.calculate[@"num_separator"]];
                    }else{
                        [str6 appendFormat:@"%@", model.number];
                    }
                    
                }

            }
            self.bet_number = str6;
        }
    }
    
    NSLog(@"%@",self.bet_number);
    if (self.bet_number.length>0) {
        //判断最后一位是不是逗号，是就截取叼
        NSString *str = [self.bet_number substringFromIndex:self.bet_number.length-1];
        if ([str  isEqual: @","]) {
            self.bet_number = [self.bet_number substringToIndex:([self.bet_number length]-1)];
        }
       
    }
    //判断是否是要全选才算一注
    if ([self.model.calculate[@"method"]  isEqual: @"formula_num_multiply"]) {
        NSArray *array = [self.bet_number componentsSeparatedByString:@","];
        //选择了多少住
        self.selectAllCount = 1;
        for (NSString *numberStr in array) {
            self.selectAllCount = self.selectAllCount *numberStr.length;
        }
        if ([self.wf_flag isEqual:@"ssc_lhd"]) {
            self.selectAllCount = self.selectAllCount/2;
            NSMutableString *lhdStr = [[NSMutableString alloc]init];
           
            for (KKLotteryDataModel *dataModel in self.dataArrayM) {
                NSArray *arr = dataModel.dataSource;
                for (LotteryDetailModel *model in arr) {
                    if (model.isSelect) {
                        [lhdStr appendFormat:@"%@,", model.number];
                        
                    }
                }
                [lhdStr appendString:@"-"];
                }
            NSString *lhdStr1 = lhdStr;
            NSArray *arr0 = [lhdStr1 componentsSeparatedByString:@",-"];
            self.bet_number = [NSString stringWithFormat:@"%@-%@",arr0[0],arr0[1]];
           
            }
       //formula_group要全选才能投注投注的是选号的注数
    }else if([self.model.calculate[@"method"]  isEqual: @"formula_group"]){
        self.selectAllCount = 1;
        NSArray *array = [self.bet_number componentsSeparatedByString:@","];
        for (NSString *numberStr in array) {
            self.selectAllCount = self.selectAllCount *numberStr.length;
        }
        self.selectAllCount = self.selectAllCount*array.count;
       
        
    }else if([self.model.calculate[@"method"]  isEqual: @"formula_zx_one_more"]){//所有的组选
        self.selectAllCount = 0;
        
        NSArray *array = [self.bet_number componentsSeparatedByString:@","];
        NSString *moreRow = array[0];
        NSString *base_len  = array[1];
        if (moreRow.length>=[self.model.calculate[@"moreRow"] integerValue] &&base_len.length>=[self.model.calculate[@"base_len"] integerValue]) {
            if ([self.model.calculate[@"moreRow"] integerValue]>[self.model.calculate[@"base_len"] integerValue]) {
                for (int i =0; i<base_len.length; i++) {
                    NSMutableString *newStr = [[NSMutableString alloc]init];
                    
                    NSString * subString1 = [base_len substringToIndex:i+1];
                    NSString * subString2 = [subString1 substringFromIndex:i];
                    NSArray *moreRowArray = [moreRow componentsSeparatedByString:subString2];
                    for (NSString *str in moreRowArray) {
                        [newStr appendString:str];
                    }
                 
                    NSInteger moreRowIntager = [self.model.calculate[@"moreRow"] integerValue];
                    NSInteger molecular = 1;
                    NSInteger denominator = 1;
                    NSInteger length = newStr.length;
                    while (moreRowIntager>=1) {
                        molecular = molecular * moreRowIntager;
                        denominator = denominator * length;
                        length --;
                        moreRowIntager --;
                    }
                   
                    self.selectAllCount = self.selectAllCount + denominator/molecular;
                }
            }else {
                for (int i =0; i<moreRow.length; i++) {
                    NSMutableString *newStr = [[NSMutableString alloc]init];
                    
                    NSString * subString1 = [moreRow substringToIndex:i+1];
                    NSString * subString2 = [subString1 substringFromIndex:i];
                    NSArray *moreRowArray = [base_len componentsSeparatedByString:subString2];
                    for (NSString *str in moreRowArray) {
                        [newStr appendString:str];
                    }
                    NSInteger moreRowIntager = [self.model.calculate[@"base_len"] integerValue];
                    NSInteger molecular = 1;
                    NSInteger denominator = 1;
                    NSInteger length = newStr.length;
                    while (moreRowIntager>=1) {
                        molecular = molecular * moreRowIntager;
                        denominator = denominator * length;
                        length --;
                        moreRowIntager --;
                    }
                    self.selectAllCount = self.selectAllCount + denominator/molecular;
                }
            }
        }
    
    }else if([self.model.calculate[@"method"]  isEqual: @"formula_zx_fs"]){//formula_zx_fs组选只有一行的
    //base_len
        self.selectAllCount = 0;
        if (self.bet_number.length>= [self.model.calculate[@"base_len"] integerValue]) {
            NSInteger moreRowIntager = [self.model.calculate[@"base_len"] integerValue];
            NSInteger molecular = 1;
            NSInteger denominator = 1;
            NSInteger length = self.bet_number.length;
            while (moreRowIntager>=1) {
                molecular = molecular * moreRowIntager;
                denominator = denominator * length;
                length --;
                moreRowIntager --;
            }
            self.selectAllCount =  denominator/molecular;
        }
    }else if([self.model.calculate[@"method"]  isEqual: @"formula_rx_zhi_fs"]){
//        self.selectAllCount = [self countRX:self.bet_number andVlue:[self.model.calculate[@"base_len"] integerValue]];
        
        //formula_rx_value_add和值
    }
   else if(self.model.param[@"num_location"]){
       self.bet_number = [NSString stringWithFormat:@"%@@%@",self.selectTitleStr,self.bet_number];
       NSLog(@"%@",self.bet_number);
        self.selectAllCount = [self countRX:self.bet_number andVlue:[self.model.calculate[@"base_len"] integerValue] andNum_len:[self.model.calculate[@"num_len"] integerValue]];
        NSString *str = [self.bet_number substringFromIndex:self.bet_number.length-1];
       if ([str  isEqual: @"$"]) {
           self.bet_number = [self.bet_number substringToIndex:([self.bet_number length]-1)];
       }
      
        //self.model.param[@"num_location"]和值
    }
    //后三直选和值
    if ([self.wf_flag  isEqual: @"ssc_h3zhix_hz"] ||[self.wf_flag  isEqual: @"ssc_q3zhix_hz"]||[self.wf_flag isEqual:@"ssc_z3zhix_hz"]) {
        
        self.selectAllCount = [self ssc_r3zhix_hz:[self.bet_number componentsSeparatedByString:@","]] +1;
    }
    //后二直选和值
    if ([self.wf_flag  isEqual: @"ssc_q2zhix_hz"] ||[self.wf_flag  isEqual: @"ssc_h2zhix_hz"]) {
        
        self.selectAllCount = [self ssc_r2zhix_hz:[self.bet_number componentsSeparatedByString:@","]] +1;
    }
    //任四直选复式
    if ([self.wf_flag  isEqual: @"ssc_r4zhix_fs"]) {
        NSArray *array = [self.bet_number componentsSeparatedByString:@","];
        NSInteger index = 0;
        for (NSString *numberStr in array) {
           
            if (numberStr.length>0) {
                        index++;
                        }
                }
        self.selectAllCount = 1;
        if (index ==4) {
            for (NSString *numberStr in array) {
                if (numberStr.length != 0) {
                   self.selectAllCount = self.selectAllCount *numberStr.length;
                }
                
            }
        }else{
        self.selectAllCount = [LotteryAlgorithm ssc_r4zhix_fs:self.bet_number];
        }
    }
    if ([self.wf_flag  isEqual: @"ssc_r3zhix_fs"]) {
        NSArray *array = [self.bet_number componentsSeparatedByString:@","];
        NSInteger index = 0;
        for (NSString *numberStr in array) {
            
            if (numberStr.length>0) {
                index++;
            }
        }
        self.selectAllCount = 1;
        if (index ==3) {
            for (NSString *numberStr in array) {
                if (numberStr.length != 0) {
                    self.selectAllCount = self.selectAllCount *numberStr.length;
                }
                
            }
        }else{
            self.selectAllCount = [LotteryAlgorithm ssc_r3zhix_fs:self.bet_number];
        }
    }
    if ([self.wf_flag  isEqual: @"ssc_r2zhix_fs"]) {
        NSArray *array = [self.bet_number componentsSeparatedByString:@","];
        NSInteger index = 0;
        for (NSString *numberStr in array) {
            
            if (numberStr.length>0) {
                index++;
            }
        }
        self.selectAllCount = 1;
        if (index ==2) {
            for (NSString *numberStr in array) {
                if (numberStr.length != 0) {
                    self.selectAllCount = self.selectAllCount *numberStr.length;
                }
                
            }
        }else{
            self.selectAllCount = [LotteryAlgorithm ssc_r2zhix_fs:self.bet_number];
        }
    }
    if ([self.wf_flag isEqual:@"ssc_q3zhix_kd"]||[self.wf_flag isEqual:@"ssc_z3zhix_kd"]||[self.wf_flag isEqual:@"ssc_h3zhix_kd"]) {
        self.selectAllCount = [LotteryAlgorithm ssc_q3zhix_kd:self.bet_number];
    }
    if ([self.wf_flag isEqual:@"ssc_h2zhix_kd"]||[self.wf_flag isEqual:@"ssc_q2zhix_kd"]) {
        self.selectAllCount = [LotteryAlgorithm ssc_q2zhix_kd:self.bet_number];
    }
    if ([self.wf_flag isEqual:@"ssc_h3zux_h3zuxbd"]||[self.wf_flag isEqual:@"ssc_q3zux_q3zuxbd"]||[self.wf_flag isEqual:@"ssc_z3zux_z3zuxbd"]) {
        
        self.selectAllCount = 54 * [self.bet_number componentsSeparatedByString:@","].count;
    }
    if ([self.wf_flag isEqual:@"ssc_h2zux_bd"]||[self.wf_flag isEqual:@"ssc_q2zux_bd"]) {
        
        self.selectAllCount = 9 * [self.bet_number componentsSeparatedByString:@","].count;
    }
    if ([self.wf_flag isEqual:@"ssc_q3zux_q3zu3fs"]||[self.wf_flag isEqual:@"ssc_z3zux_z3zu3fs"]||[self.wf_flag isEqual:@"ssc_h3zux_h3zu3fs"]) {
        
        self.selectAllCount = self.bet_number.length *(self.bet_number.length-1);
    }
    //前三组选和值
    if ([self.wf_flag isEqual:@"ssc_q3zux_q3zuxhz"]||[self.wf_flag  isEqual: @"ssc_z3zux_z3zuxhz"]||[self.wf_flag isEqual:@"ssc_h3zux_h3zuxhz"]) {
        NSArray *tempArray = [self.bet_number componentsSeparatedByString:@","];
        for (NSString *str in tempArray) {
            self.selectAllCount = [LotteryAlgorithm ssc_r3zux_hz:[str integerValue]]  +self.selectAllCount-1;
        }
        
    }
    //任2组选和值
    if ([self.wf_flag isEqual:@"ssc_q2zux_hz"]||[self.wf_flag  isEqual: @"ssc_h2zux_hz"]) {
       self.selectAllCount = [self ssc_r2zux_hz:[self.bet_number componentsSeparatedByString:@","]];
        
    }
    
    NSString *str2 = [NSString stringWithFormat:@"%ld",(long)self.selectAllCount];
    NSString *str1 = [NSString stringWithFormat:@"%ld注%.2f元",(long)self.selectAllCount,self.selectAllCount*2.0/self.selectMoneryModel*[self.footView.timesTextField.text floatValue]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(0,str2.length)];
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(str2.length+1,str1.length-str2.length-2)];
    self.footView.bettingMoneyLabel.text = [str string];
    
}
-(NSInteger )countRX:(NSString *)bet_number andVlue:(NSInteger)value andNum_len:(NSInteger)num_len{
    NSArray *tempArr = [bet_number componentsSeparatedByString:@"@"];
    NSArray *tempArr2 = [tempArr[0] componentsSeparatedByString:@","];
    NSArray *temparr3 = [tempArr[1] componentsSeparatedByString:@","];
    NSArray *temparr4 = [tempArr[1] componentsSeparatedByString:@"$"];//是否是&隔开，和逗号隔开
    NSInteger topCount = [self factorial:tempArr2.count andEndCount:value];
    if (num_len &&temparr3.count==1) {
        NSString *tempStr = tempArr[1];
        if ([self.wf_flag isEqual:@"ssc_r3zux_z3fs"]) {
            topCount = tempStr.length*(tempStr.length-1)*topCount;
        }else{
        topCount = topCount *[self factorial:tempStr.length andEndCount:num_len];
        }
        return topCount;
    }else if(temparr3.count>1){
        NSInteger rowCount = 0;
        NSString *moreRow = temparr3[0];
        NSString *base_len  = temparr3[1];
        if (moreRow.length>=[self.model.calculate[@"moreRow"] integerValue] &&base_len.length>=[self.model.calculate[@"num_len"] integerValue]) {
            if ([self.model.calculate[@"moreRow"] integerValue]>[self.model.calculate[@"num_len"] integerValue]) {
                for (int i =0; i<base_len.length; i++) {
                    NSMutableString *newStr = [[NSMutableString alloc]init];
                    
                    NSString * subString1 = [base_len substringToIndex:i+1];
                    NSString * subString2 = [subString1 substringFromIndex:i];
                    NSArray *moreRowArray = [moreRow componentsSeparatedByString:subString2];
                    for (NSString *str in moreRowArray) {
                        [newStr appendString:str];
                    }
                    NSInteger moreRowIntager = [self.model.calculate[@"moreRow"] integerValue];
                    rowCount = rowCount + [self factorial:newStr.length andEndCount:moreRowIntager];
                }
            }else {
                for (int i =0; i<moreRow.length; i++) {
                    NSMutableString *newStr = [[NSMutableString alloc]init];
                    
                    NSString * subString1 = [moreRow substringToIndex:i+1];
                    NSString * subString2 = [subString1 substringFromIndex:i];
                    NSArray *moreRowArray = [base_len componentsSeparatedByString:subString2];
                    for (NSString *str in moreRowArray) {
                        [newStr appendString:str];
                    }
                   NSInteger moreRowIntager = [self.model.calculate[@"num_len"] integerValue];
                   rowCount = rowCount + [self factorial:newStr.length andEndCount:moreRowIntager];
                }
            }
        }
        return topCount * rowCount;
    }else if(temparr4.count>1){
        if ([self.wf_flag isEqual:@"ssc_r3zux_hz"]) {//任三组选和值。。。和前三组选和值一样
            NSInteger tempCount = 0;
            for (int i =0; i<temparr4.count-1; i++) {
                tempCount = tempCount + [LotteryAlgorithm ssc_r3zux_hz:[temparr4[i] integerValue]];
            }
            return tempCount*topCount;
        }else if ([self.wf_flag isEqual:@"ssc_r3zhix_hz"]){////任三直选和值。。。和前三直选和值一样
            return  [self ssc_r3zhix_hz:temparr4]*topCount;
        }else if ([self.wf_flag isEqual:@"ssc_r2zhix_hz"]){////任二直选和值。。。和前二直选和值一样
            return  [self ssc_r2zhix_hz:temparr4]*topCount;
        }else if ([self.wf_flag isEqual:@"ssc_r2zux_hz"]){
            return [self ssc_r2zux_hz:temparr4] *topCount;
        }
        
    }else if (temparr3.count == 1 &&!num_len){
        NSString *tempStr = tempArr[1];
        topCount = topCount *[self factorial:tempStr.length andEndCount:value];
        return topCount;
    }
    
    return 0;

}
//前三直选跨度

-(NSInteger)ssc_r2zux_hz:(NSArray *)tempArray{
    NSInteger selectIndex = 0;
    for (NSString *str in tempArray) {
        NSInteger index = [str integerValue];
        if (index>9) {
            index = index - (index -9)*2;
            
        }
        selectIndex = selectIndex + (index+1)/2;
    }
    return selectIndex;
}
//任三直选和值。。。和前三直选和值一样
-(NSInteger)ssc_r3zhix_hz:(NSArray*)tempArr{
    NSInteger selectIndex = 0;
 
    for (NSString *str in tempArr) {
        NSInteger index = [str integerValue] +1;
        if (index>14) {
            index = index - ((index -14)*2-1);
            
        }
        if (index>10) {
            switch (index) {
                case 11:
                selectIndex = selectIndex+63;
                break;
                case 12:
                selectIndex = selectIndex+69;
                break;
                case 13:
                selectIndex = selectIndex+73;
                break;
                case 14:
                selectIndex = selectIndex+75;
                break;
                default:
                break;
            }
        }else{
        while (index>0) {
           selectIndex = selectIndex + index;
           index -- ;
        }
        }
    }
    return selectIndex-1;
}
//任二直选和值。。。和前二直选和值一样
-(NSInteger)ssc_r2zhix_hz:(NSArray*)tempArr{
    NSInteger selectIndex = 0;
    
    for (NSString *str in tempArr) {
        NSInteger index = [str integerValue] +1;
        if (index>10) {
            index = index - (index -10)*2;
            
        }
        selectIndex = selectIndex + index;
    }
    return selectIndex-1;
}
//求阶乘
-(NSInteger)factorial:(NSInteger)stareCoune andEndCount:(NSInteger)endCount{
    NSInteger molecular = 1;
    NSInteger denominator = 1;
    while (endCount>=1) {
        molecular = molecular * endCount;
        denominator = denominator * stareCoune;
        stareCoune --;
        endCount --;
    }
    return  denominator/molecular;

}
#pragma mark开始编辑的时候跳转键盘view

-(void)stareEditing:(NSString *)str{
    KeyBoardView *keyBoardView = [[KeyBoardView alloc]initWithFrame:CGRectMake(0, -50, MCScreenWidth, MCScreenHeight)];
    keyBoardView.backgroundColor = [UIColor clearColor];
    keyBoardView.countTextField.text = str;
    [keyBoardView setTimesOrPreiod:@"倍"];
    keyBoardView.delegate = self;
    [self.view addSubview:keyBoardView];
}
//删除按钮
-(void)deleteClick{
    for (KKLotteryDataModel *dataModel in self.dataArrayM) {
        NSArray *arr = dataModel.dataSource;
        dataModel.selectedBtnIndex = -1;
        for (LotteryDetailModel *model in arr) {
            model.isSelect = 0;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"0注0.00元"];
        [str2 addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(0,1)];
        [str2 addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,4)];
        self.footView.bettingMoneyLabel.text = [str2 string];
    });
    
}

-(void)didClickConfirmBtnWithCommission:(NSInteger)commission rate:(NSInteger)rate content:(NSString *)content isUncoverPublish:(BOOL)isUncover{
    KKBettingResultView *resultView = [KKBettingResultView new];
    [resultView setTitle:@"提示" tip:@"您的跟单将在您成功投注后生效" detail:@"您的跟单将在您成功投注后生效" confirmStr:@"确定" failureStr:@""];
    resultView.backgroundColor = [UIColor clearColor];
    [self.view.window addSubview:resultView];
    [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view.window);
    }];
    resultView.confirmBlock= ^{
        [self chaseLotteryWithCommission:commission rate:rate content:content isUncoverPublish:isUncover];
    };
    resultView.didClickBgViewBlock = ^{
        
    };
}

-(void)didClickCancelBtn{
    self.footView.makeMoneyButton.selected = NO;
}

-(void)earnCommissionsClick{
    if (![self judgeIsBet]) {
        self.footView.makeMoneyButton.selected = NO;
        return;
    }
    [self.ecBounceView removeFromSuperview];
    self.ecBounceView = nil;
    [self.view addSubview:self.ecBounceView];
    self.ecBounceView.delegate = self;
    [self.ecBounceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

//追号按钮的点击
-(void)chaseClick{
    [self chaseLotteryWithCommission:0 rate:0 content:nil isUncoverPublish:0];
    
     [self deleteClick];
}

-(void)chaseLotteryWithCommission:(NSInteger)commission rate:(NSInteger)rate content:(NSString *)content isUncoverPublish:(BOOL)isUncover{
    self.footView.makeMoneyButton.selected = NO;
    ChaseLotteryV2ViewController *chaseLotteryVc = [[ChaseLotteryV2ViewController alloc]init];
    chaseLotteryVc.bet_number = self.bet_number;
    chaseLotteryVc.lottery_id = self.lottery_id;
    NSString *lottery_modes;
    if (self.selectMoneryModel == 1.00) {
        lottery_modes = @"0";
    }else if (self.selectMoneryModel == 10.00){
        lottery_modes = @"1";
    }else{
        lottery_modes = @"2";
    }
    if (![self judgeIsBet]) {
        return;
    }
    chaseLotteryVc.wf_flag = self.wf_flag;
    chaseLotteryVc.selectAllCount = self.selectAllCount;
    chaseLotteryVc.bet_times = self.footView.timesTextField.text;
    chaseLotteryVc.lottery_modes = lottery_modes;
    self.isPushToWFViewController = NO;
    if(!kStringIsEmpty(content)){
        chaseLotteryVc.content = content;
        chaseLotteryVc.back_rate = rate;
        chaseLotteryVc.commission = commission;
        chaseLotteryVc.isUncoverPublish = isUncover;
    }
    [self.navigationController pushViewController:chaseLotteryVc animated:YES];
}

-(BOOL)judgeIsBet{
    if (self.selectAllCount==0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请选择一组号码"];
        return NO;
    }
       return YES;
}
//投注按钮的点击
-(void)bettingClick{
    
    if (![self judgeIsBet]) {
        return;
    }
    if (self.isCaps) {
        [MCView BSAlertController_twoOptions_viewController:self message:@"本期已封单,直接为您投注到下一期" confirmTitle:@"确定" cancelTitle:@"取消" confirm:^{
            [self bettingActionWithLotteryNumber:self.nextLotteryModel.next_qh];
        } cancle:^{
            
        }];
        return;
    }
    [self bettingActionWithLotteryNumber:self.nextLotteryModel.lottery_qh];

}

-(void)bettingActionWithLotteryNumber:(NSString *)lotteryNum{
    [self.bettingView removeFromSuperview];
    self.bettingView = nil;
    
    [self.bettingView.timeView setPeriod:[NSString stringWithFormat:@"距%@期截止:",lotteryNum] andTime:self.nextLotteryModel.lock_time andEndTimer:self.nextLotteryModel.plan_kj_time];
    
    NSString *moneyStr = [NSString stringWithFormat:@"%.2f元(一注%.2f元)",self.selectAllCount*2.0/self.selectMoneryModel*[self.footView.timesTextField.text floatValue],(self.selectAllCount*2.0/self.selectMoneryModel*[self.footView.timesTextField.text floatValue]) / self.selectAllCount];
    
    
    [self.bettingView setData:self.model.title andMoney:moneyStr andBalance:self.balanceStr];
    
    [self.view.window addSubview:self.bettingView];
    
    [self.bettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view.window);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.bettingView.cancelBlock = ^{
        [weakSelf reloadLotteryTime];
    };
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"bet/bet-order"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSString *lottery_modes;
    if (self.selectMoneryModel == 1.00) {
        lottery_modes = @"0";
    }else if (self.selectMoneryModel == 10.00){
        lottery_modes = @"1";
    }else{
        lottery_modes = @"2";
    }
    /*投注模式 （默认为0） 0:元 1:角 2:分*/
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 @"user_token" : token,
                                 @"platform"   : @"2",
                                 @"lottery_qh" : lotteryNum,
                                 @"wf_flag"    : self.wf_flag,
                                 @"bet_number" : self.bet_number,
                                 @"bet_times"  : self.footView.timesTextField.text,
                                 @"bet_count"  : @(self.selectAllCount),
                                 @"max_return_point" :@"0",
                                 @"lottery_modes"    : lottery_modes,
                                 };
    
    [self.bettingView bettingFinish:^{
        
        [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self success:^(id data) {
            if (IS_SUCCESS) {
                self.selectAllCount = 0;
                [self sendNetWorking:self.wf_flag];
                KKBettingResultView *resultView = [KKBettingResultView new];
                [resultView setTitle:@"投注成功" tip:@"好运即将到来!" confirmStr:@"继续投注" failureStr:@"投注记录"];
                resultView.backgroundColor = [UIColor clearColor];
                [self.view.window addSubview:resultView];
                [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self.view.window);
                }];
                resultView.confirmBlock= ^{
                    [self reloadLotteryTime];
                    [self getBalance];
                };
                resultView.otherBlock= ^{
                    KKBetRecordViewController *betRecordVC = [KKBetRecordViewController new];
                    [self.navigationController pushViewController:betRecordVC animated:YES];
                    
                };
                resultView.didClickBgViewBlock = ^{
                    [self reloadLotteryTime];
                    [self getBalance];
                };
            }
        } error:^(id data) {
            if([(NSString *)data isEqualToString:@"用户余额不足"]){
                KKBettingResultView *resultView = [KKBettingResultView new];
                [resultView setTitle:@"投注失败" tip:@"余额不足        把握机会" confirmStr:@"马上充值" failureStr:@"取消"];
                resultView.backgroundColor = [UIColor clearColor];
                [self.view.window addSubview:resultView];
                [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self.view.window);
                }];
                resultView.confirmBlock= ^{
                    [self.tabBarController setSelectedIndex:1];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                };
                resultView.otherBlock=^{
                    
                };
                resultView.didClickBgViewBlock = ^{
                    
                };
            }else{
               [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:data];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }];
}

//查看奖金的点击时间
-(void)lookBonusClick{
    if (self.wf_pl.count>1) {
        [self.view.window addSubview:self.rodiaView];
        self.rodiaView.playLabel.text = @"奖金提示";
        NSMutableString *str = [[NSMutableString alloc]init];
        for (NSDictionary *dict in self.wf_pl) {
            
            [str appendString:[NSString stringWithFormat:@"%@：%.2f",dict[@"pl_name"],[dict[@"award_money"] floatValue]]];
            [str appendString:@"\n"];
        }
        self.rodiaView.type_topLabel.text = str;
        [self.rodiaView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.view.window);
        }];

    }
}

//开始编辑金钱的模式
-(void)moneyModelStareEditing{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择模式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"元" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.selectMoneryModel = 1.00;
        self.footView.modelTextField.text = @"元";
        [self selectNumber];
        [self changeBouns];
    }];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"角" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.selectMoneryModel = 10.00;
        self.footView.modelTextField.text = @"角";
        [self selectNumber];
        [self changeBouns];
    }];
    UIAlertAction * pointsAction = [UIAlertAction actionWithTitle:@"分" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.selectMoneryModel = 100.00;
        self.footView.modelTextField.text = @"分";
        [self selectNumber];
        [self changeBouns];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:libraryAction];
    [alertController addAction:cameraAction];
    [alertController addAction:pointsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)changeBouns{
    NSDictionary *dict = self.wf_pl[0];
    
    NSString *str5 = [NSString stringWithFormat:@"单注奖金:%.2f元",[dict[@"award_money"] floatValue]/self.selectMoneryModel];
    NSMutableAttributedString *bonusStr = [[NSMutableAttributedString alloc] initWithString:str5];
    [bonusStr addAttribute:NSForegroundColorAttributeName value:MCUIColorGray range:NSMakeRange(3,str5.length-4)];
    
    self.footView.bonusLabel.text = [bonusStr string];
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

#pragma mark 返回
-(void) backClick:(UIButton *)sender {
    [self.navigationController dismissViewControllerAnimated:TRUE completion:NULL];
}

-(void)shakeAction{
    //没有获取数据前无法摇一摇
    KKLotteryDataModel *model = self.dataArrayM[0];
    if(!model.isAlreadyGetData){
        return;
    }
    [KKShakeActionManager shakeActionWithLotteryType:@"时时彩" dataArray:self.dataArrayM wf_flag:self.wf_flag selectedDigitArr:self.selectedDigitArr];

    //当需要随机取得 万位 千位 百位 十位 个位中的相应个数时 因为刷新列表会重新点击位数按钮 无法满足需求 所以只对row进行刷新 而header部分进行匹配比对之后点击相应的按钮来完成需求
    if([self.wf_flag isEqual:@"ssc_r2zhix_hz"] || [self.wf_flag isEqual:@"ssc_r3zhix_hz"] || [self.wf_flag isEqual:@"ssc_r2zux_hz"]||[self.wf_flag isEqual:@"ssc_r3zux_hz"]||[self.wf_flag isEqual:@"ssc_r4zux_12"] || [self.wf_flag isEqual:@"ssc_r2zux_fs"] || [self.wf_flag isEqual:@"ssc_r3zux_z3fs"] || [self.wf_flag isEqual:@"ssc_r3zux_z6hz"] || [self.wf_flag isEqual:@"ssc_r4zux_24"]|| [self.wf_flag isEqual:@"ssc_r4zux_6"]|| [self.wf_flag isEqual:@"ssc_r4zux_4"]){
        if(self.selectedDigitArr.count>0){
            NSArray *digitArr = [self.selectTitleStr componentsSeparatedByString:@","];
            for(int i = 0;i < self.tableHeadView.subviews.count;i++){
                UIView *view = self.tableHeadView.subviews[i];
                if([view isKindOfClass:[UIButton class]]){
                    HeadButton *btn = (HeadButton *)view;
                    //把已经被点击的按钮先恢复
                    for(int k = 0;k<digitArr.count;k++){
                        if(btn.tag - 1000 == [digitArr[k] integerValue]){
                            [self selectTitleClick:btn];
                        }
                    }
                    //再点击随机数对应的按钮
                    for(int j = 0;j < self.selectedDigitArr.count;j++){
                        if(btn.tag - 1000 == [self.selectedDigitArr[j] integerValue]){
                            [self selectTitleClick:btn];
                        }
                    }
                }
            }
        }
        //除了这两种玩法之外 其他的都只有一组数据
        if([self.wf_flag isEqual:@"ssc_r4zux_12"] || [self.wf_flag isEqual:@"ssc_r4zux_4"]){
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }else{
        [self.tableView reloadData];
        [self selectNumber];
    }
    
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
    //设置震动
    
    [self shakeAction];
}

#pragma mark 键盘确定的delegate
-(void)KeyBoardViewSureClick:(NSString *)str{
    
    self.footView.timesTextField.text = str;
    [self selectNumber];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(HeadView *)headView{
    if (!_headView) {
        _headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 40)];
        _headView.delegate = self;
        _headView.backgroundColor = MCMineTableCellBgColor;
    }
    return _headView;
}

-(NSMutableArray *)selectedDigitArr{
    if(!_selectedDigitArr){
        _selectedDigitArr = [NSMutableArray array];
    }
    return _selectedDigitArr;
}

-(FootView *)footView{
    if (!_footView) {
        if (IS_IPHONE_X) {
            
            self.footView = [[FootView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-81-MCTopHeight - 30, MCScreenWidth, 81 + 30)];
        }else{
            self.footView = [[FootView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-81-MCTopHeight, MCScreenWidth, 81)];
        }
        
        NSString *str = [NSString stringWithFormat:@"单注奖金:0元"];
        NSMutableAttributedString *bonusStr = [[NSMutableAttributedString alloc] initWithString:str];
        [bonusStr addAttribute:NSForegroundColorAttributeName value:MCUIColorGray range:NSMakeRange(3,str.length-4)];
   
        self.footView.bonusLabel.attributedText = bonusStr;
        self.footView.backgroundColor = MCUIColorLighttingBrown;
        self.footView.delegate = self;
    }
    return _footView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"标题",@"标题",@"标题",@"标题",@"标题"]];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tag = 1000;
        _tableView.estimatedSectionFooterHeight = 10;
        _tableView.estimatedSectionHeaderHeight = 10;
        _tableView.backgroundColor = MCMineTableCellBgColor;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
         [_tableView registerClass:[KKSSCBaseTableViewCell class] forCellReuseIdentifier:@"cell"];
    } return _tableView;
}
-(NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        KKLotteryDataModel *model = [KKLotteryDataModel new];
        _dataArrayM = [NSMutableArray arrayWithArray:@[model,model,model,model,model]];
    }
    return _dataArrayM;
}
- (KKAccountDetailToolTipView *)toolTipView {
    if (_toolTipView == nil) {
        _toolTipView = [[KKAccountDetailToolTipView alloc] init];
        _toolTipView.backgroundColor = [UIColor clearColor];
    } return _toolTipView;
}

- (EarnCommissionsBouncedView *)ecBounceView {
    if (_ecBounceView == nil) {
        _ecBounceView = [[EarnCommissionsBouncedView alloc] init];
        _ecBounceView.backgroundColor = [UIColor clearColor];
    }
    return _ecBounceView;
}

-(BouncedView *)bounceView{
    if (!_bounceView) {
        _bounceView = [[BouncedView alloc]init];
        _bounceView.backgroundColor = [UIColor clearColor];
    }
    return _bounceView;
}

-(BettingView *)bettingView{
    if (!_bettingView) {
        _bettingView = [[BettingView alloc]init];
        _bettingView.backgroundColor = [UIColor clearColor];
    }
    return _bettingView;
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

-(NSMutableArray *)titleDataArr{
    if(!_titleDataArr){
        _titleDataArr = [NSMutableArray array];
    }
    return _titleDataArr;
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
