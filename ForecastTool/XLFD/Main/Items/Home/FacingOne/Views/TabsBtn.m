//
//  TabsBtn.m
//  SunHome
//
//  Created by 秋二 on 16/7/13.
//  Copyright © 2016年 秋二. All rights reserved.
//

#import "TabsBtn.h"

@implementation TabsBtn

-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        self.titleLabel.font=[UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

//重新设置按钮上的图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(10, 10, contentRect.size.width-20, contentRect.size.width-20);
}
//重新设置按钮上标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.width-5, contentRect.size.width, 15);
}
@end
