//
//  KKSSCBaseCollectionViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/2/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSSCBaseCollectionViewCell : UICollectionViewCell

@property(nonatomic,copy)void(^didSelectedCellBlock)();
@property(nonatomic,strong)UIButton *btn;

@end
