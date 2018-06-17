//
//  HomepageBannerModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/6/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface HomepageBannerModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * content;
@property (nonatomic, strong) NSString<Optional>  * image_url;
@property (nonatomic, strong) NSString<Optional>  * target_url;
@property (nonatomic, strong) NSString<Optional>  * title;
@end
