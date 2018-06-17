//
//  ChineseZodiacCollerctionViewCell.h
//  Demo_色播赔率
//
//  Created by goulela on 2017/8/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCLotteryModel.h"
#import "DefineDataHeader.h"

typedef void(^ChineseZodiac_selectBlock)(BOOL isChineseHX);
@interface ChineseZodiacCollerctionViewCell : UICollectionViewCell
@property(nonatomic ,strong)LHCLotteryModel *model;
@property(nonatomic,assign)BOOL isChineseHX;
@property (nonatomic, copy)ChineseZodiac_selectBlock selectBlock;

-(void)seleButtonClick:(UIButton *)sender;
@end
