//
//  CellButton.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "CellButton.h"

@implementation CellButton
-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        [self addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).with.offset(-9);
            make.centerX.mas_equalTo(self).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(30, 18));
            
        }];
        [self addSubview:self.bottonLabel];
        [self.bottonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).with.offset(8);
            make.centerX.mas_equalTo(self).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(30, 16));
            
        }];
    }
    return self;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = MCFont(16);
    }
    return _topLabel;
}
-(UILabel *)bottonLabel{
    if (!_bottonLabel) {
        _bottonLabel = [[UILabel alloc]init];
        _bottonLabel.textAlignment = NSTextAlignmentCenter;
        _bottonLabel.font = MCFont(14);
    }
    return _bottonLabel;
}
//重新设置按钮上的图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(15, 10, contentRect.size.width-20, contentRect.size.width-20);
}
//重新设置按钮上标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.width-5, contentRect.size.width+5, 15);
}


@end
