//
//  LHCLotteryModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/3.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface LHCLotteryModel : JSONModel
@property (nonatomic, copy) NSString<Optional>  * number;
@property (nonatomic, assign) BOOL   isSelect;//1选中，0未选中
@property (nonatomic, copy) NSString<Optional>  * titleStr;
@property (nonatomic, copy) NSString<Optional>  * award_money;//赔率
@property (nonatomic, copy) NSString<Optional>  * flag;
@property (nonatomic, copy) NSString<Optional>  * value;
@property (nonatomic, copy) NSString<Optional>  * pl_name;//选号名称
@property (nonatomic, strong) NSString<Optional>  * species;//种类
@property (nonatomic, strong) NSString<Optional>  * money;//金钱
@property (nonatomic, strong) NSString<Optional>  * wf_flag;
@property (nonatomic, strong) NSString<Optional>  * pl_flag;
@property (nonatomic, assign) BOOL   isAlreadyGetData;

@end
