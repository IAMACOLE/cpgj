//
//  HistpryOfTheLotteryModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface HistpryOfTheLotteryModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * kj_code;
@property (nonatomic, strong) NSString<Optional>  * lottery_id;
@property (nonatomic, strong) NSString<Optional>  * lottery_name;
@property (nonatomic, strong) NSString<Optional>  * lottery_qh;
@property (nonatomic, strong) NSString<Optional>  * real_kj_time;
@property (nonatomic, strong) NSString<Optional>  * show_type;
/*
 show_type
 1：圆圈全红色
 2：圆圈，最后一个是蓝色、其他都是红色
 3：圆圈，最后两个是蓝色、其他都是红色
 4：绿色矩形展示*/
@end
