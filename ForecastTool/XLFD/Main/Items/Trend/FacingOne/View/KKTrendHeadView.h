//
//  KKTrendHeadView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/10.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKTrendHeadView : UIView

-(void)reloadDataWithNewNumberString:(NSString *)newNumberString;
-(void)stopRollingAnimation;

@end
