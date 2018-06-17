//
//  WaveColorCollerctionViewCell.h
//  Demo_色播赔率
//
//  Created by goulela on 2017/8/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCLotteryModel.h"
#import "DefineDataHeader.h"

typedef void(^WaveColor_selectBlock)();
@interface WaveColorCollerctionViewCell : UICollectionViewCell


@property(nonatomic ,strong)LHCLotteryModel *model;
@property(nonatomic,strong)NSArray *dataArray;
@property (nonatomic, copy)WaveColor_selectBlock selectBlock;

@end
