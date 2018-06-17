//
//  KKGDDetailModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface KKGDDetailModel : JSONModel
//"kj_code" = "";
//"kj_result" = 0;
//"lottery_qh" = 2018012173;
//"plan_kj_time" = 1516538220000;

@property (nonatomic, strong) NSString<Optional>  * kj_code;
@property (nonatomic, strong) NSString<Optional>  *lottery_qh;
@property (nonatomic, strong) NSString<Optional>  *plan_kj_time;
@property (assign, nonatomic) int kj_result;
@end
