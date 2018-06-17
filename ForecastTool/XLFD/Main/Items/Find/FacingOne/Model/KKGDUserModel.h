//
//  KKGDUserModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface KKGDUserModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * create_time;
@property (nonatomic, strong) NSString<Optional>  *gd_total_money;
@property (nonatomic, strong) NSString<Optional>  *nick_name;
@property (nonatomic, strong) NSString<Optional>  *user_flag;
@property (assign, nonatomic) int gd_total_qs;
@end
