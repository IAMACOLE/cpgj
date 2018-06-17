//
//  PayObject.m
//  SchoolMakeUp
//
//  Created by qj-07-pc001 on 2017/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "PayObject.h"
#import "WechatAuthSDK.h"
#import <AlipaySDK/AlipaySDK.h>

// 微信支付
#import "WXApi.h"
#import "payRequsestHandler.h"
@implementation PayObject
+ (void)LYSendAliPayModel:(AliPayModel *)alipayModel success:(PaySuccessBlock)successBlock failure:(PayFailureBlock)failureBlock{
    NSString *str = [NSString stringWithFormat:@"partner=%@&seller_id=%@&out_trade_no=%@&subject=%@&body=%@&total_fee=%@&notify_url=%@&service=%@&payment_type=%@&_input_charset=%@&it_b_pay=%@&sign=\"%@\"&sign_type=\"%@\"",alipayModel.partner,alipayModel.seller_id,alipayModel.out_trade_no,alipayModel.subject,alipayModel.body,alipayModel.total_fee,alipayModel.notify_url,alipayModel.service,alipayModel.payment_type,alipayModel._input_charset,alipayModel.it_b_pay,alipayModel.sign,alipayModel.sign_type];
    [[AlipaySDK defaultService] payOrder:str fromScheme:@"SchoolMakeUp" callback:^(NSDictionary *resultDic) {
        NSString *resultNum=[[NSString alloc] initWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        if ([resultNum isEqualToString:@"9000"])//9000 成功
        {
            successBlock();
        }
        else
        {
            failureBlock();
        }
    }];
}
+ (void)LYSendWeChatPayModel:(WeChatPayModel *)WeChatModel success:(PaySuccessBlock)successBlock failure:(PayFailureBlock)failureBlock{
    [WXApi registerApp:@"wx645f16ce6b3c8894" withDescription:@"校妆"];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = WeChatModel.appid;
    req.partnerId           = WeChatModel.mch_id;
    req.prepayId            = WeChatModel.prepay_id;
    req.nonceStr            = WeChatModel.nonce_str;
    req.timeStamp           = [WeChatModel.timestamp intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = WeChatModel.paySign;
    [WXApi sendReq:req];
}
@end
