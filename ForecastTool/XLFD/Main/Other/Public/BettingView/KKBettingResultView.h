//
//  KKBettingResultView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/15.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BettingResultViewBlock)();

@interface KKBettingResultView : UIView

@property(nonatomic,copy)BettingResultViewBlock confirmBlock;
@property(nonatomic,copy)BettingResultViewBlock otherBlock;
@property(nonatomic,copy)BettingResultViewBlock didClickBgViewBlock;
-(void)setTitle:(NSString *)title tip:(NSString *)tipStr confirmStr:(NSString *)confirm failureStr:(NSString *)failure;
-(void)setTitle:(NSString *)title tip:(NSString *)tipStr detail:(NSString *)detailStr confirmStr:(NSString *)confirm failureStr:(NSString *)failure;

@end
