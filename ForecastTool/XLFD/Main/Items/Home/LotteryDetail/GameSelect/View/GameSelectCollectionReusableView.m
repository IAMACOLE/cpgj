//
//  GameSelectCollectionReusableView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "GameSelectCollectionReusableView.h"

@implementation GameSelectCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviews];
    }
    return self;
}

#pragma mark - 点击事件


- (void)addSubviews
{
    UIImageView *headBGView = [[UIImageView alloc] init];
//    headBGView.image = [UIImage imageNamed:@"icon-lotterydetail-head-bg"];
    headBGView.backgroundColor = MCUIColorLighttingBrown;
    [self addSubview:headBGView];
    [headBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = MCFont(15.0f);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
