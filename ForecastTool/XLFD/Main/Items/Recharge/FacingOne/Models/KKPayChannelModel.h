//
//  KKPayChannelModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/3/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface KKPayChannelModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * label;
@property (nonatomic, strong) NSString<Optional>  * image_url;
@property (nonatomic, strong) NSString<Optional>  * turn_url;
@property (nonatomic, strong) NSString<Optional>  * channel_type;
@end
