//
//  KKAddLotteryTableViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/9.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerButtonModel.h"
@protocol KKAddLotteryTableViewCellDelegate <NSObject>
@optional
-(void)AddLotteryStatusClick:(BannerButtonModel *)model andRow:(NSInteger)row;
@end

@interface KKAddLotteryTableViewCell : UITableViewCell
@property(nonatomic,strong)BannerButtonModel *model;
@property(nonatomic,weak)id<KKAddLotteryTableViewCellDelegate>delegate;
@property(nonatomic,assign)NSInteger row;
@end
