//
//  KKNewMemberViewManager.h
//  Kingkong_ios
//
//  Created by hello on 2018/5/10.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^isNewMemberBlock)(BOOL isNew,NSString *url);

@interface KKNewMemberViewManager : NSObject

+(void)checkUserisNewMember:(isNewMemberBlock)isNew;

@end
