//
//  WeChatPayModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WeChatPayModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * appid;//openID
@property (nonatomic, strong) NSString<Optional>  * mch_id;//partnerId
@property (nonatomic, strong) NSString<Optional>  * prepay_id;//prepay_id
@property (nonatomic, strong) NSString<Optional>  * nonce_str;//nonceStr
@property (nonatomic, strong) NSString<Optional>  * timestamp;//timestamp
@property (nonatomic, strong) NSString<Optional>  * paySign;//sign
@end
