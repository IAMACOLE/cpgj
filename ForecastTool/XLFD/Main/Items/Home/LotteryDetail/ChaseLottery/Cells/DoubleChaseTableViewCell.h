//
//  DoubleChaseTableViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LockTimeModel.h"
#import "DefineDataHeader.h"

@protocol DoubleChaseTableViewCellDelegate <NSObject>
@optional

-(void)DoubleChaseTableViewCellDelete:(NSInteger)row;
@end
@interface DoubleChaseTableViewCell : UITableViewCell
@property(nonatomic,strong)LockTimeModel *model;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,weak)id<DoubleChaseTableViewCellDelegate>delegate;
@end
