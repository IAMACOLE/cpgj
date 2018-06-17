//
//  DoubleChaseModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface DoubleChaseModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * period;
@property (nonatomic, strong) NSString<Optional>  * count;
@property (nonatomic, strong) NSString<Optional>  * multiple;
@property (nonatomic, strong) NSString<Optional>  * endTime;
@property (nonatomic, strong) NSString<Optional>  * price;
@end
