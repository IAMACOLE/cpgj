//
//  LotteryAlgorithm.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/7/4.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryAlgorithm : NSObject
+(NSInteger)ssc_q3zhix_kd:(NSString *)bet_number;
+(NSInteger)ssc_q2zhix_kd:(NSString *)bet_number;
+(NSInteger)ssc_r4zhix_fs:(NSString *)bet_number;
+(NSInteger)ssc_r3zhix_fs:(NSString *)bet_number;
+(NSInteger)ssc_r2zhix_fs:(NSString *)bet_number;
+(NSInteger)ssc_r3zux_hz:(NSInteger)result;
-(NSInteger)pk10GuessTheNumber:(NSString *)bet_number;
-(NSInteger)combination:(NSInteger)n andM:(NSInteger)m;
@end
