//
//  KKFollowTableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/17.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMyFollowModel.h"
@interface KKFollowTableViewCell : UITableViewCell
-(void)buildWithData:(KKMyFollowModel *)model;
@end
