//
//  HomeSubButtonModel.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface HomeSubButtonModel : JSONModel

@property (nonatomic, strong) NSString<Optional>  * lottery_id;
@property (nonatomic, strong) NSString<Optional>  * lottery_image;
@property (nonatomic, strong) NSString<Optional>  * lottery_name;
@property (nonatomic, strong) NSString<Optional>  * remarks;

@end
