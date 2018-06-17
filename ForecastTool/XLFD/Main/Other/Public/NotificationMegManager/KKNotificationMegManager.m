//
//  KKNotificationMegManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/5/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKNotificationMegManager.h"
#import "KKNotificationViewController.h"

@implementation KKNotificationMegManager

+(void)presentNotification:(UNNotification *)notification{
    id alert = notification.request.content.userInfo[@"aps"][@"alert"];
    NSString *alertTitle = @"提示";
    NSString *body = @"推送内容";
    NSString *status = @"1";
    if([alert isKindOfClass:[NSString class]]){
        body = alert;
    }else if([alert isKindOfClass:[NSDictionary class]]){
        NSDictionary *alertDic = alert;
        status = alertDic[@"status"];
        body = alertDic[@"aps"][@"alert"][@"bady"];
        alertTitle = alertDic[@"aps"][@"alert"][@"title"];
    }else{
        return;
    }
    if(status.integerValue){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:body preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            KKNotificationViewController * notificationViewController = [[KKNotificationViewController alloc] init];
            [[MCTool getCurrentVC].navigationController pushViewController:notificationViewController animated:YES];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:confirmAction];
        [[MCTool getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }
    
 
}

@end
