//
//  KKPayTypeView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKPayTypeView.h"
@interface KKPayTypeView()
@property(nonatomic,strong)UIView *bgView;
@end
@implementation KKPayTypeView

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

-(void)addSubViews {
    
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
         make.bottom.mas_equalTo(0);
         make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
         make.height.mas_equalTo(50);
    }];
    
    
    UIImageView *payImageView = [[UIImageView alloc] init];
    payImageView.image = [UIImage imageNamed:@"icon-recharge-iap"];
    [self.bgView addSubview:payImageView];
    [payImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    
    UILabel *payLabel = [[UILabel alloc] init];
    payLabel.text = @"内购支付";
    payLabel.font = MCFont(14);
    payLabel.textColor = MCUIColorFromRGB(0x484848);
    [self.bgView addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(payImageView.mas_right).with.offset(30);
        make.centerY.mas_equalTo(0);
    }];
    
    UIImageView *payTypeSelectView = [[UIImageView alloc] init];
    payTypeSelectView.image = [UIImage imageNamed:@"icon-paytype-select"];
    [self.bgView addSubview:payTypeSelectView];
    [payTypeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-24);
        make.centerY.mas_equalTo(0);
    }];
    
    
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _bgView;
}

@end
