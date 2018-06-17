//
//  BaseLotterHistoryMananger.h
//  Kingkong_ios
//
//  Created by hello on 2018/4/6.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineDataHeader.h"

typedef void(^HistorySuccessBlock)(NSMutableArray *dataSource);

@interface BaseLotterHistoryMananger : NSObject

+(void)getLotteryHistoryDataWithLotteryId:(NSString *)lotteryID successBlock:(HistorySuccessBlock)successBlock;

@end
