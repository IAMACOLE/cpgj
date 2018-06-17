//
//  DoubleChaseView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "DoubleChaseView.h"

@interface DoubleChaseView()<UITextFieldDelegate,LotteryTimeViewDelegate>

@property(nonatomic,strong)UILabel *chasePreiodLabel;

@property(nonatomic,strong)UILabel *AllPreiodLabel;
@property(nonatomic,strong)UILabel *chasePlanLabel;
@property(nonatomic,strong)UIButton * generateButton;

@property(nonatomic,strong)UILabel *modelLabel;
@property(nonatomic,strong)UIView *planView;
@end
@implementation DoubleChaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [self addSubview:self.timeView];
    [self addSubview:self.chasePreiodLabel];
    [self.chasePreiodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self.timeView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(68, 16));
    }];
    [self addSubview:self.preiodTextField];
    [self.preiodTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chasePreiodLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(self.timeView.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self.chasePreiodLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth-20, 1));
    }];
    
    [self addSubview:self.AllPreiodLabel];
    [self.AllPreiodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(lineView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth-20, 14));
    }];
    
    self.planView = [[UIView alloc]init];
    self.planView.userInteractionEnabled = YES;
    self.planView.backgroundColor= [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.planView];
    [self.planView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(0);
        make.top.mas_equalTo(self.AllPreiodLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth, 50));
    }];
    
    
    [self.planView addSubview:self.chasePlanLabel];
    [self.chasePlanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.planView).with.offset(10);
        make.centerY.mas_equalTo(self.planView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.planView addSubview:self.generateButton];
    [self.generateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.planView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.planView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 35));
    }];
    
    
    UILabel *bettingLabel = [[UILabel alloc]init];
    bettingLabel.text = @"起始倍数:";
    bettingLabel.font = MCFont(14);
    bettingLabel.textColor = MCUIColorMiddleGray;
    [self addSubview:bettingLabel];
    [bettingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self.planView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(65, 16));
    }];
    
    
    [self addSubview:self.timesTextField];
    [self.timesTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bettingLabel.mas_right).with.offset(8);
        make.top.mas_equalTo(self.planView.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(42, 20));
    }];
    
    if (self.isDoubleChaseView) {
        [self addSubview:self.modelLabel];
        [self.modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).with.offset(-20);
            make.top.mas_equalTo(self.planView.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 16));
        }];
        
        [self addSubview:self.modelTextField];
        [self.modelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.modelLabel.mas_right).with.offset(5);
            make.top.mas_equalTo(self.planView.mas_bottom).with.offset(8);
            make.size.mas_equalTo(CGSizeMake(42, 20));
        }];
        
        UILabel *proideLabel = [[UILabel alloc]init];
        [self addSubview:proideLabel];
        proideLabel.text = @"期";
        proideLabel.font = MCFont(14);
        proideLabel.textColor = MCUIColorMiddleGray;
        [proideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.modelTextField.mas_right).with.offset(5);
            make.top.mas_equalTo(self.planView.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 16));
        }];
        
        
        [self addSubview:self.bonusLabel];
        
        [self.bonusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.planView.mas_bottom).with.offset(8);
            make.size.mas_equalTo(CGSizeMake(42, 20));
        }];
        
        UILabel *bettingLabel1 = [[UILabel alloc]init];
        [self addSubview:bettingLabel1];
        bettingLabel1.text = @"翻倍倍数:";
        bettingLabel1.font = MCFont(14);
        bettingLabel1.textColor = MCUIColorMiddleGray;
        [bettingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bonusLabel.mas_left).with.offset(-5);
            make.top.mas_equalTo(self.planView.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(65, 16));
        }];

    }


}
//从新刷新数据
-(void)endTimeReloadData{
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeReloadData)]) {
        [self.delegate endTimeReloadData];
    }
}
//本期已封顶
-(void)endTimeResponder{
    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeResponder)]) {
        [self.delegate endTimeResponder];
    }
}
-(void)setDoubleChaseView{
    
}
-(void)setAllperiod:(NSString *)period andMoneyStr:(NSString *)money{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总期数：%@ 期  追号总金额：%@ 元",period,money]];
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(4,period.length)];
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(14+period.length,money.length)];
    self.AllPreiodLabel.attributedText = str;
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(stareEditing:andStatus:andSelectTextField:)]) {
        if (textField == self.preiodTextField) {
            [self.delegate stareEditing:self.preiodTextField.text andStatus:@"期" andSelectTextField:1];
        }else if (textField == self.timesTextField){
            [self.delegate stareEditing:self.timesTextField.text andStatus:@"倍" andSelectTextField:2];
        }else if(textField == self.modelTextField){
            [self.delegate stareEditing:self.modelTextField.text andStatus:@"期" andSelectTextField:4];
        }else{
            [self.delegate stareEditing:self.bonusLabel.text andStatus:@"倍" andSelectTextField:3];
        }
    }
    return NO;
}
//点击生成追单
-(void)generateChaseClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(generateChaseClick)]) {
        [self.delegate generateChaseClick];
    }
}
-(UITextField *)preiodTextField{
    if (!_preiodTextField) {
        self.preiodTextField = [[UITextField alloc]init];
        self.preiodTextField.textAlignment = NSTextAlignmentCenter;
        self.preiodTextField.textColor = MCUIColorGray;
        self.preiodTextField.font = MCFont(14);
        self.preiodTextField.delegate = self;
        self.preiodTextField.text = @"5";
        self.preiodTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _preiodTextField;
}
-(UILabel *)chasePreiodLabel{
    if (!_chasePreiodLabel) {
        self.chasePreiodLabel = [[UILabel alloc]init];
        self.chasePreiodLabel.font = MCFont(14);
        self.chasePreiodLabel.textColor = MCUIColorMiddleGray;
        self.chasePreiodLabel.text = @"追号期数:";
    }
    return _chasePreiodLabel;
}
-(UILabel *)AllPreiodLabel{
    if (!_AllPreiodLabel) {
        self.AllPreiodLabel = [[UILabel alloc]init];
        self.AllPreiodLabel.font = MCFont(12.5);
        self.AllPreiodLabel.textColor = MCUIColorMiddleGray;
        
    }
    return _AllPreiodLabel;
}

-(UILabel *)chasePlanLabel{
    if (!_chasePlanLabel) {
        self.chasePlanLabel = [[UILabel alloc]init];
        self.chasePlanLabel.font = MCFont(12.5);
        self.chasePlanLabel.textColor = MCUIColorGray;
        self.chasePlanLabel.font = [UIFont boldSystemFontOfSize:17];
        self.chasePlanLabel.text = @"追号计划";
    }
    return _chasePlanLabel;
}
-(UIButton *)generateButton{
    if (!_generateButton) {
        self.generateButton = [[UIButton alloc]init];
        [self.generateButton setTitle:@"生成追单" forState:UIControlStateNormal];
        self.generateButton.layer.cornerRadius = 4;
        self.generateButton.layer.borderColor = MCUIColorMain.CGColor;
        self.generateButton.layer.borderWidth = 1;
        self.generateButton.titleLabel.font = MCFont(12);
        [self.generateButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.generateButton addTarget:self action:@selector(generateChaseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _generateButton;
}
-(LotteryTimeView *)timeView{
    if (!_timeView) {
        self.timeView = [[LotteryTimeView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 30)];
        self.timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.timeView.delegate = self;
    }
    return _timeView;
}
//追号倍数
-(UITextField *)timesTextField{
    if (!_timesTextField) {
        self.timesTextField = [[UITextField alloc]init];
        self.timesTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.timesTextField.textColor = MCUIColorGray;
        self.timesTextField.textAlignment = NSTextAlignmentCenter;
        self.timesTextField.delegate = self;
        self.timesTextField.text = @"1";
        self.timesTextField.delegate = self;
        self.timesTextField.font = MCFont(14);
    }
    return _timesTextField;
}
//隔多少期
-(UITextField *)modelTextField{
    if (!_modelTextField) {
        self.modelTextField = [[UITextField alloc]init];
        self.modelTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.modelTextField.delegate = self;
        self.modelTextField.text = @"1";
        self.modelTextField.textAlignment = NSTextAlignmentCenter;
        self.modelTextField.font = MCFont(14);
        self.modelTextField.textColor = MCUIColorGray;
    
    }
    return _modelTextField;
}
-(UILabel *)modelLabel{
    if (!_modelLabel) {
        self.modelLabel = [[UILabel alloc]init];
        self.modelLabel.textColor = MCUIColorMiddleGray;
        self.modelLabel.font = MCFont(14);
        self.modelLabel.text = @"隔:";
    }
    return _modelLabel;
}
//倍数
-(UITextField *)bonusLabel{
    if (!_bonusLabel) {
        self.bonusLabel = [[UITextField alloc]init];
        self.bonusLabel.font = MCFont(14);
        self.bonusLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.bonusLabel.text = @"1";
        self.bonusLabel.delegate = self;
        self.bonusLabel.textAlignment = NSTextAlignmentCenter;
        self.bonusLabel.font = MCFont(14);
        self.bonusLabel.textColor = MCUIColorGray;

    }
    return _bonusLabel;
}
@end
