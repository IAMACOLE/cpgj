//
//  KKNotificationSettingModel.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/20.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKNotificationSettingModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *notice_type;
@property (nonatomic, strong) NSString<Optional> *notice_title;
@property (nonatomic, strong) NSString<Optional> *remark;
@property (nonatomic, strong) NSArray<Optional> *subList;
@property (nonatomic, assign) int notice_on_off;

@end
