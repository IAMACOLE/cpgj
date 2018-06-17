//
//  KKActivityModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface KKActivityModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * title;
@property (nonatomic, strong) NSString<Optional>  * image_url;
@property (nonatomic, strong) NSString<Optional>  * turn_url;
@end
