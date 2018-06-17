//
//  KKLotteryDataModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/29.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KKLotteryDataModel : NSObject

@property(nonatomic,assign)NSInteger selectedBtnIndex;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,assign)BOOL isAlreadyGetData;

@end
