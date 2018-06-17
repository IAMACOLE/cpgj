//
//  ChaseLotteryV2ViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "ChaseLotteryV2ViewController.h"
#import "KeyBoardView.h"
#import "NextTheLotteryModel.h"
#import "ChaseLotteryHeaderView.h"
#import "ChaseLotteryTableViewCell.h"
#import "ChaseLotteryFooterView.h"
#import "KKBettingSelectedTableViewCell.h"
#import "KKBettingResultView.h"
#import "KKBetRecordViewController.h"
#import "EarnCommissionsBouncedView.h"

@interface ChaseLotteryV2ViewController ()<UITableViewDelegate,UITableViewDataSource,KeyBoardViewDelegate,ChaseLotteryTableViewCellDelegate,ChaseLotteryFooterViewDelegate,ChaseLotteryHeaderViewDelegate,EarnCommissionsBouncedViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
//@property(nonatomic,strong)UITableView *selectedNumTableView;
@property(nonatomic,strong)UITextView *selectedNumTextView;
@property(nonatomic,strong)ChaseLotteryHeaderView *headView;
@property(nonatomic,strong)ChaseLotteryFooterView *footerView;
@property (nonatomic, strong)EarnCommissionsBouncedView *ecBounceView;
@property(nonatomic ,assign)NSInteger selectTextFieldStatus;//1是追号期数，2，追号倍数，3隔多少期，4倍数
@property(nonatomic,strong)NextTheLotteryModel *nextLotteryModel;
@property(nonatomic,strong)NSMutableArray *OrderArray;
@property(nonatomic,copy)NSMutableString *zhuihao_ignore_qh;
@property(nonatomic,assign)CGFloat moneyModel;
@property(nonatomic,assign) BOOL isCaps;
@property(nonatomic,strong)NSMutableArray *bettingNumArr;
@property(nonatomic,strong)UIImageView *mainBGView;


@end

@implementation ChaseLotteryV2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendNetWorking) name:@"APPDidBecomeActive" object:nil];
    [self.bettingNumArr addObject:self.bet_number];
    [self initUI];
    [self createAllChasePoited];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self sendNetWorking];
}



-(void)initUI{
    
     self.titleString = @"智能追号";
    
//    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.footerView];
    _footerView.bettingNumberStr = self.bettingNumArr[0];
    _footerView.makeMoneyButton.selected = !kStringIsEmpty(self.content);
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(0);
     //   make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        if (IS_IPHONE_X) {
            make.size.mas_equalTo(CGSizeMake(MCScreenWidth, 68 + 30));
        }else{
            make.size.mas_equalTo(CGSizeMake(MCScreenWidth, 68));
        }
    
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.footerView.mas_top).with.offset(0);
        
    }];
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.backgroundView = self.mainBGView;
    
}

