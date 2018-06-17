//
//  KKCenterTextField.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/9.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKCenterTextField.h"

@implementation KKCenterTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -20, bounds.size.height);//更好理解些
    return inset;
}


// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset;
    if (self.text.length > 0) {
        // 这里100可能需要自己调整一下使其居中即可
        inset = CGRectMake(bounds.origin.x + 100, bounds.origin.y, bounds.size.width - bounds.size.width / 2, bounds.size.height);//更好理解些
    }
    //    NSLog(@"%@",self.text);
    else {
        
        inset = CGRectMake(bounds.origin.x+bounds.size.width / 2, bounds.origin.y, bounds.size.width - bounds.size.width / 2, bounds.size.height);//更好理解些
    }
    return inset;
}

@end
