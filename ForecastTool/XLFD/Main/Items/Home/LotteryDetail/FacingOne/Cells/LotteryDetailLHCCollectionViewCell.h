//
//  LotteryDetail4CollectionViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCLotteryModel.h"
#import "DefineDataHeader.h"

@protocol LotteryDetail4CollectionViewCellDelegate <NSObject>
@optional
- (void)LotteryDetailCollectionViewCellProtocolMethod:(NSInteger)section and:(NSInteger)row andButton:(UIButton *)button;
- (void)selectNumber;

@end
@interface LotteryDetailLHCCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<LotteryDetail4CollectionViewCellDelegate> delegate;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic ,strong)LHCLotteryModel *model;
@property (nonatomic, assign) BOOL isLongCell;
@end
