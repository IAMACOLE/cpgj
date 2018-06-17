//
//  KKActivityTableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKActivityModel.h"
@interface KKActivityTableViewCell : UITableViewCell
-(void)buildWithData:(KKActivityModel *)model;
@end
