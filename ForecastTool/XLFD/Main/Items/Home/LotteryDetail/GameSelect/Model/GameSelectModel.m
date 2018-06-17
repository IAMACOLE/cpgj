//
//  GameSelectModel.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "GameSelectModel.h"
#import <Foundation/Foundation.h>
@implementation GameSelectModel


-(void)setTitle:(NSString<Optional> *)title {
    
    NSString *strValue = title;
    if (strValue.length <= 3) {
        _title = [NSString stringWithFormat:@"%@  ",strValue];
    }else{
        _title = strValue;
    }
    
}


@end
