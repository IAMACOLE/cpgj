//
//  BaseLotterHistoryMananger.m
//  Kingkong_ios
//
//  Created by hello on 2018/4/6.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "BaseLotterHistoryMananger.h"
#import "HistpryOfTheLotteryModel.h"

@implementation BaseLotterHistoryMananger

+(void)getLotteryHistoryDataWithLotteryId:(NSString *)lotteryID successBlock:(HistorySuccessBlock)successBlock{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"cp/kj-trend-history"];
    if (lotteryID.length == 0) {
        return;
    }
    NSDictionary * parameter = @{
                                 @"lottery_id" : lotteryID,
                                 @"page_no" : @"1",
                                 @"page_size"   : @"10",
                                 
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:[MCTool getCurrentVC] isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSMutableArray *dataSoucre = [HistpryOfTheLotteryModel mj_objectArrayWithKeyValuesArray:data];
        successBlock(dataSoucre);
    } dislike:^(id data) {
    } failure:^(NSError *error) {
    }];
}

@end
