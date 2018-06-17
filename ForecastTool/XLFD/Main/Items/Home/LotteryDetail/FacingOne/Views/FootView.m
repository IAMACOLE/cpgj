//
//  FootView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "FootView.h"

@interface FootView()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *modelLabel;
@property(nonatomic, strong)UILabel *timesLabel;
@property(nonatomic,strong)UIButton *historyButton;
@property(nonatomic,strong)UIView *bottonView;
@property(nonatomic, strong)UIButton *deleteButton;

@property(nonatomic,strong)UIButton *ChaseButton;
@property(nonatomic,strong)UIButton *bettingButton;
@end
@implementation FootView


- (void)drawRect:(CGRect)rect {
    
    UIImageView *boomBGView = [[UIImageView alloc] init];
    boomBGView.image = [UIImage imageNamed:@"icon-lotterydetail-boombar"];
    [self addSubview:boomBGView];
    [boomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
        if (IS_IPHONE_X) {
             make.height.mas_equalTo(43 + 30);
        }else{
             make.height.mas_equalTo(43);
        }
       
    }];
    
    UILabel *bettingLabel = [[UILabel alloc] init];
    bettingLabel.text = @"投注:";
    bettingLabel.font = MCFont(kAdapterWith(13));
    bettingLabel.textColor = [UIColor blackColor];
    [self addSubview:bettingLabel];
    
    [bettingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(38);
    }];
    
    [self addSubview:self.timesTextField];
    [self.timesTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bettingLabel.mas_right).with.offset(8);
        make.centerY.mas_equalTo(bettingLabel);
        //make.size.mas_equalTo(CGSizeMake(33, 19));
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(33), 19));
    }];
    
    [self addSubview:self.timesLabel];
    [self.timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timesTextField.mas_right).with.offset(8);
        make.centerY.mas_equalTo(_timesTextField);
        make.size.mas_equalTo(CGSizeMake(20, 16));
    }];
    
    UIImageView *timesUpView = [[UIImageView alloc] init];
    timesUpView.hidden = YES;
    timesUpView.image = [UIImage imageNamed:@"icon-lotterydetail-model-up"];
    [self addSubview: timesUpView];
    
    [timesUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(self.timesLabel.mas_right).with.offset(3);
    }];
    
    UIImageView *timesDownView = [[UIImageView alloc] init];
    timesDownView.hidden = YES;
    timesDownView.image = [UIImage imageNamed:@"icon-lotterydetail-model-down"];
    [self addSubview: timesDownView];
    
    [timesDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timesUpView.mas_bottom).with.offset(2);
        make.left.mas_equalTo(self.timesLabel.mas_right).with.offset(3);
    }];
    
    [self addSubview:self.modelLabel];
    [self.modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).with.offset(-20);
        make.centerY.mas_equalTo(self.timesLabel);
        
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(35), 16));
    }];
    
    [self addSubview:self.modelTextField];
    [self.modelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.modelLabel.mas_right).with.offset(5);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(40), 19));
    }];
    
    [self addSubview:self.bonusLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookBonusClick)];
    [self.bonusLabel addGestureRecognizer:tap];
   
    [self.bonusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.modelTextField);
    }];
    
    [self addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(bettingLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(40), 25));
    }];
    
 
    [self addSubview:self.bettingMoneyLabel];
    [self.bettingMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.deleteButton.mas_right).with.offset(5);
        make.top.mas_equalTo(self.bonusLabel.mas_bottom).with.offset(18);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(150), 13));
    }];
    
    [self addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.deleteButton.mas_right).with.offset(5);
        make.top.mas_equalTo(self.bettingMoneyLabel.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(150), 13));
    }];
    
    [self addSubview:self.bettingButton];
    [self.bettingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.deleteButton);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(54), 25));
    }];
    [self addSubview:self.ChaseButton];
    [self.ChaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bettingButton.mas_left).with.offset(-10);
        make.centerY.mas_equalTo(self.bettingButton);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(40), 25));
    }];
    
    [self addSubview:self.makeMoneyButton];
    [self.makeMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.ChaseButton.mas_left).with.offset(-7);
        make.centerY.mas_equalTo(self.ChaseButton);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(70), 25));
    }];
    
