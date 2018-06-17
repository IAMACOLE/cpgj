//
//  MineCollectionViewCell.h
//  Kingkong_ios
//
//  Created by 222 on 2018/2/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@interface MineCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLabel;
//@property (nonatomic, strong) UIView *rightVerticalLine;
//@property (nonatomic, strong) UIView *bottomHorizontalLine;

- (void)loadData:(id)data AndIndexPath:(NSIndexPath *)indexPath;

@end
