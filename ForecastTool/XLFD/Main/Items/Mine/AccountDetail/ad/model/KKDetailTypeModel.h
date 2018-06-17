//
//  KKDetailTypeModel.h
//  Kingkong_ios
//
//  Created by hello on 2018/5/3.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KKDetailTypeModel : JSONModel
@property (nonatomic, strong) NSArray  * sub_type;
@property (nonatomic, strong) NSString<Optional>  * type_name;
@property (nonatomic, strong) NSString<Optional>  * type_value;
@end



