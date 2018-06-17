//
//  LHCManager.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineDataHeader.h"

@interface LHCManager : NSObject
+(id)sharedManager;
@property(nonatomic,strong)NSMutableArray *LHCDataArray;
@end
