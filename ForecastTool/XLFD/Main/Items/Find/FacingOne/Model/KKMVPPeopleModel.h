//
//  KKMVPPeopleModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


//字段说明
//nick_name    用户昵称
//user_flag    用户标识（关注用户时传此值）
//ds_ranking    排名
//image_url    头像url
//count_fans    粉丝数
//win_rate    胜率
//create_value    创造价值
//has_gz    是否关注(0未关注1已关注3隐藏关注按钮)，登录状态下返回

@interface KKMVPPeopleModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * nick_name;
@property (nonatomic, strong) NSString<Optional>  * user_flag;
@property (assign, nonatomic) int  ds_ranking;
@property (nonatomic, strong) NSString<Optional>  * image_url;
@property (assign, nonatomic) int  count_fans;
@property (assign, nonatomic) int  win_rate;
@property (assign, nonatomic) double  create_value;
//@property (assign, nonatomic) NSInteger has_gz;
//@property (strong, nonatomic) NSNumber<Optional>* has_gz;
@property (strong, nonatomic) NSNumber<Optional>* has_gz;



//@property (strong, nonatomic) NSNumber<Optional>* has_gz;



@end
