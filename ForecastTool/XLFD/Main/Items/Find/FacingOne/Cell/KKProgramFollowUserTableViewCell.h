//
//  KKProgramFollowUserTableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGDUserModel.h"
@interface KKProgramFollowUserTableViewCell : UITableViewCell
-(void)buildWithData:(KKGDUserModel *)model;
@property(assign,nonatomic)NSInteger row;
@end
