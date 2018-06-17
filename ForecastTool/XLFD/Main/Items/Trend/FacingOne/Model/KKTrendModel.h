//
//  KKTrendModel.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKTrendModel : JSONModel


@property (nonatomic, copy) NSString * lottery_id;      // 彩票id
@property (nonatomic, copy) NSString * lottery_name;    // 彩票名称
@property (nonatomic, copy) NSString * lottery_qh;      // 彩票期号
@property (nonatomic, copy) NSString * kj_code;         // 开奖号码（1,2,3,4,5
@property (nonatomic, copy) NSString * real_kj_time;    // 实际开奖时间（2017-03-09 （周日）
@property (nonatomic, copy) NSString * show_type;       // 1：圆圈全红色 2：圆圈，最后一个是蓝色、其他都是红色 3：圆圈，最后两个是蓝色、其他都是红色 4：绿色矩形展示
@end
