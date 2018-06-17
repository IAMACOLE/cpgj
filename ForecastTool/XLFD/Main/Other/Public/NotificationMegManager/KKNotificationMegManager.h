//
//  KKNotificationMegManager.h
//  Kingkong_ios
//
//  Created by hello on 2018/5/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface KKNotificationMegManager : NSObject

+(void)presentNotification:(UNNotification *)notification;

@end
