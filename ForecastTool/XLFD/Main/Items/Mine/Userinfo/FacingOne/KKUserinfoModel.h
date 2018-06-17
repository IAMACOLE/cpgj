//
//  KKUserinfoModel.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKUserinfoModel : JSONModel

@property (nonatomic, strong) UIImage * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * detail;

@property (nonatomic, copy) NSString * isBinding;
@end
