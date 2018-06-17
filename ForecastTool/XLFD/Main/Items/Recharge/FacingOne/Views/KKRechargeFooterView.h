//
//  RechargeFooterView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/5.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KKRechargeFooterViewDelegate <NSObject>
@optional
-(void)RechargeFooterViewImmediatlyClick;
@end
@interface KKRechargeFooterView : UIView
@property(nonatomic,weak)id<KKRechargeFooterViewDelegate>delegate;
@end
