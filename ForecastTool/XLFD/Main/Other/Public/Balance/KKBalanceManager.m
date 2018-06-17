//
//  KKBalanceManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKBalanceManager.h"


@implementation KKBalanceManager

+(void)getBalance:(getBalanceSuccessBlock)successBlock{
    NSString * token = [MCTool BSGetUserinfo_token];
    if(token.length <= 0){
        return;
    }
    __block NSString *balance = @"";
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/user-info"];
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:[MCTool getCurrentVC] isShowHUD:NO isShowTabbar:NO success:^(id data) {
        balance = data[@"balance"];
        successBlock(balance);
    } dislike:^(id data) {
    } failure:^(NSError *error) {
    }];
}

@end
