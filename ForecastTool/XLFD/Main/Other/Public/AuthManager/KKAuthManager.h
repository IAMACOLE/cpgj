//
//  KKAuthManager.h
//  Kingkong_ios
//
//  Created by hello on 2018/3/3.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

typedef void(^getUserInfoSuccessBlock)(UMSocialUserInfoResponse *resp);

@interface KKAuthManager : NSObject

+(void)setupUSharePlatforms;

+(void)getUserInfoForPlatform:(UMSocialPlatformType)platformType success:(getUserInfoSuccessBlock)successBlock;

@end
