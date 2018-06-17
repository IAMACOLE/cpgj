//
//  HomeButtonModel.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@protocol UpdateModelDataSource

@optional
- (void)getlockTimeWithLotteryId:(NSString *)lotteryId;

@end

@interface HomeButtonModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *lottery_type;
@property (nonatomic, strong) NSString<Optional> *lottery_id;
@property (nonatomic, strong) NSString<Optional> *lottery_image;
@property (nonatomic, strong) NSString<Optional> *lottery_label;
@property (nonatomic, strong) NSString<Optional> *lottery_name;
@property (nonatomic, strong) NSString<Optional> *sub_lottery_flag;
@property (nonatomic, strong) NSString<Optional> *remarks;
@property (nonatomic, strong) NSMutableArray<Optional> *sub_lottery;
@property (nonatomic, strong) NSString<Optional> *countNumStr;
@property (nonatomic, assign) int countNum;
@property (nonatomic, weak) id<UpdateModelDataSource> dataSource;

- (void)countDownWithlottery_id:(NSString *)lotteryId;
- (NSString *)currentTimeString;
@end