//    UIButton *makeMoneyChooseButton = [[UIButton alloc]init];
//    [makeMoneyChooseButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-select"] forState:UIControlStateNormal];
//    [self addSubview:makeMoneyChooseButton];
//
//    [makeMoneyChooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.makeMoneyButton.mas_left).with.offset(-4);
//        make.centerY.mas_equalTo(self.makeMoneyButton);
//        // make.size.mas_equalTo(CGSizeMake(50, 25));
//    }];
  
    
}
//投注
-(void)bettingClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(bettingClick)]) {
        [self.delegate bettingClick];
    }
}
-(void)lookBonusClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(lookBonusClick)]) {
        [self.delegate lookBonusClick];
    }
}
//赚佣金
- (void)earnCommissionsClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        if (self.delegate && [self.delegate respondsToSelector:@selector(earnCommissionsClick)]) {
            [self.delegate earnCommissionsClick];
        }
    }
}
//追号
-(void)chaseClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(chaseClick)]) {
        [self.delegate chaseClick];
    }
}
//删除
-(void)deleteClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(deleteClick)]) {
        [self.delegate deleteClick];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.modelTextField) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(moneyModelStareEditing)]) {
            [self.delegate moneyModelStareEditing];
        }
    }else{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(stareEditing:)]) {
        [self.delegate stareEditing:self.timesTextField.text];
    }
    }
    return NO;
}
-(UITextField *)timesTextField{
    if (!_timesTextField) {
        self.timesTextField = [[UITextField alloc]init];

        self.timesTextField.layer.cornerRadius = 4;
        self.timesTextField.layer.masksToBounds = YES;
        self.timesTextField.textColor = [UIColor whiteColor];
        self.timesTextField.backgroundColor = MCUIColorMain;
        self.timesTextField.textAlignment = NSTextAlignmentCenter;
        self.timesTextField.delegate = self;
        self.timesTextField.text = @"1";
        self.timesTextField.font = MCFont(kAdapterWith(13));
    }
    return _timesTextField;
}
-(UILabel *)timesLabel{
    if (!_timesLabel) {
        self.timesLabel = [[UILabel alloc]init];
        self.timesLabel.textColor = [UIColor blackColor];
        self.timesLabel.text = @"倍";
        self.timesLabel.font = MCFont(kAdapterWith(13));
    }
    return _timesLabel;
}
-(UILabel *)modelLabel{
    if (!_modelLabel) {
        self.modelLabel = [[UILabel alloc]init];
        self.modelLabel.textColor = [UIColor blackColor];
        self.modelLabel.font = MCFont(kAdapterWith(13));
        self.modelLabel.text = @"模式:";
    }
    return _modelLabel;
}
-(UITextField *)modelTextField{
    if (!_modelTextField) {
        self.modelTextField = [[UITextField alloc]init];
        self.modelTextField.layer.cornerRadius = 4;
        self.modelTextField.layer.masksToBounds = YES;
        self.modelTextField.textColor = [UIColor whiteColor];
        self.modelTextField.backgroundColor = MCUIColorMain;
        self.modelTextField.text = @"元";
        self.modelTextField.delegate = self;
        self.modelTextField.textAlignment = NSTextAlignmentCenter;
        self.modelTextField.font = MCFont(kAdapterWith(13));
        
    }
    return _modelTextField;
}
-(UILabel *)bonusLabel{
    if (!_bonusLabel) {
        self.bonusLabel = [[UILabel alloc]init];
        self.bonusLabel.userInteractionEnabled = YES;
        self.bonusLabel.font = MCFont(kAdapterWith(13));
        self.bonusLabel.textAlignment = NSTextAlignmentRight;
        self.bonusLabel.textColor = [UIColor blackColor];
    }
    return _bonusLabel;
}
-(UIButton *)deleteButton{
    if (!_deleteButton) {
        self.deleteButton = [[UIButton alloc]init];
        self.deleteButton.layer.cornerRadius = 4;
        self.deleteButton.clipsToBounds = YES;
        self.deleteButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon-footer-btnBg"]];
        self.deleteButton.titleLabel.textColor = MCUIColorBetLightGray;
        [self.deleteButton setTitle:@"清空" forState:UIControlStateNormal];
        self.deleteButton.titleLabel.font = MCFont(kAdapterWith(13));
        [self.deleteButton setTitleColor:MCUIColorBetLightGray forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
-(UILabel *)bettingMoneyLabel{
    if (!_bettingMoneyLabel) {
        self.bettingMoneyLabel = [[UILabel alloc]init];
        self.bettingMoneyLabel.font = MCFont(kAdapterWith(13));
        self.bettingMoneyLabel.textColor = MCUIColorFromRGB(0xFFC400);
        self.bettingMoneyLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _bettingMoneyLabel;
}
-(UIButton *)ChaseButton{
    if (!_ChaseButton) {
        self.ChaseButton = [[UIButton alloc]init];
        self.ChaseButton.layer.cornerRadius = 4;
        self.ChaseButton.clipsToBounds = YES;
        [self.ChaseButton setTitle:@"追号" forState:UIControlStateNormal];
         self.ChaseButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon-footer-btnBg"]];
        self.ChaseButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterWith(13)];
        [self.ChaseButton setTitleColor:MCUIColorBetLightGray forState:UIControlStateNormal];
        [self.ChaseButton addTarget:self action:@selector(chaseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ChaseButton;
}

-(UIButton *) makeMoneyButton {
    if (!_makeMoneyButton) {
        self.makeMoneyButton = [[UIButton alloc]init];
        self.makeMoneyButton.layer.cornerRadius = 4;
        self.makeMoneyButton.clipsToBounds = YES;
        [self.makeMoneyButton setTitle:@"赚佣金" forState:UIControlStateNormal];
        self.makeMoneyButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon-footer-btnBg"]];
        self.makeMoneyButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterWith(13)];
        [self.makeMoneyButton setTitleColor:MCUIColorBetLightGray forState:UIControlStateNormal];
        [self.makeMoneyButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-select"] forState:UIControlStateSelected];
        [self.makeMoneyButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-nor"]forState:UIControlStateNormal];
        [self.makeMoneyButton addTarget:self action:@selector(earnCommissionsClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeMoneyButton;
}

-(UIButton *)bettingButton{
    if (!_bettingButton) {
        self.bettingButton = [[UIButton alloc]init];

        self.bettingButton.layer.cornerRadius = 4;
        self.bettingButton.clipsToBounds = YES;
        self.bettingButton.backgroundColor = MCUIColorWithRGB(255, 191, 0, 1);
        [self.bettingButton setTitle:@"投注" forState:UIControlStateNormal];
        self.bettingButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterWith(13)];
        [self.bettingButton setTitleColor:MCUIColorWithRGB(39, 19, 9, 1) forState:UIControlStateNormal];
        [self.bettingButton addTarget:self action:@selector(bettingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bettingButton;
}
-(UILabel *)balanceLabel{
    if (!_balanceLabel) {
        self.balanceLabel = [[UILabel alloc]init];
        self.balanceLabel.textAlignment = NSTextAlignmentLeft;
        self.balanceLabel.font = MCFont(kAdapterWith(13));
       // self.balanceLabel.textAlignment = NSTextAlignmentCenter;
        self.balanceLabel.textColor = MCUIColorFromRGB(0xFFC400);
        self.balanceLabel.text = @"余额:0元";
        
    }
    return _balanceLabel;
}

@end
