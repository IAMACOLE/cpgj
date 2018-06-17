//
//  SameChaseViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "SameChaseViewController.h"
#import "DoubleChaseTableViewCell.h"
#import "DoubleChaseView.h"
#import "KeyBoardView.h"
#import "DoubleChaseFooterView.h"
#import "NextTheLotteryModel.h"
#import "LockTimeModel.h"

@interface SameChaseViewController ()<DoubleChaseViewDelegate,KeyBoardViewDelegate,DoubleChaseFooterViewDelegate,UITableViewDelegate,UITableViewDataSource,DoubleChaseTableViewCellDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)DoubleChaseView *headView;
@property(nonatomic,strong)DoubleChaseFooterView *footerView;
@property(nonatomic ,assign)NSInteger selectTextFieldStatus;
@property(nonatomic,strong)NextTheLotteryModel *nextLotteryModel;
@property(nonatomic,strong)NSMutableArray *OrderArray;
@property(nonatomic,assign)CGFloat moneyModel;
@property(nonatomic,assign) BOOL isCaps;
@property(nonatomic,copy)NSMutableString *zhuihao_ignore_qh;
@end

@implementation SameChaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    [self initUI];
    
    [self sendNetWorking];
    [self createAllChasePoited];
}
-(void)basicSetting{
    
}
-(void)initUI{
    [self.view addSubview:self.headView];
    
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth, 45));
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(self.footerView.mas_top).with.offset(0);
    }];
}
-(void)sendNetWorking{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/cp-lock-time"];
    NSDictionary * parameter = @{
                                 
                                 @"lottery_id" : self.lottery_id
                                 };
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        
        self.nextLotteryModel = [[NextTheLotteryModel alloc]initWithDictionary:data error:nil];
        [self.headView.timeView setPeriod:[NSString stringWithFormat:@"距%@期截止:",self.nextLotteryModel.lottery_qh] andTime:self.nextLotteryModel.lock_time andEndTimer:self.nextLotteryModel.plan_kj_time];
       self.isCaps = NO;
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
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark 点击生成追单
-(void)generateChaseClick{
    [self.OrderArray removeAllObjects];
    if ([self.headView.preiodTextField.text integerValue]>20) {
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
    for (int i =0 ; i<[self.headView.preiodTextField.text integerValue]; i++) {
        LockTimeModel *timeModel = self.dataArray[i];
        LockTimeModel *model = [[LockTimeModel alloc]init];
        model.lock_time = timeModel.lock_time;
        model.lottery_qh = timeModel.lottery_qh;
        model.timesStr = self.headView.timesTextField.text;
        model.moneyStr = [NSString stringWithFormat:@"%.2f",[self.headView.timesTextField.text floatValue]*_moneyModel*2*self.selectAllCount];
        [self.OrderArray addObject:model];
    }
    [self.headView setAllperiod:self.headView.preiodTextField.text andMoneyStr:[NSString stringWithFormat:@"%.2f",[self.headView.timesTextField.text floatValue]*_moneyModel*[self.headView.preiodTextField.text floatValue]*2*self.selectAllCount]];
    [self.tableView reloadData];
}
//取消下单
-(void)cancelClick{
    [self.OrderArray removeAllObjects];
     [self.headView setAllperiod:@"" andMoneyStr:@""];
    [self.tableView reloadData];
}
#pragma mark 立即下单
-(void)immediateClick{
    if (self.isCaps) {
         [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"本期已封单"];
        return;
    }
    
    if (self.OrderArray.count == 0) {
         [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"还没有生成追单内容"];
        return;
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"bet/bet-order"];
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
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 @"user_token" : token,
                                 @"platform"   : @"2",
                                 @"lottery_qh" : self.nextLotteryModel.lottery_qh,
                                 @"wf_flag"    : self.wf_flag,
                                 @"bet_number" : self.bet_number,
                                 @"bet_times"  : self.headView.timesTextField.text,
                                 @"bet_count"  : @(self.selectAllCount),
                                 @"max_return_point" :@"0",
                                 @"lottery_modes"    : self.lottery_modes,
                                 @"zhuihao_mode"     :@"1",
                                 @"zhuihao_qh"       :self.headView.preiodTextField.text,
                                 @"zhuihao_stop"     :zhuihao_stop,
                                // @"zhuihao_bs"       :self.headView.timesTextField.text,
                                 @"zhuihao_qs_bs"    :self.headView.timesTextField.text,
                                 @"zhuihao_ignore_qh"     :zhuihao_ignore_qh1
                                 };
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        if (IS_SUCCESS) {
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"投注成功"];
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
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
    KeyBoardView *keyBoardView = [[KeyBoardView alloc]initWithFrame:CGRectMake(0, -50, MCScreenWidth, MCScreenHeight)];
    self.selectTextFieldStatus = selectTextFiel;//判断是选择的期还是倍YES是期，No是倍
    keyBoardView.backgroundColor = [UIColor clearColor];
    keyBoardView.countTextField.text = str;
    [keyBoardView setTimesOrPreiod:status];
    keyBoardView.delegate = self;
    [self.view addSubview:keyBoardView];
}

-(void)KeyBoardViewSureClick:(NSString *)str{
    if (self.selectTextFieldStatus == 2) {
       self.headView.timesTextField.text = str;
    }else{
       self.headView.preiodTextField.text = str;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.OrderArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDcell = @"cell";
    DoubleChaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[DoubleChaseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
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
#pragma mark 删除每行
-(void)DoubleChaseTableViewCellDelete:(NSInteger)row{
    LockTimeModel *model = self.OrderArray[row];
    [self.zhuihao_ignore_qh appendString:model.lottery_qh];
    [self.zhuihao_ignore_qh appendString:@"#"];
    
    [self.OrderArray removeObjectAtIndex:row];
    CGFloat allMoney = 0.0;
    for (LockTimeModel *model in self.OrderArray) {
        allMoney = allMoney + [model.moneyStr floatValue];
    }
    [self.headView setAllperiod:[NSString stringWithFormat:@"%ld",self.OrderArray.count] andMoneyStr:[NSString stringWithFormat:@"%.2f",allMoney]];
    self.headView.preiodTextField.text = [NSString stringWithFormat:@"%ld",self.OrderArray.count];
    [self.tableView reloadData];
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

-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, MCScreenWidth, MCScreenHeight-64-50) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 50;
        //       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(DoubleChaseFooterView *)footerView{
    if (!_footerView) {
        self.footerView = [[DoubleChaseFooterView alloc]init];
        self.footerView.delegate = self;
        self.footerView.backgroundColor = MCUIColorWhite;
        
    }
    return _footerView;
}
-(DoubleChaseView *)headView{
    if (!_headView) {
        self.headView = [[DoubleChaseView alloc]initWithFrame:CGRectMake(0, 50, MCScreenWidth, 186)];
        self.headView.backgroundColor = MCUIColorWhite;
        self.headView.delegate = self;
        [self.headView setAllperiod:@"" andMoneyStr:@""];
    }
    return _headView;
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
