//
//  KKFindHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindHeadView.h"

@interface KKFindHeadView ()
@property (assign, nonatomic) UIEdgeInsets contentInsets;

@end

@implementation KKFindHeadView




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentInsets = UIEdgeInsetsMake(10, 35, -15, -35);
    }
    return self;
}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
     
  
     
     
     
     

     
     UIButton *infoButton = [[UIButton alloc] init];
     [infoButton setImage:[UIImage imageNamed:@"icon-find-info"] forState:UIControlStateNormal];
      [infoButton addTarget:self action:@selector(lotteryClick) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:infoButton];
     [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentInsets.left);
         make.centerY.mas_equalTo(0);
        // make.size.mas_equalTo(CGSizeMake(kAdapterWith(73) ,kAdapterheight(46)));
     }];
     
     

     
     UIButton *mvpButton = [[UIButton alloc] init];
     [mvpButton setImage:[UIImage imageNamed:@"icon-find-mvp"] forState:UIControlStateNormal];
     [mvpButton addTarget:self action:@selector(mvpClick) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:mvpButton];
     [mvpButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(0);
         make.centerY.mas_equalTo(0);
       
     }];
     
     
   
 
     
     UIButton *follwButton = [[UIButton alloc] init];
     [follwButton addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
     [follwButton setImage:[UIImage imageNamed:@"icon-find-follw"] forState:UIControlStateNormal];
     [self addSubview:follwButton];
     [follwButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(self.contentInsets.right);
         make.centerY.mas_equalTo(0);
        // make.size.mas_equalTo(CGSizeMake(kAdapterWith(73) ,kAdapterheight(46)));
     }];
     
     
     
     UIImageView *xianView = [[UIImageView alloc] init];
     xianView.image = [UIImage imageNamed:@"icon-find-xian"];
     [self addSubview:xianView];
     [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(0);
         make.right.mas_equalTo(0);
         make.bottom.mas_equalTo(0);
         make.height.mas_equalTo(1);
     }];
     
     
 }

-(void)mvpClick {
    if ([self.delegate respondsToSelector:@selector(didClickMpv:)] && self.delegate) {
        [self.delegate didClickMpv:self];
    }
}

-(void)followClick {
    if ([self.delegate respondsToSelector:@selector(didClickFollow:)] && self.delegate) {
        [self.delegate didClickFollow:self];
    }
}

-(void)lotteryClick{
    if ([self.delegate respondsToSelector:@selector(didClickLottery:)] && self.delegate) {
        [self.delegate didClickLottery:self];
    }
}

-(CGFloat)heightFowView{
    return 75;
}

@end