-(void)sendNetWorking{

    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cp-lock-time"];
    NSDictionary * parameter = @{
                                 
                                 @"lottery_id" : self.lottery_id
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        self.nextLotteryModel = [[NextTheLotteryModel alloc]initWithDictionary:data error:nil];
        [self.headView.timeView setPeriod:[NSString stringWithFormat:@"距%@期截止:",self.nextLotteryModel.lottery_qh] andTime:self.nextLotteryModel.lock_time andEndTimer:self.nextLotteryModel.plan_kj_time];
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)createAllChasePoited{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/lottery-qh"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSArray *array = data;
        for (NSDictionary *dict in array) {
            LockTimeModel *model = [[LockTimeModel alloc]initWithDictionary:dict error:nil];
            [self.dataArray addObject:model];
        }
         [self generateChaseClick];
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 删除每行
-(void)ChaseLotteryTableViewCellDelegate:(NSInteger)row{
    LockTimeModel *model = self.OrderArray[row];
    [self.zhuihao_ignore_qh appendString:model.lottery_qh];
    [self.zhuihao_ignore_qh appendString:@"#"];
    
    [self.OrderArray removeObjectAtIndex:row];
    CGFloat allMoney = 0.0;
    for (LockTimeModel *model in self.OrderArray) {
        allMoney = allMoney + [model.moneyStr floatValue];
    }
   // self.headView.preiodTextField.text = [NSString stringWithFormat:@"%ld",self.OrderArray.count];
    
    [self.headView.preiodButton setTitle:[NSString stringWithFormat:@"%ld",self.OrderArray.count] forState:UIControlStateNormal];
    
  
    [self.tableView reloadData];
    [self resetBgLayoutC];
}

#pragma mark 修改总金额
-(void)changeTotalPrices{
    
    CGFloat allMoney = 0.0;
    for (LockTimeModel *model in self.OrderArray) {
        allMoney = allMoney + [model.moneyStr floatValue];
    }
   [self.footerView setAllperiod:[NSString stringWithFormat:@"%ld",self.OrderArray.count] andMoneyStr:[NSString stringWithFormat:@"%.2f",allMoney]];
}

#pragma mark 点击生成追单
-(void)generateChaseClick{
    [self.OrderArray removeAllObjects];
    if ([self.headView.preiodButton.titleLabel.text integerValue]>20) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"最多只能追20期"];
        return;
    }
    
    /*投注模式 （默认为0） 0:元 1:角 2:分*/
    self.moneyModel = 1.0;
    switch ([self.lottery_modes integerValue]) {
        case 0:
            _moneyModel = 1.00;
            break;
        case 1:
            _moneyModel = 0.10;
            break;
        case 2:
            _moneyModel = 0.01;
        default:
            break;
    }
    
    CGFloat allMoney = 0.0;
    int temp = 1;
    for (int i =0 ; i<[self.headView.preiodButton.titleLabel.text integerValue]; i++) {
        LockTimeModel *timeModel = self.dataArray[i];
        LockTimeModel *model = [[LockTimeModel alloc]init];
        model.lock_time = timeModel.lock_time;
        model.lottery_qh = timeModel.lottery_qh;
        model.show_qh = timeModel.show_qh;
        
        if(i!=0&&i%[self.headView.modelButton.titleLabel.text integerValue]==0){
            temp=temp*[self.headView.bonusButton.titleLabel.text intValue];
            if (temp > BigBettingRate) {
                temp = BigBettingRate;
            }
        }
        if (temp>1) {
            model.timesStr = [NSString stringWithFormat:@"%ld",[self.headView.timesButton.titleLabel.text integerValue]*temp];
            if ([model.timesStr integerValue] > BigBettingRate) {
                model.timesStr = [NSString stringWithFormat:@"%d",BigBettingRate];
            }
        }else{
            model.timesStr = [NSString stringWithFormat:@"%ld",[self.headView.timesButton.titleLabel.text integerValue]];
        }
        model.moneyStr = [NSString stringWithFormat:@"%.2f",[model.timesStr floatValue]*_moneyModel*2*self.selectAllCount];
        allMoney = allMoney + [model.moneyStr floatValue];
        [self.OrderArray addObject:model];
    }

    [self.footerView setAllperiod:[NSString stringWithFormat:@"%ld",self.OrderArray.count] andMoneyStr:[NSString stringWithFormat:@"%.2f",allMoney]];
    
    [self.tableView reloadData];
    [self resetBgLayoutC];

}
//取消下单
-(void)cancelClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickConfirmBtnWithCommission:(NSInteger)commission rate:(NSInteger)rate content:(NSString *)content isUncoverPublish:(BOOL)isUncover{
    self.content = content;
    self.back_rate = rate;
    self.commission = commission;
    self.isUncoverPublish = isUncover;
    
    KKBettingResultView *resultView = [KKBettingResultView new];
    [resultView setTitle:@"提示" tip:@"您的跟单将在您成功投注后生效" detail:@"您的跟单将在您成功投注后生效" confirmStr:@"确定" failureStr:@""];
    resultView.backgroundColor = [UIColor clearColor];
    [self.view.window addSubview:resultView];
    [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view.window);
    }];
    resultView.confirmBlock= ^{
    };
    resultView.didClickBgViewBlock = ^{
        
    };
}

-(void)didClickCancelBtn{
    [self.footerView.makeMoneyButton setSelected:NO];
}

//中奖即停说明
-(void)noteBtnClick{
    
}

-(void)immediateClick{
    if (self.OrderArray.count == 0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"还没有生成追单内容"];
         [self.footerView.makeMoneyButton setSelected:NO];
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

-(void)bettingBtnClick{
    
    if (self.isCaps) {
        [MCView BSAlertController_twoOptions_viewController:self message:@"本期已封单,直接为您投注到下一期" confirmTitle:@"确定" cancelTitle:@"取消" confirm:^{
            [self bettingActionWithLotteryNumberCountByAllCount:NO];
        } cancle:^{
            
        }];
        return;
    }
    
    if (self.OrderArray.count == 0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"还没有生成追单内容"];
        return;
    }
    [self bettingActionWithLotteryNumberCountByAllCount:YES];
  
}

