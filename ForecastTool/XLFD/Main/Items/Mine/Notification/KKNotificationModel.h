//
//  KKNotificationModel.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKNotificationModel : JSONModel
@property (nonatomic,copy) NSString * lottery_id;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * create_time;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString *is_read;
@property (nonatomic,assign) CGFloat contentH;

@end
