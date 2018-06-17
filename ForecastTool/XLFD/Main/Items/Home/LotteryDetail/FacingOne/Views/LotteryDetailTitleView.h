//
//  LotteryDetailTitleView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/2.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"
/**
 * 显示选彩页面
 */

@interface LotteryDetailTitleView : UIView
typedef void(^TitleButtonShowFilterViewBlock)(void);
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) TitleButtonShowFilterViewBlock showFilterViewBlock;
@property (nonatomic, copy) UIButton *centerButton;
-(void)centerButtonClick:(UIButton *)sender;
- (void)setTitle:(NSString *)titleString;
@end
