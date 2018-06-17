//
//  GameSelectModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface GameSelectModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * title;
@property (nonatomic, strong) NSDictionary<Optional>  * param;
@property (nonatomic, strong) NSDictionary<Optional>  * calculate;
@property (nonatomic, strong) NSString<Optional>  * explain;
@property (nonatomic, strong) NSString<Optional>  * example;
@property (nonatomic, strong) NSString<Optional>  * help;

@end
