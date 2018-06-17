//
//  HeadView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryTimeView.h"
#import "DefineDataHeader.h"

@protocol HeadViewDelegate <NSObject>
@optional
-(void)historyClick;
-(void)endTimeResponder;
-(void)endTimeReloadData;
-(void)shakeActionClick;

@end
@interface HeadView : UIView

//@property(nonatomic,strong)LotteryTimeView *timeView;
@property(nonatomic,strong)UILabel *currentPlayLabel;
@property(nonatomic ,weak)id<HeadViewDelegate>delegate;

@end
