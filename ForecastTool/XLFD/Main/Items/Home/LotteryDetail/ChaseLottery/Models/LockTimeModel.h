//
//  LockTimeModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/6/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface LockTimeModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * lock_time;
@property (nonatomic, strong) NSString<Optional>  * lottery_qh;
@property (nonatomic, strong) NSString<Optional>  * show_qh;
@property (nonatomic, strong) NSString<Optional>  * timesStr;
@property (nonatomic, strong) NSString<Optional>  * moneyStr;
@end
