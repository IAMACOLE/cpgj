//
//  PayModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/5.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PayModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * NAME_KEY;
@property (nonatomic, strong) NSString<Optional>  * IMAGE_KEY;
@property (nonatomic, strong) NSString<Optional>  * SELECT_KEY;
@end
