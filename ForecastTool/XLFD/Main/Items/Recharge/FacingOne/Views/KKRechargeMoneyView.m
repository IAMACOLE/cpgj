//
//  RechargeMoneyView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKRechargeMoneyView.h"

@implementation KKRechargeMoneyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews {
   
    CGFloat btnW = 110;
    CGFloat btnH = 64;
    CGFloat margin = 10;
    CGFloat marginH = ((MCScreenWidth - 2*margin) - 3 * btnW)/2;
    
    for(int i= 0 ; i< 6;i++){
        UIButton *btn = [UIButton new];
        NSString *norImgName = [NSString stringWithFormat:@"icon-pay-money-normal%d",i];
        NSString *selImgName = [NSString stringWithFormat:@"icon-pay-money-select%d",i];
        [btn setImage:[UIImage imageNamed:norImgName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selImgName] forState:UIControlStateSelected];
        btn.tag = i + 100;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            btn.selected = YES;
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin + (btnW + marginH) * (i%3));
            make.top.mas_equalTo(margin + i/3 * (btnH + margin));
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
            if(i/3){
                make.bottom.mas_equalTo(10);
            }
        }];
    }

}

-(void)btnClick:(UIButton *)button {
    for (UIButton *btn in self.subviews) {
        [btn setSelected:NO];
    }
    [button setSelected:YES];
    
//    if (self.delegate &&[self.delegate respondsToSelector:@selector(didSelectMoneyTypeAtIndex:atIndex:)]) {
//        [self.delegate didSelectMoneyTypeAtIndex:self atIndex:button.tag];
//    }
}


@end
