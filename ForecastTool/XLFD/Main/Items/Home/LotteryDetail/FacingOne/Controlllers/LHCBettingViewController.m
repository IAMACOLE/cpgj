//
//  LHCBettingViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LHCBettingViewController.h"
#import "LHCBettingTableViewCell.h"
#import "LHCFooterView.h"
#import "LHCManager.h"
#import "LHCLotteryModel.h"
#import "KKBettingResultView.h"
#import "KKBetRecordViewController.h"
#import "LotteryDetailBJ28ViewController.h"
#import "LotteryDetailLHCViewController.h"
@interface LHCBettingViewController ()<UITableViewDelegate,UITableViewDataSource,LHCFooterViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UILabel *commentMoney;
@property(nonatomic,strong)UITextField *moneyTextField;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)LHCFooterView *footView;
@property(nonatomic,strong)UIButton *addbutton;

@end

@implementation LHCBettingViewController
#define MCColorGray_light [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    
    self.titleString = @"支付";
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.commentMoney];

    [self.commentMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView).with.offset(10);
        make.top.mas_equalTo(self.headView).with.offset(15);
        
        make.height.mas_equalTo(20);
    }];
    
    [self.headView addSubview:self.moneyTextField];
    
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentMoney.mas_right).with.offset(10);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(25);
    }];

    [self.view addSubview:self.footView];
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(self.footView.mas_top).with.offset(0);
    }];
   
}

//清空列表
-(void)deleteClick{
   LHCManager *manager = [LHCManager sharedManager];
    [manager.LHCDataArray removeAllObjects];
    [self.tableView reloadData];
}

