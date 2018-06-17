//
//  KKAccountDetailModel.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKAccountDetailModel : JSONModel

@property (nonatomic, copy) NSString * coin_change_name;  // 资金变动类型名称
@property (nonatomic, copy) NSString * change_coin;        // 资金变动金额
@property (nonatomic, copy) NSString * balance;           // 变动后的余额
@property (nonatomic, copy) NSString * time_created;      // 创建时间（昨天 14:34）
@property (nonatomic, copy) NSString * remark;            // 备注
@property (nonatomic, copy) NSString * change_type_status; // 01下注 02中奖 03反水 04撤单 05充值 06提款


@property (nonatomic, copy) NSString * flag_name;         // 当充值或提现时，有此返回值
@property (nonatomic, copy) NSString * flag;              // 充值的时候: 1已支付 2支付失败 3未支付   提现时候: 1提现成功 2失败 3审核中
@end
