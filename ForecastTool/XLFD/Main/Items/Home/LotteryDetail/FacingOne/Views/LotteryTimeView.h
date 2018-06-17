//
//  LotteryTimeView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol LotteryTimeViewDelegate <NSObject>
@optional
-(void)endTimeResponder;
-(void)endTimeReloadData;
-(void)clickDownImgBtn;
@end
@interface LotteryTimeView : UIView
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *timeEndLabel;
@property(nonatomic,strong)UILabel *distanceLabel;
-(void)setPeriod:(NSString *)period andTime:(NSString *)timeStr andEndTimer:(NSString *)endTile;
@property(nonatomic,weak)id<LotteryTimeViewDelegate>delegate;

@end
