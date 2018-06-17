//
//  DoubleChaseFooterView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol DoubleChaseFooterViewDelegate <NSObject>
@optional
-(void)immediateClick;
-(void)cancelClick;

@end
@interface DoubleChaseFooterView : UIView
@property(nonatomic,strong)UIButton * stopChaseButton;
@property(nonatomic,weak)id<DoubleChaseFooterViewDelegate>delegate;
@end
