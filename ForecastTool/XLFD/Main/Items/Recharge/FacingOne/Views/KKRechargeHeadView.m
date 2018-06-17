//
//  RechargeHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKRechargeHeadView.h"

@interface KKRechargeHeadView()

@property(nonatomic,strong)UILabel *balanceLabel;
@property(nonatomic,strong)UIImageView *balanceImgView;
@property(nonatomic,strong)UILabel * balanceTipsLabel;

@property(nonatomic,strong)UILabel * textFiledTipsLabel;
@end
@implementation KKRechargeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}
-(void)buildWithData:(NSString *)money {
    self.balanceLabel.text = money;

}

-(void)addSubViews {
    
    
    [self addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.balanceImgView];
    [self.balanceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.balanceLabel.mas_bottom).mas_offset(5);
    }];
    
    UIImageView *textFiledImgV = [UIImageView new];
    [self addSubview:textFiledImgV];
    textFiledImgV.image = [UIImage imageNamed:@"moneyTextFeildBgView"];
    [textFiledImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.balanceImgView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    
    [self addSubview:self.textFiled];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(textFiledImgV);
    }];
    
    [self addSubview:self.textFiledTipsLabel];
    [self.textFiledTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.textFiled.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

-(UIImageView *)balanceImgView{
    if(_balanceImgView == nil){
        _balanceImgView = [UIImageView new];
        _balanceImgView.image = [UIImage imageNamed:@"payMoneyImgView"];
    }
    return _balanceImgView;
}

-(UILabel *)balanceTipsLabel {
    if (_balanceTipsLabel == nil) {
        _balanceTipsLabel = [[UILabel alloc] init];
        _balanceTipsLabel.text = @"余额(元)";
        _balanceTipsLabel.textAlignment = NSTextAlignmentCenter;
        _balanceTipsLabel.font = MCFont(14);
        _balanceTipsLabel.textColor = MCUIColorFromRGB(0x343434);
        
    }
    return _balanceTipsLabel;
}

//-(KKCenterTextField *)textFiled {
-(UITextField *)textFiled {
    if (_textFiled == nil) {
        _textFiled = [[KKCenterTextField alloc] init];
        _textFiled.borderStyle = UITextBorderStyleNone;
        _textFiled.textAlignment = NSTextAlignmentCenter;
        _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFiled.font = [UIFont systemFontOfSize:14];
        _textFiled.placeholder = @"  点此自定义充值金额";
        _textFiled.keyboardType =  UIKeyboardTypeNumberPad;
    }
    return _textFiled;
}

-(UILabel *)textFiledTipsLabel {
    if (_textFiledTipsLabel == nil) {
        _textFiledTipsLabel = [[UILabel alloc] init];
        _textFiledTipsLabel.text = @"*充值金额不小于10元";
        _textFiledTipsLabel.textAlignment = NSTextAlignmentLeft;
        _textFiledTipsLabel.font = MCFont(10);
        _textFiledTipsLabel.textColor = MCUIColorMain;
    }
    return _textFiledTipsLabel;
}


-(UILabel *)balanceLabel {
    if (_balanceLabel == nil) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.text = @"0";
        _balanceLabel.textAlignment = NSTextAlignmentCenter;
        _balanceLabel.font = MCFont(32);
        _balanceLabel.textColor = MCUIColorFromRGB(0x343434);
    }
    return _balanceLabel;
}

@end
