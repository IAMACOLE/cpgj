//
//  KKNewMemberViewManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/5/10.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKNewMemberViewManager.h"

@implementation KKNewMemberViewManager

+(void)checkUserisNewMember:(isNewMemberBlock)isNew{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/activity/today-is-received"];
    NSDictionary *param = @{@"hd_flag":@"hd_xrkh"};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        isNew([data[@"is_received"] intValue] == 0,data[@"url"]);
    } dislike:^(id data) {
        isNew(NO ,@"");
    } failure:^(NSError *error) {
        isNew(NO ,@"");
    }];
}

@end
