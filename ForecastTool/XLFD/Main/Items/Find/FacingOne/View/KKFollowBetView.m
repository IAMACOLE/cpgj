//
//  KKFollowBetView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFollowBetView.h"
@interface KKFollowBetView ()
@property (nonatomic, strong) NSMutableArray *multipleaButtonArray;
@property (nonatomic, strong) UIButton *betButton;


@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *subButton;
@end
@implementation KKFollowBetView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSArray *multipleaTileArray  =@[@"10倍",@"20倍",@"50倍",@"100倍"];
    self.multipleaButtonArray = [NSMutableArray arrayWithCapacity:4];
    
    NSInteger index = 0;
    for (NSString *title in multipleaTileArray) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:MCUIColorFromRGB(0x3C3C3C) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [button setBackgroundImage:[UIImage imageNamed:@"icon-follow-bet-normal"] forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"icon-follow-bet-normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"icon-follow-bet-select"] forState:UIControlStateSelected];
      //  [button setImage:[UIImage imageNamed:@"icon-follow-bet-select"] forState:UIControlStateSelected];

        button.titleLabel.font = MCFont(12);
        
        
        CGFloat leftAndRightMargin = 10;
        
        CGFloat miniMargin = ((MCScreenWidth - 20) - (kAdapterWith(83) *4)) / 3;
        
        button.frame = CGRectMake(leftAndRightMargin + (miniMargin * index) + (kAdapterWith(83) * index), 20, kAdapterWith(83), kAdapterheight(31));
        [self addSubview:button];
        
        
        button.tag = index;
        
        [button addTarget:self action:@selector(multipleaClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setHidden:YES];
        [self.multipleaButtonArray addObject:button];
        
        index++;
    }
    
    [self addSubview:self.betButton];
    [self.betButton mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.bottom.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(89, 29));
    }];
    
    [self addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-18);
        make.left.mas_equalTo(10);
       
    }];
    
    [self addSubview:self.subButton];
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-45);
        make.left.mas_equalTo(10);
    }];
    
    [self addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.subButton);
        make.size.mas_equalTo(CGSizeMake(60, 25));
        make.left.mas_equalTo(self.subButton.mas_right).with.offset(7);
    }];
    
    [self addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(-45);
         make.left.mas_equalTo(self.moneyTextField.mas_right).with.offset(7);
    }];
    

}


-(UIButton *)betButton {
    if (_betButton == nil) {
        _betButton = [[UIButton alloc] init];
        //_betButton.backgroundColor = MCUIColorMain;
        _betButton.layer.masksToBounds = YES;
        _betButton.layer.cornerRadius = 4;
        [_betButton setBackgroundImage:[UIImage imageNamed:@"icon-find-bet"] forState:UIControlStateNormal];
       // _betButton.titleLabel.font = MCFont(13);
        [_betButton addTarget:self action:@selector(betClick) forControlEvents:UIControlEventTouchUpInside];
        //[_betButton setTitle:@"立即投注" forState:UIControlStateNormal];
        [_betButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _betButton;
}
-(UILabel *)balanceLabel {
    if (_balanceLabel == nil) {
        _balanceLabel = [[UILabel alloc] init];
 
        _balanceLabel.font = MCFont(12);
        _balanceLabel.textColor = MCUIColorFromRGB(0x303030);
        
        
        
        _balanceLabel.text = @"您的余额:0元";
    }
    
    return _balanceLabel;
}


-(UIButton *)addButton {
    if (_addButton == nil) {
        _addButton = [[UIButton alloc] init];
        [_addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setImage:[UIImage imageNamed:@"icon-follow-add"] forState:UIControlStateNormal];
    }
    
    return _addButton;
}


-(UITextField *)moneyTextField {
    if (_moneyTextField == nil) {
        _moneyTextField = [[UITextField alloc] init];
        _moneyTextField.borderStyle = UITextBorderStyleNone;
        _moneyTextField.layer.masksToBounds = YES;
        _moneyTextField.layer.borderColor = MCUIColorFromRGB(0xE4E4E4).CGColor;
        _moneyTextField.layer.borderWidth = 0.5;
        _moneyTextField.textAlignment = NSTextAlignmentCenter;
        _moneyTextField.font = MCFont(13);
        _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _moneyTextField.backgroundColor = [UIColor whiteColor];
    }
    
    return _moneyTextField;
}

-(UIButton *)subButton {
    if (_subButton == nil) {
        _subButton = [[UIButton alloc] init];
        [_subButton addTarget:self action:@selector(subClick) forControlEvents:UIControlEventTouchUpInside];
        [_subButton setImage:[UIImage imageNamed:@"icon-follow-sub"] forState:UIControlStateNormal];
    }
    
    return _subButton;
}



-(CGFloat) heightForView {
    return kAdapterheight(31) + 100;
}



-(void)multipleaClick:(UIButton *) button {
    
    for (UIButton *button in self.multipleaButtonArray) {
        button.selected = NO;
    }
    
    UIButton *senderButton = [self.multipleaButtonArray objectAtIndex:button.tag];
    senderButton.selected = YES;
}

-(void)addClick {

    if ([self.moneyTextField.text isEqualToString:@""]) {
        self.moneyTextField.text = @"1.00";
        return;
    }
    
    self.moneyTextField.text = [NSString stringWithFormat:@"%.2f",self.moneyTextField.text.floatValue + 1];
}

-(void)subClick {
    
    if (self.moneyTextField.text.floatValue > 0 && self.moneyTextField.text.floatValue < 2)  {
        self.moneyTextField.text = @"1.00";
        return;
    }
    
    
   if ([self.moneyTextField.text isEqualToString:@""]) {
        self.moneyTextField.text = @"1.00";
        return;
    }
    
    
    if (self.moneyTextField.text.floatValue >= 2) {
        self.moneyTextField.text = [NSString stringWithFormat:@"%.2f",self.moneyTextField.text.floatValue - 1];
    }
}

-(void)betClick {
    if ([self.delegate respondsToSelector:@selector(didClickBetButton:money:)] && self.delegate) {
        [self.delegate didClickBetButton:self money:self.moneyTextField.text];
    }
}

@end