-(void)addBettingClick{
    for(int i = 0;i < self.navigationController.viewControllers.count;i++){
        UIViewController *viewController = self.navigationController.viewControllers[i];
        if( [viewController isKindOfClass:[LotteryDetailLHCViewController class]]){
            LotteryDetailLHCViewController *vc = (LotteryDetailLHCViewController *)viewController;
            vc.isAddOtherWager = YES;
        }else if ([viewController isKindOfClass:[LotteryDetailBJ28ViewController class]]){
            LotteryDetailBJ28ViewController *vc = (LotteryDetailBJ28ViewController *)viewController;
            vc.isAddOtherWager = YES;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    LHCManager *manager = [LHCManager sharedManager];
    return manager.LHCDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // LHCManager *manager = [LHCManager sharedManager];
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    LHCManager *manager = [LHCManager sharedManager];
    LHCBettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LHCBettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = MCMineTableCellBgColor;
    cell.cellRow = indexPath.section;
    LHCLotteryModel *model = manager.LHCDataArray[indexPath.section];
//    cell.model =
    if (self.wf_pl.count != 0 &&([model.wf_flag isEqualToString:@"xglhc_lm_3z2"] ||[model.wf_flag isEqualToString:@"xglhc_lm_2zt"])) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *d in self.wf_pl) {
            [array addObject:[d objectForKey:@"award_money"]];
        }
        NSString *award_money = [array componentsJoinedByString:@","];
        model.award_money = award_money;
    }
    cell.model = model;
    
    cell.deleteBlock = ^(NSInteger row) {
        
        [manager.LHCDataArray removeObjectAtIndex:row];
        [self.tableView reloadData];
        
        [self.footView.timesLabel setTitle:[NSString stringWithFormat:@"%ld注",manager.LHCDataArray.count] forState:UIControlStateNormal];
       // self.footView.timesLabel.text = [NSString stringWithFormat:@"%ld注",manager.LHCDataArray.count];
        NSLog(@"删除按钮的row %ld",(long)row);
    };
    
    cell.editBlock = ^(NSInteger row, NSString * money) {
        LHCLotteryModel *model = manager.LHCDataArray[indexPath.section];
        model.money = money;
 //       NSLog(@"金额输入框的row %ld 金额%f",(long)row,money);
        
    };
    
    return cell;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    LHCManager *manager = [LHCManager sharedManager];
    for (LHCLotteryModel *model in manager.LHCDataArray) {
        model.money = textField.text;
    }
    
    [self.tableView reloadData];
}
//投注按钮的点击
-(void)bettingClick{
    LHCManager *manager = [LHCManager sharedManager];
    
  
    if (manager.LHCDataArray.count == 0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请选择一组号码"];
        return;
    }
  
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"bet/bet-order-lhc28"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSMutableString *count_money = [[NSMutableString alloc]init];
    NSMutableString *pl_flag = [[NSMutableString alloc]init];
    NSMutableString *bet_number = [[NSMutableString alloc]init];
    NSMutableString *wf_flag = [[NSMutableString alloc]init];
    for (LHCLotteryModel *model in manager.LHCDataArray) {
        [bet_number appendFormat:@"%@#",model.pl_name];
        [pl_flag appendFormat:@"%@#",model.pl_flag];
        [count_money appendFormat:@"%@#",model.money];
        [wf_flag appendFormat:@"%@#",model.wf_flag];
        if ([model.money integerValue] <1) {
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"投注的金额不能为空"];
            return;
        }
    }
   
    
    [wf_flag deleteCharactersInRange:NSMakeRange([wf_flag length]-1, 1)];
    [count_money deleteCharactersInRange:NSMakeRange([count_money length]-1, 1)];
    [bet_number deleteCharactersInRange:NSMakeRange([bet_number length]-1, 1)];
    [pl_flag deleteCharactersInRange:NSMakeRange([pl_flag length]-1, 1)];
  
    NSDictionary * parameter = @{
                                 @"lottery_id" : self.lottery_id,
                                 @"user_token" : token,
                                 @"platform"   : @"2",
                                 @"lottery_qh" : self.lottery_qh,
                                 @"wf_flag"    : wf_flag,
                                 @"bet_number" : bet_number,//用#分隔，红波#蓝波
                                 @"count_money": count_money,//用#分隔，要和号码对应 5#10
                                 @"pl_flag"    : pl_flag //投注号码对应的赔率用#分隔，要和号码对应
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self success:^(id data) {
        if (IS_SUCCESS) {
            [manager.LHCDataArray removeAllObjects];
            [self.tableView reloadData];
            
            KKBettingResultView *resultView = [KKBettingResultView new];
            [resultView setTitle:@"投注成功" tip:@"好运即将到来!" confirmStr:@"继续投注" failureStr:@"投注记录"];
            resultView.backgroundColor = [UIColor clearColor];
            [self.view.window addSubview:resultView];
            [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.view.window);
            }];
            resultView.confirmBlock= ^{
               
            };
            resultView.otherBlock= ^{
                KKBetRecordViewController *betRecordVC = [KKBetRecordViewController new];
                [self.navigationController pushViewController:betRecordVC animated:YES];
            };
            resultView.didClickBgViewBlock = ^{
                
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
    } failure:nil];
    
}
-(void)keyboardConfirmClicked{
    [self.view endEditing:YES];
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.sectionHeaderHeight = 8;
        _tableView.sectionFooterHeight = 0.01;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = MCMineTableViewBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *footerVew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 60)];
        footerVew.userInteractionEnabled = YES;
        footerVew.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.addbutton.frame = CGRectMake(10, 10, MCScreenWidth-20, 50);
        [footerVew addSubview:self.addbutton];
        _tableView.tableFooterView = footerVew;
        _tableView.tableFooterView.backgroundColor = MCMineTableViewBgColor;
    } return _tableView;
}
-(UILabel *)commentMoney{
    if (!_commentMoney) {
        _commentMoney = [[UILabel alloc]init];
        _commentMoney.text = @"请输入统一金额:";
        _commentMoney.font = MCFont(17);
        _commentMoney.textColor = [UIColor blackColor];
    }
    return _commentMoney;
}
-(UITextField *)moneyTextField{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc]init];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, 120, 25)];
        imgView.image =  [MCTool BSImage_createImageWithColor:MCUIColorLighttingBrown];
        [_moneyTextField addSubview: imgView];
        [_moneyTextField sendSubviewToBack: imgView];
        _moneyTextField.delegate = self;
        _moneyTextField.placeholder = @"请输入金额";
        _moneyTextField.textAlignment = NSTextAlignmentCenter;
        _moneyTextField.returnKeyType = UIReturnKeyDone;
        _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        _moneyTextField.font = MCFont(15);
        [_moneyTextField setValue:MCMineTableCellBgColor forKeyPath:@"_placeholderLabel.textColor"];
        [_moneyTextField setTextColor: MCUIColorMain];
        _moneyTextField.layer.cornerRadius = 4;
        _moneyTextField.layer.masksToBounds = YES;
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, MCScreenWidth,44)];

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MCScreenWidth - 60, 7,50, 30)];
       
        [button setTitle:@"确认"forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyboardConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [bar addSubview:button];
        
        [bar layoutIfNeeded];
        [bar sendSubviewToBack:bar.subviews.lastObject];
        _moneyTextField.inputAccessoryView = bar;
        _moneyTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _moneyTextField;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 50)];
        _headView.userInteractionEnabled = YES;
        _headView.backgroundColor = MCMineTableCellBgColor;
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
        
        LHCManager *manager = [LHCManager sharedManager];
         [self.footView.timesLabel setTitle:[NSString stringWithFormat:@"%ld注",manager.LHCDataArray.count] forState:UIControlStateNormal];
        _footView.delegate = self;
        _footView.backgroundColor = MCUIColorWhite;
    }
    return _footView;
}
-(UIButton *)addbutton{
    if (!_addbutton) {
        self.addbutton = [[UIButton alloc]init];
        [self.addbutton setImage:[UIImage imageNamed:@"Reuse_add"] forState:UIControlStateNormal];
        [self.addbutton setTitle:@"  添加一注" forState:UIControlStateNormal];
        [self.addbutton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        self.addbutton.layer.cornerRadius = 22;
        self.addbutton.clipsToBounds = YES;
        self.addbutton.backgroundColor = MCMineTableCellBgColor;
        [self.addbutton addTarget:self action:@selector(addBettingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addbutton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
