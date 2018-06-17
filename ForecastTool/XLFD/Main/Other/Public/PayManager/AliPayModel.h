//
//  AliPayModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AliPayModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * partner;
@property (nonatomic, strong) NSString<Optional>  * seller_id;
@property (nonatomic, strong) NSString<Optional>  * out_trade_no;
@property (nonatomic, strong) NSString<Optional>  * subject;
@property (nonatomic, strong) NSString<Optional>  * body;
@property (nonatomic, strong) NSString<Optional>  * total_fee;
@property (nonatomic, strong) NSString<Optional>  * it_b_pay;
@property (nonatomic, strong) NSString<Optional>  * notify_url;
@property (nonatomic, strong) NSString<Optional>  * sign;
@property (nonatomic, strong) NSString<Optional>  * sign_type;
@property (nonatomic, strong) NSString<Optional>  * service;
@property (nonatomic, strong) NSString<Optional>  * payment_type;
@property (nonatomic, strong) NSString<Optional>  * _input_charset;
@end
