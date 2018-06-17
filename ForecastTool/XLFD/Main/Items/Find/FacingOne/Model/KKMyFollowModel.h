//
//  KKMyFollowModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface KKMyFollowModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * user_flag;
@property (nonatomic, strong) NSString<Optional>  * image_url;
@property (nonatomic, strong) NSString<Optional>  * nick_name;
@property (nonatomic, strong) NSString<Optional>  * wf_name;
@property (nonatomic, strong) NSString<Optional>  * plan_kj_time;
@property (nonatomic, strong) NSString<Optional>  * content;
@property (nonatomic, strong) NSString<Optional>  * lottery_name;
@property (nonatomic, strong) NSString<Optional>  *gd_number;
@property (assign, nonatomic) int  win_rate;
@property (assign, nonatomic) float  commission;
@property (assign, nonatomic) int  back_rate;
@property (assign, nonatomic) int  zhuih_count_qs;
@property (assign, nonatomic) int  left_qh_count;
@property (nonatomic, strong) NSString<Optional>  *bet_min_money;
@property (assign, nonatomic) float user_pay_money;
@property (assign, nonatomic) int gd_total_people;
@property (assign, nonatomic) float gd_total_money;
@property (assign, nonatomic) bool finish_status;
@property (assign, nonatomic) bool zhuih_win_stop;
@property (assign, nonatomic) int order_status;
@property (assign, nonatomic) float create_value;
@end
