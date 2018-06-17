//
//  RechargeMoneyView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKRechargeMoneyView;
@protocol KKRechargeMoneyViewDelegate <NSObject>
-(void)didSelectMoneyTypeAtIndex:(KKRechargeMoneyView *)view atIndex:(NSInteger)index;
@end


@interface KKRechargeMoneyView : UIView
@property(nonatomic,weak)id<KKRechargeMoneyViewDelegate>delegate;
@end
