//
//  ToolBarTextField.h
//  Rebate
//
//  Created by qj-07-pc001 on 2017/3/28.
//  Copyright © 2017年 liuye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

//typedef void(^FinishedBlock)(NSString *text);
@interface ToolBarTextField : UITextField
@property (nonatomic,copy)void (^FinishedBlock)(NSString *) ;
@end
