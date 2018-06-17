//
//  KKFindTableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKFindModel.h"
@class KKFindTableViewCell;
@protocol KKFindTableViewCellDelegate<NSObject>

- (void)didSelectFollowAtIndex:(KKFindTableViewCell *)view atIndex:(NSInteger) index;
@end


@interface KKFindTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger row;
@property(nonatomic,weak)id<KKFindTableViewCellDelegate>delegate;
-(void)buildWithData:(KKFindModel *)model;
@end
