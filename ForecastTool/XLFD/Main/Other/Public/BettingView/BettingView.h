//
//  BettingView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BettingTimeView.h"
#import "DefineDataHeader.h"


@interface BettingView : UIView

typedef void (^BettingViewBlock)();
@property (nonatomic, copy) BettingViewBlock confirmBlock;
@property (nonatomic, copy) BettingViewBlock cancelBlock;
- (void)bettingFinish:(BettingViewBlock) callback;


@property (nonatomic, strong) UILabel * type_bottomLabel;
@property (nonatomic, strong) UILabel * changeMoney_bottomLabel;
@property (nonatomic, strong) UILabel * totalMoney_bottomLabel;
@property(nonatomic , strong) UILabel *playTypeLabel_rightLabel;
@property (nonatomic, strong) UILabel * bettingNumber_rightLabel;
@property(nonatomic , strong) UILabel * balance_rightLabel;
@property(nonatomic , strong) UILabel *money_rightLabel;
@property(nonatomic,strong)BettingTimeView *timeView;

-(void)setData:(NSString *)playType andMoney:(NSString *)money andBalance:(NSString *)balance;
@end
