//
//  KKFindModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

//user_flag    用户标识
//image_url    用户头像
//nick_name    用户昵称
//win_rate    胜率
//commission    佣金
//back_rate    回报率
//zhuih_count_qs    追号几期
//left_qh_count    剩几期
//zhuih_win_stop    1表示中奖即停
//bet_min_money    几元起投
//lottery_name    彩种名称
//wf_name    玩法名称
//plan_kj_time    下一期开奖时间
//content    内容
//user_pay_money    自购金额
//gd_total_people    跟单人数
//gd_total_money    总跟单额
//gd_number    跟单号
//create_time    发布时间


@interface KKFindModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * user_flag;
@property (nonatomic, strong) NSString<Optional>  * image_url;
@property (nonatomic, strong) NSString<Optional>  * nick_name;
@property (nonatomic, strong) NSString<Optional>  * wf_name;
@property (nonatomic, strong) NSString<Optional>  * plan_kj_time;
@property (nonatomic, strong) NSString<Optional>  * content;
@property (nonatomic, strong) NSString<Optional>  * lottery_name;
@property (nonatomic, strong) NSString<Optional>  *gd_number;
@property (nonatomic, strong) NSString<Optional>  *ds_ranking;
@property (assign, nonatomic) int  win_rate;
@property (assign, nonatomic) float  commission;
@property (assign, nonatomic) int  back_rate;
@property (assign, nonatomic) int  zhuih_count_qs;
@property (assign, nonatomic) int  left_qh_count;
@property (nonatomic, strong) NSString<Optional>  *bet_min_money;
@property (assign, nonatomic) float user_pay_money;
@property (assign, nonatomic) int gd_total_people;
@property (assign, nonatomic) float gd_total_money;

@property (assign, nonatomic) bool zhuih_win_stop;

//@property (assign, nonatomic) int order_status; //开奖结果(0未开奖1未中奖2撤销3中奖4异常)
//@property (assign, nonatomic) float create_value;


@end
