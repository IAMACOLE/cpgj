//
//  KKShakeActionManager.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/30.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKShakeActionManager : NSObject

+(void)shakeActionWithLotteryType:(NSString *)lotteryType dataArray:(NSArray *)dataArray wf_flag:(NSString *)wf_flag selectedDigitArr:(NSMutableArray *)selectedDigitArr;

@end
