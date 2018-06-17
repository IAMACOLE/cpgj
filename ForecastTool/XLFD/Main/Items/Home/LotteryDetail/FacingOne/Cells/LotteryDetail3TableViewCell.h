//
//  LotteryDetail3TableViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLotteryDataModel.h"
#import "LotteryDetailModel.h"
#import "DefineDataHeader.h"

@protocol LotteryDetail3TableViewCellDelegate <NSObject>
@optional
- (void)selectNumber;


@end
@interface LotteryDetail3TableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel   * firstLabel;
@property(nonatomic,strong)KKLotteryDataModel *dataModel;
@property(nonatomic ,weak)id<LotteryDetail3TableViewCellDelegate>delegate;
@end
