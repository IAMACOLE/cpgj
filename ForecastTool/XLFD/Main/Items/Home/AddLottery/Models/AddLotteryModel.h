//
//  AddLottery.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/9.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface AddLotteryModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * image;
@property (nonatomic, strong) NSString<Optional>  * name;
@property (nonatomic, strong) NSString<Optional>  * isAddButton;
@end
