//
//  KKLotterySortButton.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSubButtonModel.h"
@interface KKLotterySortButton : UICollectionViewCell
-(void)buildWithData:(HomeSubButtonModel *)model index:(NSInteger)index;
@end
