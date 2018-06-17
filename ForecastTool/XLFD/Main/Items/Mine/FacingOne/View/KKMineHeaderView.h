//
//  KKMineHeaderView.h
//  Kingkong_ios
//
//  Created by 222 on 2018/2/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKMineHeaderViewClickDelegate

@optional

- (void)buttonClickToPushController;

@end

@interface KKMineHeaderView : UIView

@property (nonatomic, strong) UILabel *balanceContent;
@property (nonatomic, weak) id<KKMineHeaderViewClickDelegate> delegate;
- (void)isLogin:(BOOL)loginStatus;

@end
