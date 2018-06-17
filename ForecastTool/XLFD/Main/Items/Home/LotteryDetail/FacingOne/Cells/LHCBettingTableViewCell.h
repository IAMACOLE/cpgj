//
//  LHCBettingTableViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCLotteryModel.h"
#import "DefineDataHeader.h"

typedef void(^LHCBetting_deleteBlock)(NSInteger row);
typedef void(^LHCBetting_editBlock)(NSInteger row,NSString * money);


@interface LHCBettingTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger cellRow;

@property (nonatomic, copy)LHCBetting_deleteBlock deleteBlock;
@property (nonatomic, copy)LHCBetting_editBlock editBlock;
@property(nonatomic,strong)LHCLotteryModel *model;

@end
