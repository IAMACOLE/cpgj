//
//  XXSamePeriodHeadView.h
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXLuckyDataModel.h"

@interface XXSamePeriodHeadView : UIView
@property(nonatomic,strong)XXLuckyDataModel *luckyDataModel;
@property(nonatomic,copy)void (^clickSelectBtn)(void);

@end
