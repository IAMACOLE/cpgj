//
//  KKBetRecordModel.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKBetRecordModel : JSONModel


@property (nonatomic, copy) NSString * bet_money;      // 投注多少元
@property (nonatomic, copy) NSString * bet_time;       // 投注的时间
@property (nonatomic, copy) NSString * lottery_name;   // 彩票名称
@property (nonatomic, copy) NSString * lottery_qh;     // 彩票期号（2017050288）
@property (nonatomic, copy) NSString * order_number;   // 投注订单记录id
@property (nonatomic, assign) NSInteger status;        // 投注订单的状态0：未开奖 1：未中奖 2：撤销 3：中奖 4：订单异常

@end
