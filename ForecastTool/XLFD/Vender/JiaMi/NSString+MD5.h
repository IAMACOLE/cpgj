//
//  NSString+MD5.h
//  GPingTai
//
//  Created by 于丹丹 on 15/4/2.
//  Copyright (c) 2015年 于丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (MD5)
- (NSString *)md5Encrypt;
@end
