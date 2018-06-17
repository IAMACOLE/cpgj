//
//  LHCManager.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LHCManager.h"

@implementation LHCManager
+(id)sharedManager{
    static LHCManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LHCManager alloc]init];
    });
    return manager;
}
-(NSMutableArray *)LHCDataArray{
    if (!_LHCDataArray) {
        _LHCDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _LHCDataArray;
}
@end
