//
//  UserRankModel.h
//  Kingkong_ios
//
//  Created by 222 on 2018/2/7.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface UserRankModel : JSONModel

@property (nonatomic, strong) NSString<Optional>  *today_flow_money;
@property (nonatomic, strong) NSString<Optional>  *today_profit_loss;
@property (nonatomic, strong) NSString<Optional>  *user_ranking;

@end
