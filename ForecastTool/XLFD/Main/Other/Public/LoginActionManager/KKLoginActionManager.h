//
//  KKLoginActionManager.h
//  Kingkong_ios
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^loginActionErrorBlock)(NSString *message);
typedef void(^needToAddSignInViewBlock)(BOOL needAdd);

@interface KKLoginActionManager : NSObject

/**
 处理数据接口

 @param data 登录返回数据
 @param isOauthorLogin 是否第三方登录
 @param addViewBlock 添加签到页面block
 @param errorBlock 处理错误block
 */
+(void)dealWithUserData:(id)data isOauthorLogin:(BOOL)isOauthorLogin withAddViewBlock:(needToAddSignInViewBlock)addViewBlock errorBlock:(loginActionErrorBlock)errorBlock;

@end
