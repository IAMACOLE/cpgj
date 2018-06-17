//
//  KKSSCBaseTableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/2/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLotteryDataModel.h"


@protocol KKSSCBaseTableViewCellDelegate <NSObject>
@optional
- (void)selectNumber;
@end

@interface KKSSCBaseTableViewCell : UITableViewCell

@property (nonatomic, copy)NSString *cellTitle;
@property(nonatomic,strong)KKLotteryDataModel *dataModel;
@property(nonatomic ,weak)id<KKSSCBaseTableViewCellDelegate>delegate;
@property(nonatomic,copy)NSString *wf_flag;

@end
