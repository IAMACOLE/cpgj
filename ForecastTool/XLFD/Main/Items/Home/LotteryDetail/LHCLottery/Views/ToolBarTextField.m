//
//  ToolBarTextField.m
//  Rebate
//
//  Created by qj-07-pc001 on 2017/3/28.
//  Copyright © 2017年 liuye. All rights reserved.
//

#import "ToolBarTextField.h"

@implementation ToolBarTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(id)init{
    if (self == [super init]) {
        UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 40)];
        [topKeyboardView setBarStyle:UIBarStyleBlack];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        doneBtn.frame = CGRectMake(MCScreenWidth-50, 5, 40, 30);
        [doneBtn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 30)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        
        [topKeyboardView addSubview:doneBtn];
        [topKeyboardView addSubview:cancelBtn];
        
//        [self setInputAccessoryView:topKeyboardView];
    }
    
    return self;
}

-(void)cancleClick{
    [self endEditing:YES];
}
-(void)dismissKeyBoard{
    [self endEditing:YES];
    if (self.text.length>0) {
       self.FinishedBlock(self.text);
    }else{
        
    }
    
}
@end
