//
//  BJ28TMBSCollectionViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/17.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCLotteryModel.h"
#import "DefineDataHeader.h"

@interface BJ28TMBSCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *countButton;
- (IBAction)countButtonClick:(id)sender;
@property(nonatomic,strong)LHCLotteryModel *model;
@end
