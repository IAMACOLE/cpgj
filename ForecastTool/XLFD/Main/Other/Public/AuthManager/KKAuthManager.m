//
//  KKAuthManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/3.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKAuthManager.h"


#define UMENG_APPKEY  @"5aa1229da40fa3020e000015"

#if IS_TEST

#define WechatAppKey  @"wxe3a9b4406fac06dc"
#define WechatSecret  @"ef7f88d1e04a33b9ac9326aed705d86f"
#define QQAppKey      @"101460635"

#else

#define WechatAppKey  @"wx8020e21aced6acc1"
#define WechatSecret  @"f0ee9461f534c2eafc05a0abc8c31284"
#define QQAppKey      @"101460635"

#endif

@implementation KKAuthManager

+(void)setupUSharePlatforms{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_bundleId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *app_bundleversion = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *channelName = [NSString stringWithFormat:@"%@|%@|V%@|%@",app_name,app_bundleId,app_version,app_bundleversion];
    NSLog(@"channel == %@",channelName);
    [UMConfigure initWithAppkey:UMENG_APPKEY channel:channelName];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WechatAppKey appSecret:WechatSecret redirectURL:@"http://www.weishuoba.com"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ  appKey:QQAppKey appSecret:nil redirectURL:@"http://www.weishuoba.com"];
}

+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType success:(getUserInfoSuccessBlock)successBlock
{
    //判断手机是否有安装相应app
    if(![[UMSocialManager defaultManager]isInstall:platformType]){
        [MCView BSAlertController_oneOption_viewController:[MCTool getCurrentVC] message:@"您还未安装该APP，请安装后重试" cancle:^{
            
        }];
        return ;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"Get info fail with error %@",error);
            NSDictionary *messageDic = error.userInfo;
            NSString *msg = [messageDic objectForKey:@"message"];
            if ([msg isEqualToString:@"Operation is cancel"]) {
              [MCView BSMBProgressHUD_onlyTextWithView:[MCTool getCurrentVC].view andText:@"用户取消授权"];
            }else{
                [MCView BSMBProgressHUD_onlyTextWithView:[MCTool getCurrentVC].view andText:msg];
            }
        } else {
            
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            successBlock(resp);
            
        }
    }];
}

@end
