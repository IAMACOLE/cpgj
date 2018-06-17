//
//  KKNotificationModel.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKNotificationModel.h"

@implementation KKNotificationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

-(CGFloat)contentH{
    CGSize contentSize = [self.content boundingRectWithSize:CGSizeMake(MCScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MCFont(17)} context:nil].size;
    
    _contentH = contentSize.height;
    
    NSLog(@"%f",_contentH);
    
    return _contentH;
}

@end
