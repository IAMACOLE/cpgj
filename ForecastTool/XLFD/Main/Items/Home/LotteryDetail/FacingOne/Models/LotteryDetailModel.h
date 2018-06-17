//
//  LotteryDetailModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/21.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface LotteryDetailModel : JSONModel
@property (nonatomic, copy) NSString<Optional>  * number;
@property (nonatomic, assign) BOOL   isSelect;//1选中，0未选中
@property (nonatomic, copy) NSString<Optional>  * titleStr;

@end
