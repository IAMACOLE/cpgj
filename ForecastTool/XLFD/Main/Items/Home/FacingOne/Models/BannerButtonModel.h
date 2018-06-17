//
//  BannerButtonModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface BannerButtonModel : JSONModel

@property (nonatomic, strong) NSString<Optional>  * lottery_id;
@property (nonatomic, strong) NSString<Optional>  * lottery_image;
@property (nonatomic, strong) NSString<Optional>  * lottery_label;
@property (nonatomic, strong) NSString<Optional>  * lottery_name;
@property (nonatomic, strong) NSString<Optional>  * lottery_type;
@property (nonatomic, strong) NSArray<Optional>  *  child;
@property (nonatomic, strong) NSString<Optional>  * isShow;
@property (nonatomic, strong) NSString<Optional>  * lottery_flag;

@end
