//
//  HeadButton.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/6/27.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "HeadButton.h"

@implementation HeadButton

-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        self.titleLabel.font=[UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

//重新设置按钮上的图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width/2-11, 10, 22, 22);
}
//重新设置按钮上标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 35, contentRect.size.width, 15);
}
@end
