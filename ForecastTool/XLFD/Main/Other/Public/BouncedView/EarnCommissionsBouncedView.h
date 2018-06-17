//
//  EarnCommissionsBouncedView.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/13.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol EarnCommissionsBouncedViewDelegate <NSObject>

-(void)didClickConfirmBtnWithCommission:(NSInteger)commission rate:(NSInteger)rate content:(NSString *)content isUncoverPublish:(BOOL)isUncover;
-(void)didClickCancelBtn;

@end

@interface EarnCommissionsBouncedView : UIView

@property(nonatomic,weak)id<EarnCommissionsBouncedViewDelegate>delegate;

@end