-(void)bettingActionWithLotteryNumberCountByAllCount:(BOOL)isAllCount{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/bet/bet-order-zh"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSString *zhuihao_stop;
    if (self.footerView.stopChaseButton.selected) {
        zhuihao_stop = @"1";
    }else{
        zhuihao_stop = @"0";
    }
    
    NSString * zhuihao_ignore_qh1 = @"";
    if (self.zhuihao_ignore_qh.length>0) {
        zhuihao_ignore_qh1 = self.zhuihao_ignore_qh;
        zhuihao_ignore_qh1 = [zhuihao_ignore_qh1 substringToIndex:([zhuihao_ignore_qh1 length]-1)];
    }

//    [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"正在投注..."];
    NSString *qh_str = @"";
    NSString *time_str = @"";
    
    NSInteger allCount = isAllCount ? self.OrderArray.count : self.OrderArray.count - 1;
    int firstNum = isAllCount ? 0:1;
    
    for(int i = firstNum;i < self.OrderArray.count;i++){
        LockTimeModel *model = self.OrderArray[i];
        qh_str = [qh_str stringByAppendingFormat:@"%@#",model.lottery_qh];
        time_str = [time_str stringByAppendingFormat:@"%@#",model.timesStr];
    }
    qh_str = [qh_str substringToIndex:qh_str.length-1];
    time_str = [time_str substringToIndex:time_str.length-1];
    
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionaryWithDictionary: @{
                                                                                       @"lottery_id" : self.lottery_id,
                                                                                       @"user_token" : token,
                                                                                       @"platform"   : @"2",
                                                                                       @"wf_flag"    : self.wf_flag,
                                                                                       @"bet_number" : self.bet_number,
                                                                                       @"bet_count"  : @(self.selectAllCount),
                                                                                       @"lottery_modes"    : self.lottery_modes,
                                                                                       @"zhuihao_stop"     : zhuihao_stop,
                                                                                       @"zhuihao_count_qs" : [NSString stringWithFormat:@"%zd",allCount],
                                                                                       @"zhuihao_all_qh"   : qh_str,
                                                                                       @"zhuihao_all_bs"   : time_str,
                                                                                       }];
    
    if(_footerView.makeMoneyButton.selected){
        urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/bet/bet-zyj"];
        [parameter setObject:self.content forKey:@"content"];
        [parameter setObject:@(self.back_rate) forKey:@"back_rate"];
        [parameter setObject:@(self.commission) forKey:@"commission"];
        [parameter setObject:@(self.isUncoverPublish) forKey:@"kj_show_hm"];
    }
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self success:^(id data) {
        if (IS_SUCCESS) {
            KKBettingResultView *resultView = [KKBettingResultView new];
            [resultView setTitle:@"投注成功" tip:@"好运即将到来!" detail:@"" confirmStr:@"继续投注" failureStr:@"投注记录"];
            resultView.backgroundColor = [UIColor clearColor];
            [self.view.window addSubview:resultView];
            [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.view.window);
            }];
            resultView.confirmBlock= ^{
                [self.navigationController popViewControllerAnimated:YES];
            };
            resultView.otherBlock= ^{
                KKBetRecordViewController *betRecordVC = [KKBetRecordViewController new];
                [self.navigationController pushViewController:betRecordVC animated:YES];
                
            };
            resultView.didClickBgViewBlock = ^{
                [self.navigationController popViewControllerAnimated:YES];
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
                [self.navigationController popViewControllerAnimated:YES];
            };
        }else {
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:data];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
        
    }];
}

//从新刷新数据
-(void)endTimeReloadData{
    self.isCaps = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self sendNetWorking];
    });
}
//本期已封顶
-(void)endTimeResponder{
    self.isCaps = YES;
    [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"本期已封单"];
}
-(void)stareEditing:(NSString *)str andStatus:(NSString *)status andSelectTextField:(NSInteger)selectTextFiel{
    KeyBoardView *keyBoardView = [[KeyBoardView alloc] init];
    
    if (IS_IPHONE_X) {
        keyBoardView.frame = CGRectMake(0, -85, MCScreenWidth, MCScreenHeight);
    }else{
        keyBoardView.frame = CGRectMake(0, -50, MCScreenWidth, MCScreenHeight);
    }

    self.selectTextFieldStatus = selectTextFiel;//判断是选择的期还是倍YES是期，No是倍
    
    keyBoardView.backgroundColor = [UIColor clearColor];
    keyBoardView.countTextField.text = str;
    [keyBoardView setTimesOrPreiod:status];
    keyBoardView.delegate = self;
    [self.view addSubview:keyBoardView];
}

