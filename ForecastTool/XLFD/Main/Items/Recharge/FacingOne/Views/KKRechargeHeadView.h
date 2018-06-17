//
//  RechargeHeadView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKCenterTextField.h"
@interface KKRechargeHeadView : UIView
-(void)buildWithData:(NSString *)money;
@property(nonatomic,strong)UITextField *textFiled;
@end
