//
//  KKLotteryTitleDataModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface KKLotteryTitleDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional> * lottery_id;
@property (nonatomic, strong) NSString<Optional> * lottery_name;
@property (nonatomic, strong) NSString<Optional> * lottery_type;

@end
