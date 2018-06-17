//
//  KKLoginActionManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKLoginActionManager.h"
#import "JPUSHService.h"

@implementation KKLoginActionManager

+(void)dealWithUserData:(id)data isOauthorLogin:(BOOL)isOauthorLogin withAddViewBlock:(needToAddSignInViewBlock)addViewBlock errorBlock:(loginActionErrorBlock)errorBlock{
    
    NSDictionary *dataDict = (NSDictionary *)data;
    NSString *message = dataDict[@"errorMsg"];
    if (message.length > 0) {
        errorBlock(message);
    }
    
    NSString * md5_salt = data[@"md5_salt"];
    NSString * user_token = data[@"user_token"];
    NSString * user_id = data[@"user_id"];
    NSString * nickName = data[@"nick_name"];
    NSString * image_url = data[@"image_url"];
    NSString * passwordStatus = kStringIsEmpty(data[@"login_passwd_status"])? @"" : data[@"login_passwd_status"];
    
    NSString *bank_passwd_status = kStringIsEmpty(data[@"bank_passwd_status"])? @"" : data[@"bank_passwd_status"];
    
    if (kStringIsEmpty(image_url)) {
        image_url = @"";
    }
    
    if(kStringIsEmpty(nickName)){
        nickName = @"";
    }
    
    NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithCapacity:0];
    [dictM setObject:md5_salt forKey:BSUserinfo_md5_salt];
    [dictM setObject:user_token forKey:BSUserinfo_token];
    [dictM setObject:user_id forKey:BSUserinfo_userId];
    [dictM setObject:nickName forKey:BSUserinfo_nick_name];
    [dictM setObject:image_url forKey:BSUserinfo_image_url];
    [dictM setObject:passwordStatus forKey:BSUserinfo_password_status];
    [dictM setObject:bank_passwd_status forKey:BSbank_passwd_status];
    
    // 极光推送设置别名
    [JPUSHService setAlias:user_id completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:0];
    
    [MCTool BSSetObject:dictM forKey:BSUserinfo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //发出通知 刷新首页的数据
        NSNotification * notification = [NSNotification notificationWithName:@"RELOADHOMEPAGE" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        //第三方登录情况下 需要提示用户设置密码
        [[MCTool getCurrentVC].navigationController popToRootViewControllerAnimated:YES];
        
        if(KK_STATUS){
             addViewBlock(NO);
        }else{
           
            [self judgeIsOrNotShowSignInViewWithAddViewBlock:^(BOOL needAdd){
                addViewBlock(needAdd);
            }];
        }
    
    });
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BSNotification_reloadPersonalInformation object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:BSNotification_ChangeLoginStatus object:nil];
}

//判断是否添加签到页面
+ (void)judgeIsOrNotShowSignInViewWithAddViewBlock:(needToAddSignInViewBlock)addViewBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/activity/today-is-received"];
    NSDictionary *param = @{@"hd_flag":@"hd_qiandao"};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:[MCTool getCurrentVC] isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSDictionary *dataDict = (NSDictionary *)data;
        if (![dataDict[@"is_received"] isEqual:@"1"]) {
            addViewBlock(YES);
        }else{
            addViewBlock(NO);
        }
    } dislike:^(id data) {
        addViewBlock(NO);
    } failure:^(NSError *error) {
        addViewBlock(NO);
    }];
}

@end
