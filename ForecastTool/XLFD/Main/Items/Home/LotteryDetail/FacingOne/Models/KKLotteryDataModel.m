//
//  KKLotteryDataModel.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKLotteryDataModel.h"
#import "LotteryDetailModel.h"

@implementation KKLotteryDataModel

-(NSArray *)dataSource{
    if(_dataSource == nil){
        NSMutableArray *arr = [NSMutableArray array];
        for(int i = 0;i < 10;i++){
            LotteryDetailModel *model = [LotteryDetailModel new];
            model.number = [NSString stringWithFormat:@"%d",i];
            [arr addObject:model];
        }
        _dataSource = arr.copy;
    }
    return _dataSource;
}

@end
