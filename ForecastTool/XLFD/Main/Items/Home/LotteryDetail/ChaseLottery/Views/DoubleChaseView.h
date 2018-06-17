//
//  DoubleChaseView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryTimeView.h"
#import "DefineDataHeader.h"

@protocol DoubleChaseViewDelegate <NSObject>
@optional
-(void)generateChaseClick:(NSString *)times andPreiod:(NSString *)preiod;
-(void)stareEditing:(NSString *)str andStatus:(NSString *)status andSelectTextField:(NSInteger)selectTextFiel;
-(void)generateChaseClick;
-(void)endTimeResponder;
-(void)endTimeReloadData;

@end
@interface DoubleChaseView : UIView
-(void)setAllperiod:(NSString *)period andMoneyStr:(NSString *)money;
@property(nonatomic,strong)UITextField *timesTextField;//倍数
@property(nonatomic, strong)UITextField *bonusLabel;//追号倍数
@property(nonatomic,strong)LotteryTimeView *timeView;
@property(nonatomic,assign)BOOL isDoubleChaseView;
@property(nonatomic, strong)UITextField *preiodTextField;//追号期数
@property(nonatomic,strong)UITextField * modelTextField;//隔多少期
@property(nonatomic,weak)id<DoubleChaseViewDelegate>delegate;

@end
