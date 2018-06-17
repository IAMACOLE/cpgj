//
//  KKURLManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKURLManager.h"

@implementation KKURLManager

+(void)getUrlList{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"config/url-list"];
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSArray * dataArray = (NSArray *)data;
        for (NSDictionary * dict in dataArray) {
            NSString * flag = dict[@"flag"];
            NSString * url = dict[@"url"];
            
            if (flag == nil) {
                flag = @"后台未配置";
            }
            if (url == nil) {
                url = @"后台未配置";
            }
            
            if ([flag  isEqualToString:BSConfig_register_protocol]) {
                [MCTool BSSetObject:url forKey:BSConfig_register_protocol];
            } else if ([flag isEqualToString:BSConfig_security_problem]) {
                [MCTool BSSetObject:url forKey:BSConfig_security_problem];
            } else if ([flag isEqualToString:BSConfig_recharge_url]) {
                [MCTool BSSetObject:url forKey:BSConfig_recharge_url];
            }else if ([flag isEqualToString:BSConfig_customer_service_url]) {
                [MCTool BSSetObject:url forKey:BSConfig_customer_service_url];
            }else if ([flag isEqualToString:BSConfig_bzjlq_url]) {
                [MCTool BSSetObject:url forKey:BSConfig_bzjlq_url];
            }else if ([flag isEqualToString:BSConfig_fx_helper_url]) {
                [MCTool BSSetObject:url forKey:BSConfig_fx_helper_url];
            }else if ([flag isEqualToString:BSConfig_gd_helper_url]) {
                [MCTool BSSetObject:url forKey:BSConfig_gd_helper_url];
            }else if ([flag isEqualToString:BSConfig_hd_fxlj_url]) {
                [MCTool BSSetObject:url forKey:BSConfig_hd_fxlj_url];
            }
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {

    }];
}

@end
