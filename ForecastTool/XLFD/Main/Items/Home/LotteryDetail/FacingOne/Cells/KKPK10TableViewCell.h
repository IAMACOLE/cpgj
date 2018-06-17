//
//  KKPK10TableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/2/2.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLotteryDataModel.h"

@protocol LotteryPK10TableViewCellDelegate <NSObject>
@optional
- (void)selectNumber;
@end

@interface KKPK10TableViewCell : UITableViewCell
@property (nonatomic, copy)NSString *cellTitle;
@property (nonatomic, strong) KKLotteryDataModel *dataModel;
@property(nonatomic,copy)NSString *wf_flag;
@property(nonatomic ,weak)id<LotteryPK10TableViewCellDelegate>delegate;

@end
