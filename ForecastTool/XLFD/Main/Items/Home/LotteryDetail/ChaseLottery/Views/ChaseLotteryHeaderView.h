//
//  ChaseLotteryHeaderView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryTimeView.h"
#import "ChaseLotterTimeView.h"
#import "DefineDataHeader.h"

@protocol ChaseLotteryHeaderViewDelegate <NSObject>
@optional
-(void)generateChaseClick:(NSString *)times andPreiod:(NSString *)preiod;
-(void)stareEditing:(NSString *)str andStatus:(NSString *)status andSelectTextField:(NSInteger)selectTextFiel;
-(void)generateChaseClick;
-(void)endTimeResponder;
-(void)endTimeReloadData;

@end


@interface ChaseLotteryHeaderView : UIView
@property(nonatomic,strong)UIButton *timesButton;//倍数
@property(nonatomic, strong)UIButton *bonusButton;//追号倍数
@property(nonatomic,strong)ChaseLotterTimeView *timeView;
@property(nonatomic, strong)UIButton *preiodButton;//追号期数
@property(nonatomic,strong)UIButton * modelButton;//隔多少期
@property(nonatomic,weak)id<ChaseLotteryHeaderViewDelegate>delegate;
@end
