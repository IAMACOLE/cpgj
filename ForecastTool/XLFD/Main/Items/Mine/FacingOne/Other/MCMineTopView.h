//
//  MCMineTopView.h
//  Kingkong_ios
//
//  Created by goulela on 17/3/30.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol MCMineTopViewDelegate <NSObject>

- (void)MCMineTopViewMethod_changeIcon;

@end

@interface MCMineTopView : UIView

@property (nonatomic, strong) UIImageView * iconImageView;

@property (nonatomic, weak) id<MCMineTopViewDelegate> customDelegate;

@property (nonatomic, strong) UIImage * iconImage;

- (void)topView_updateConstraintsWithIsLogin:(BOOL)isLogin;

@end
