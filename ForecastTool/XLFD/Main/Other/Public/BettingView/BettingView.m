//
//  BettingView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "BettingView.h"

@interface BettingView()<LotteryTimeViewDelegate>

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic , strong) UIButton *cancelButton;
@property (nonatomic , strong) UILabel *playLabel;
@property (nonatomic, strong) UILabel *bettingNumber;
@property (nonatomic , strong) UILabel *playTypeLabel;
@property (nonatomic , strong) UILabel *moneyLabel;
@property (nonatomic , strong) UILabel *balanceLabel;
@property (nonatomic , strong) UILabel *tipsLabel;

@end


@implementation BettingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)confirmButtonClicked {
    [self removeFromSuperview];
}


- (void)addSubviews {
    
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(305, 373));
    }];
    
    
    [self.whiteView addSubview:self.playLabel];
    [self.playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(25);
    }];
    
    [self.whiteView addSubview: self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    [self.whiteView addSubview:self.bettingNumber];
    [self.bettingNumber setHidden:YES];
    [self.bettingNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.timeView.mas_bottom).with.offset(18);
    }];
    
    [self.whiteView addSubview:self.bettingNumber_rightLabel];
    [self.bettingNumber_rightLabel setHidden:YES];
    [self.bettingNumber_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bettingNumber.mas_right).with.offset(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.timeView.mas_bottom).with.offset(18);
    }];    
    
    [self.whiteView addSubview:self.playTypeLabel];
    
    [self.playTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.bettingNumber).with.offset(7);
    }];
    
    [self.whiteView addSubview:self.playTypeLabel_rightLabel];
    
    [self.playTypeLabel_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playTypeLabel.mas_right).with.offset(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bettingNumber).with.offset(7);
    }];
    
    
    [self.whiteView addSubview:self.moneyLabel];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.playTypeLabel.mas_bottom).with.offset(7);
    }];
    
    [self.whiteView addSubview:self.money_rightLabel];
    
    [self.money_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyLabel.mas_right).with.offset(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.playTypeLabel.mas_bottom).with.offset(7);
    }];
    
    
    [self.whiteView addSubview:self.balanceLabel];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).with.offset(7);
    }];
    
    [self.whiteView addSubview:self.balance_rightLabel];
    
    [self.balance_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.balanceLabel.mas_right).with.offset(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).with.offset(7);
    }];
    
    
    [self.whiteView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.balanceLabel.mas_bottom).with.offset(25);
        make.centerX.mas_equalTo(-(94 / 2) - 12);
        make.size.mas_equalTo(CGSizeMake(94, 40));
    }];
    
    
    [self.whiteView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.balanceLabel.mas_bottom).with.offset(25);
        make.centerX.mas_equalTo((94 / 2) + 12);
        make.size.mas_equalTo(CGSizeMake(94, 40));
    }];
    
    
    [self.whiteView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmButton.mas_bottom).with.offset(56 + 20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];


}
-(void)setData:(NSString *)playType andMoney:(NSString *)money andBalance:(NSString *)balance {
    self.playTypeLabel_rightLabel.text = playType;
    self.balance_rightLabel.text =  balance;
    [NSString stringWithFormat:@"%@元",money];
    self.money_rightLabel.text = money;
}


- (void)bettingFinish:(BettingViewBlock) callback{
    self.confirmBlock = callback;
}

#pragma mark - setter & getter
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        self.whiteView = [[UIView alloc] init];
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.image = [UIImage imageNamed:@"follow-alert-bg"];
        [self.whiteView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
    } return _whiteView;
}


-(BettingTimeView *)timeView{
    if (!_timeView) {
        self.timeView = [[BettingTimeView alloc] initWithFrame:CGRectMake(0, 0, MCScreenWidth, 17)];
        self.timeView.textColor = [UIColor blackColor];
        self.timeView.delegate = self;
        self.timeView.distanceLabel.textAlignment = NSTextAlignmentCenter;
        self.timeView.backgroundColor = [UIColor clearColor];

    }
    return _timeView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:MCUIColorFromRGB(0x848484) forState:UIControlStateNormal];
        [self.cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"follow-alert-cancle"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = MCFont(16);
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    } return _cancelButton;
}


- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"follow-alert-confirm"] forState:UIControlStateNormal];
        [self.confirmButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
        [self.confirmButton setTitleColor:MCUIColorFromRGB(0x9A6424) forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = MCFont(16);
        [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}

- (UILabel *)type_bottomLabel {
    if (_type_bottomLabel == nil) {
        self.type_bottomLabel = [[UILabel alloc] init];
        self.type_bottomLabel.font = MCFont(15);
        self.type_bottomLabel.textColor = [UIColor whiteColor];
        
    } return _type_bottomLabel;
}

- (UILabel *)changeMoney_bottomLabel {
    if (_changeMoney_bottomLabel == nil) {
        self.changeMoney_bottomLabel = [[UILabel alloc] init];
        self.changeMoney_bottomLabel.font = MCFont(15);
        self.changeMoney_bottomLabel.numberOfLines = 0;
        self.changeMoney_bottomLabel.textColor = [UIColor whiteColor];;
        
    } return _changeMoney_bottomLabel;
}

- (UILabel *)totalMoney_bottomLabel {
    if (_totalMoney_bottomLabel == nil) {
        self.totalMoney_bottomLabel = [[UILabel alloc] init];
        self.totalMoney_bottomLabel.numberOfLines = 0;
        self.totalMoney_bottomLabel.font = MCFont(15);
        self.totalMoney_bottomLabel.textColor = [UIColor whiteColor];
        
    } return _totalMoney_bottomLabel;
}

- (UILabel *)bettingNumber {
    if (_bettingNumber == nil) {
        self.bettingNumber = [[UILabel alloc] init];
        self.bettingNumber.font = MCFont(16);
        self.bettingNumber.textColor = [UIColor blackColor];
        self.bettingNumber.text = @"投注号码：";
    }
    return _bettingNumber;
}

- (UILabel *)bettingNumber_rightLabel {
    if (_bettingNumber_rightLabel == nil) {
        self.bettingNumber_rightLabel = [[UILabel alloc] init];
        self.bettingNumber_rightLabel.font = MCFont(16);
        self.bettingNumber_rightLabel.textColor = MCUIColorMain;
        self.bettingNumber_rightLabel.text = @"3 5 9 8 9";
    } return _bettingNumber_rightLabel;
}

-(UILabel *)playLabel{
    if (!_playLabel) {
        _playLabel = [[UILabel alloc]init];
        _playLabel.font = MCFont(18);
        _playLabel.textColor = [UIColor whiteColor];
        _playLabel.text = @"投注确认";
        _playLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _playLabel;
}

-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.textColor = MCUIColorFromRGB(0xA1A1A1);
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.text = @"温馨提示:您可以在设置中关闭或开启投注确认选项当您确认即表示您已阅读并同意《委托投注规则》";
        _tipsLabel.font = MCFont(12);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipsLabel;
}

-(UILabel *)playTypeLabel{
    if (!_playTypeLabel) {
        _playTypeLabel = [[UILabel alloc]init];
        _playTypeLabel.font = MCFont(16);
        _playTypeLabel.textColor = [UIColor blackColor];
        _playTypeLabel.text = @"玩法：";
        _playTypeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _playTypeLabel;
}

-(UILabel *)playTypeLabel_rightLabel{
    if (!_playTypeLabel_rightLabel) {
        _playTypeLabel_rightLabel = [[UILabel alloc]init];
        _playTypeLabel_rightLabel.font = MCFont(16);
         _playTypeLabel_rightLabel.textColor = MCUIColorMain;
        _playTypeLabel_rightLabel.text = @"五星定位胆";
    }
    return _playTypeLabel_rightLabel;
}


-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = MCFont(16);
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.text = @"投注金额：";
    }
    return _moneyLabel;
}

-(UILabel *)money_rightLabel{
    if (!_money_rightLabel) {
        _money_rightLabel = [[UILabel alloc]init];
        _money_rightLabel.font = MCFont(16);
        _money_rightLabel.textColor = MCUIColorMain;
        _money_rightLabel.text = @"60元（一注12元）";
    }
    return _money_rightLabel;
}


-(UILabel *)balanceLabel{
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc]init];
        _balanceLabel.font = MCFont(16);
        _balanceLabel.textColor = [UIColor blackColor];
        _balanceLabel.text = @"当前余额:";
    }
    return _balanceLabel;
}

-(UILabel *)balance_rightLabel{
    if (!_balance_rightLabel) {
        _balance_rightLabel = [[UILabel alloc]init];
        _balance_rightLabel.font = MCFont(16);
        _balance_rightLabel.textColor = MCUIColorMain;
        _balance_rightLabel.text = @"6999元";
    }
    return _balance_rightLabel;
}

-(void)confirmButtonClick {
    [self removeSuperView];
    self.confirmBlock();
}

-(void)cancelButtonClick {
    [self removeSuperView];
    self.cancelBlock();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.bgView){
        [self removeSuperView];
    }
}

-(void)removeSuperView{
    [UIView animateWithDuration:1.0 animations:^{
        [self removeFromSuperview];
    }];
    
}
-(void)sureClick{
    [self removeFromSuperview];
}

@end
