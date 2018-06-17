//
//  KKBalanceManager.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getBalanceSuccessBlock)(NSString *balance);

@interface KKBalanceManager : NSObject

+(void)getBalance:(getBalanceSuccessBlock)successBlock;

@end
