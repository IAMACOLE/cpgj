//
//  GameSelectDetailModel.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/15.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DefineDataHeader.h"

@interface GameSelectDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional>  * name;
@property (nonatomic, strong) NSString<Optional>  * wf_flag;
@property (nonatomic,strong)  NSArray<Optional>  * wf_pl;
@property (nonatomic, strong) NSString<Optional>  * title;
@property (nonatomic, strong) NSString<Optional>  * selectRow;
@end
