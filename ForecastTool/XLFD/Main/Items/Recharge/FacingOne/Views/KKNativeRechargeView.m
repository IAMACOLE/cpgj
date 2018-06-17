//
//  KKNativeRechargeView.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/9.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKNativeRechargeView.h"
#import "KKRechargeHeadView.h"
#import "KKRechargeFooterView.h"
#import "KKPayTypeView.h"
#import "KKBalanceManager.h"
#import "PayModel.h"
#import "IAPHelper.h"
#import "KKRechargePromptViewController.h"
#import "KKRechargeMoneyView.h"
#import "IAPShare.h"
#import "KKPayTypeTabelViewCell.h"
#import "KKPayChannelModel.h"
#import "IAPShare.h"
@interface KKNativeRechargeView ()<KKRechargeFooterViewDelegate,KKRechargeMoneyViewDelegate,
UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *payTpyeView;
@property (assign, nonatomic)NSInteger moneyTpyeIndex;
@property(nonatomic, assign)BOOL isOnOrOff;
@property(nonatomic, copy)NSString *payUrl;
@property (nonatomic, strong)KKPayChannelModel *currentPaytypeModel;
@property (nonatomic, strong)UIView *sectionView;
@property (nonatomic, strong)UILabel *tipsLabel;
@property(nonatomic,strong)KKRechargeFooterView *foorterView;
@property (nonatomic, strong)KKRechargeMoneyView *moneyView;
@property (nonatomic, strong)KKRechargeHeadView *headView;


@end
@implementation KKNativeRechargeView
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self basicSetting];
    [self loadPayView];
}

-(void)basicSetting {

    self.moneyTpyeIndex = 0;
    self.currentPaytypeModel = [self.payChannelArray objectAtIndex:0];
}

-(void)setPayChannelArray:(NSMutableArray *)payChannelArray{
    _payChannelArray = payChannelArray;
    [self.payTpyeView reloadData];
}

-(void)setBalance:(NSString *)balance{
    _balance = balance;
    [self.headView buildWithData:balance];
}

#pragma mark 加载内购支付View
-(void)loadPayView{
    
    UIScrollView *scrollView = [UIScrollView new];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-20 - 49);
    }];
    scrollView.contentSize = CGSizeMake(MCScreenWidth, 1000);
    
    [scrollView addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MCScreenWidth);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    
 
    
    [scrollView  addSubview:self.moneyView];
    self.moneyView.delegate = self;
    [self.moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MCScreenWidth);
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(0);
        //make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    [scrollView  addSubview:self.sectionView];
    
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MCScreenWidth);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.moneyView.mas_bottom);
        make.height.mas_equalTo(49);
    }];
    
    [scrollView  addSubview:self.payTpyeView];
    
    [self.payTpyeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MCScreenWidth);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(self.payChannelArray.count * 64);
        make.top.mas_equalTo(self.sectionView.mas_bottom);
        //make.top.mas_equalTo(0);
    }];
    [self.payTpyeView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_payTpyeView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionTop];
    
    [scrollView  addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.payTpyeView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(10);
    }];
    
    [scrollView addSubview:self.foorterView];
    
    [self.foorterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MCScreenWidth);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.tipsLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    scrollView.contentSize = CGSizeMake(MCScreenWidth, self.payChannelArray.count * 64 + 450);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKPayTypeTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKPayTypeTabelViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    KKPayChannelModel *model = [self.payChannelArray objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.payChannelArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentPaytypeModel = [self.payChannelArray objectAtIndex:indexPath.row];
}


#pragma mark RechargeFooterViewDelegate
-(void)RechargeFooterViewImmediatlyClick{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,self.currentPaytypeModel.turn_url];
    NSString *token = [MCTool BSGetUserinfo_token];

    NSInteger money = 0;
    
    for(UIView *view in self.moneyView.subviews){
        if(view.tag > 100){
            UIButton *btn = (UIButton *)view;
            if(btn.selected == YES){
                self.moneyTpyeIndex = btn.tag - 100;
            }
        }
    }
    
    if ([self.headView.textFiled.text isEqualToString:@""]) {
    
        switch (self.moneyTpyeIndex) {
            case 0:
                money = 38;
                break;
            case 1:
                money = 88;
                break;
            case 2:
                money = 588;
                break;
            case 3:
                money = 988;
                break;
            case 4:
                money = 1888;
                break;
            case 5:
                money = 9888;
                break;
                
            default:
                break;
        }
        
    }else{
        money = self.headView.textFiled.text.integerValue;
    }
    
    NSDictionary *   parameter =  @{
                                    @"money" : @(money),
                                    @"payType": self.currentPaytypeModel.channel_type,
                                    @"user_token":token,
                                    };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:[MCTool getCurrentVC] isShowHUD:YES isShowTabbar:YES success:^(id data) {
        
        NSDictionary *dataDic = data;
        MCH5ViewController *h5VC = [MCH5ViewController new];
        h5VC.url = dataDic[@"turn_url"];
        [[MCTool getCurrentVC].navigationController pushViewController:h5VC animated:YES];
        
    } dislike:^(id data) {
    } failure:^(NSError *error) {
    }];

}

-(KKRechargeHeadView *)headView{
    if (!_headView) {
        self.headView = [[KKRechargeHeadView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 0)];
        self.headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

-(KKRechargeMoneyView *)moneyView {
    if (!_moneyView) {
        _moneyView = [[KKRechargeMoneyView alloc] init];
        _moneyView.backgroundColor = [UIColor clearColor];
    }
    return _moneyView;
}


-(UIView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[UIView alloc] init];
        _sectionView.backgroundColor = [UIColor clearColor];
        
        UIButton *tipBtn = [UIButton new];
        [_sectionView addSubview:tipBtn];
        [tipBtn setTitle:@"请选择您的充值方式" forState:UIControlStateNormal];
        [tipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tipBtn setBackgroundImage:[UIImage imageNamed:@"payTypeTipBgView"] forState:UIControlStateNormal];
        tipBtn.titleLabel.font = MCFont(15);
        tipBtn.frame = CGRectMake((MCScreenWidth - 200)/2, 15,200, 24);
        
    }
    return _sectionView;
}


-(UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = [UIFont systemFontOfSize:10];
        _tipsLabel.textColor = MCUIColorMain;
        _tipsLabel.text = @"重要提示：为防止洗钱和套现，单笔充值后需消费30%才能提现。";
    }
    return _tipsLabel;
}

-(UITableView *)payTpyeView {
    if (!_payTpyeView) {
        _payTpyeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _payTpyeView.backgroundColor = [UIColor clearColor];
        _payTpyeView.delegate = self;
        _payTpyeView.dataSource = self;
        _payTpyeView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTpyeView.scrollEnabled = NO;
        _payTpyeView.rowHeight = 64;
    }
    return _payTpyeView;
}

-(KKRechargeFooterView *)foorterView{
    if (!_foorterView) {
        self.foorterView = [[KKRechargeFooterView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 0)];
        self.foorterView.delegate = self;
        self.foorterView.backgroundColor = [UIColor clearColor];
    }
    return _foorterView;
}

@end
