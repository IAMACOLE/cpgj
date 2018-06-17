//
//  CustomHeaderReusableView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "CustomHeaderReusableView.h"

@implementation CustomHeaderReusableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).with.offset(10);
        make.right.mas_equalTo(self).with.offset(-10);
        make.top.mas_equalTo(self).with.offset(5);
        make.bottom.mas_equalTo(self).with.offset(-4);
    }];
    
 
}
- (UIView *)bgView
{
    if (!_bgView)
    {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
       
    }
    return _bgView;
}
@end