-(void)KeyBoardViewSureClick:(NSString *)str{
    //1是追号期数，2，追号倍数，3隔多少期，4倍数
    switch (_selectTextFieldStatus) {
        case 1:
            if(str.integerValue >20){
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"最多只能追20期"];
                [self.headView.preiodButton setTitle:@"20" forState:UIControlStateNormal];
                ;
            }else{
               [self.headView.preiodButton setTitle:str forState:UIControlStateNormal];
            }
            
            break;
        case 2:
            if(str.integerValue > BigBettingRate){
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:[NSString stringWithFormat:@"起始倍数最多只能设置%d倍",BigBettingRate]];
                [self.headView.timesButton setTitle:[NSString stringWithFormat:@"%d",BigBettingRate] forState:UIControlStateNormal];
            }else{
                [self.headView.timesButton setTitle:str forState:UIControlStateNormal];
            }
            break;
        case 3:
            if(str.integerValue > BigBettingRate){
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:[NSString stringWithFormat:@"翻倍数最多只能设置%d倍",BigBettingRate]];
                [self.headView.bonusButton setTitle:[NSString stringWithFormat:@"%d",BigBettingRate] forState:UIControlStateNormal];
            }else{
                [self.headView.bonusButton setTitle:str forState:UIControlStateNormal];
            }
           
            break;
        case 4:
            if(str.integerValue > [self.headView.preiodButton.titleLabel.text integerValue]){
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:[NSString stringWithFormat:@"最多只有%@期",self.headView.preiodButton.titleLabel.text]];
                [self.headView.modelButton setTitle:self.headView.preiodButton.titleLabel.text forState:UIControlStateNormal];
            }else{
                [self.headView.modelButton setTitle:str forState:UIControlStateNormal];
            }
            break;
        default:{
            //分单期设置倍数
            if(str.integerValue < 1){
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"最少只能设置1倍"];
                str = @"1";
            }
            if(str.integerValue > BigBettingRate){
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:[NSString stringWithFormat:@"最多只能设置%d倍",BigBettingRate]];
                str = [NSString stringWithFormat:@"%d",BigBettingRate];
            }
            NSInteger row = _selectTextFieldStatus -200;
            LockTimeModel *mode = [self.OrderArray objectAtIndex:row];
            CGFloat tempMoneyStr = [mode.moneyStr floatValue] / [mode.timesStr integerValue];
           
            mode.timesStr = str;
            mode.moneyStr = [NSString stringWithFormat:@"%.2f",tempMoneyStr * [str integerValue]];
            [self.tableView reloadData];
            [self changeTotalPrices];
            return;
        }break;
    }
    [self generateChaseClick];
}

-(void)selectBettingNumberClick:(BOOL)isSenderSelected{
    
    if(isSenderSelected){
        [self.view addSubview:self.selectedNumTextView];
        CGSize textSize = [self.bet_number boundingRectWithSize:CGSizeMake(170, CGFLOAT_MAX)
                                                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kAdapterFontSize(20)]} context:nil].size;
        [self.selectedNumTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.footerView.mas_top);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(textSize.height + 10);
            make.width.mas_equalTo(170);
        }];
        self.selectedNumTextView.text = self.bet_number;
    }else{
        [self.selectedNumTextView removeFromSuperview];
        self.selectedNumTextView = nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.OrderArray.count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *IDcell = @"cell";
    ChaseLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[ChaseLotteryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.row = indexPath.row;
    cell.delegate = self;
    cell.model = self.OrderArray[indexPath.row];
    return cell;
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

-(NSMutableArray *)bettingNumArr{
    if(!_bettingNumArr){
        _bettingNumArr = [NSMutableArray new];
    }
    return _bettingNumArr;
}

- (EarnCommissionsBouncedView *)ecBounceView {
    if (_ecBounceView == nil) {
        _ecBounceView = [[EarnCommissionsBouncedView alloc] init];
        _ecBounceView.backgroundColor = [UIColor clearColor];
    }
    return _ecBounceView;
}

-(UITextView *)selectedNumTextView{
    if(!_selectedNumTextView){
        _selectedNumTextView = [UITextView new];
        _selectedNumTextView.editable = NO;
        _selectedNumTextView.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
        _selectedNumTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _selectedNumTextView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, MCScreenWidth, MCScreenHeight-64-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 34;
        _tableView.tag = 1000;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
-(ChaseLotteryFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[ChaseLotteryFooterView alloc]init];
        _footerView.delegate = self;
        _footerView.backgroundColor = MCUIColorWhite;
        
    }
    return _footerView;
}
-(ChaseLotteryHeaderView *)headView{
    if (!_headView) {
        _headView = [[ChaseLotteryHeaderView alloc] init];
        _headView.frame = CGRectMake(0, 0, MCScreenWidth, 80);
        _headView.backgroundColor = [UIColor clearColor];
        _headView.delegate = self;
    }
    return _headView;
}


-(UIImageView *)mainBGView {
    if (!_mainBGView){
        _mainBGView = [[UIImageView alloc] init];
        _mainBGView.backgroundColor = MCMineTableViewBgColor;
    }
    return _mainBGView;
}

-(void)resetBgLayoutC{
    
    for(UIView *line in self.mainBGView.subviews){
        [line removeFromSuperview];
    }
    
    
}

-(NSMutableArray *)OrderArray{
    if (!_OrderArray) {
        _OrderArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _OrderArray;
}
-(NSMutableString *)zhuihao_ignore_qh{
    if (!_zhuihao_ignore_qh) {
        _zhuihao_ignore_qh = [[NSMutableString alloc]init];
    }
    return _zhuihao_ignore_qh;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
