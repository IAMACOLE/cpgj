//
//  HomeButtonModel.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "HomeButtonModel.h"

@implementation HomeButtonModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return true;
}

- (void)countDownWithlottery_id:(NSString *)lotteryId {
    self.countNum -= 1;
    if (self.countNum <= 0) {
        if (lotteryId.length > 0 && ![lotteryId isEqual:@"xglhc"]) {
            [self getlockTimeWithLotteryId:lotteryId];
        }
    }
}

- (int)changeTimeStrToInt:(NSString *)lock_time {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateFormatter dateFromString:lock_time];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:currentDate];
    return (int)timeInterval;
}

- (void)getlockTimeWithLotteryId:(NSString *)lotteryId {
	[self.dataSource getlockTimeWithLotteryId:lotteryId];
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"gc/cp-lock-time"];
//    NSDictionary *param = @{@"lottery_id": lotteryId};
//    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
//        NSDictionary *dataDict = (NSDictionary *)data;
//        self.countNum = [self changeTimeStrToInt:dataDict[@"lock_time"]];
//    } dislike:^(id data) {
//    } failure:^(NSError *error) {
//    }];
}

- (NSString *)currentTimeString {
    if (self.countNum <= 0) {
        return @"00:00:00";
    } else {
        int hours =  (int)self.countNum / 3600 % 24;
        int minutes =  (int)(self.countNum - hours * 3600) / 60;
        int seconds = (int)(self.countNum - hours * 3600 - minutes * 60);
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
}

@end
