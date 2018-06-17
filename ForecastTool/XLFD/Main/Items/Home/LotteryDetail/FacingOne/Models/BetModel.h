//
//  BetModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/6/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface BetModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * lottery_modes;
@property (nonatomic, strong) NSString<Optional>  * wf_flag;
@property (nonatomic, strong) NSString<Optional>  * lottery_qh;
@property (nonatomic, strong) NSString<Optional>  * bet_count;
@property (nonatomic, strong) NSString<Optional>  * userAddressId;
@end
