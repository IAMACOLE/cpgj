//
//  XXLuckyDataModel.h
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  XXLuckyModel;

@interface XXLuckyDataModel : NSObject

@property (nonatomic, strong) NSString * kj_code;
@property (nonatomic, strong) NSString * lottery_id;
@property (nonatomic, strong) NSString * lottery_name;
@property (nonatomic, strong) NSString * lottery_qh;
@property (nonatomic, strong) NSString * real_kj_time;
@property (nonatomic, strong) NSString * show_type;

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray * rankingArr;
@property (nonatomic, strong) NSMutableArray * colorArr;

@end
