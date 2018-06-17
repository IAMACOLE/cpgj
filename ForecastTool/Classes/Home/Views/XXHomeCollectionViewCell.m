//
//  XXHomeCollectionViewCell.m
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXHomeCollectionViewCell.h"

@implementation XXHomeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.iconView = [UIImageView new];
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(self.iconView.mas_width);
        }];
        
        self.title = [UILabel new];
        self.title.textColor = [UIColor blackColor];
        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.iconView.mas_bottom).mas_offset(10);
        }];
        
    }
    
    return self;
    
}

@end
