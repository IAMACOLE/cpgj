//
//  KKFollowBetView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKFollowBetView;
@protocol KKFollowBetViewDelegate<NSObject>

- (void)didClickBetButton:(KKFollowBetView *)view money:(NSString *)money;
@end


@interface KKFollowBetView : UIView
-(CGFloat) heightForView;
@property (nonatomic, strong) UITextField *moneyTextField;
@property(nonatomic,weak)id<KKFollowBetViewDelegate>delegate;
@property (nonatomic, strong) UILabel *balanceLabel;
@end
