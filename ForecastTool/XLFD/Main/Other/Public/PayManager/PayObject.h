//
//  PayObject.h
//  SchoolMakeUp
//
//  Created by qj-07-pc001 on 2017/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AliPayModel.h"
#import "WeChatPayModel.h"

typedef void(^PaySuccessBlock)();
typedef void(^PayFailureBlock)();

@interface PayObject : NSObject

+ (void)LYSendAliPayModel:(AliPayModel *)alipayModel success:(PaySuccessBlock)successBlock failure:(PayFailureBlock)failureBlock;
+ (void)LYSendWeChatPayModel:(WeChatPayModel *)WeChatModel success:(PaySuccessBlock)successBlock failure:(PayFailureBlock)failureBlock;
@end
