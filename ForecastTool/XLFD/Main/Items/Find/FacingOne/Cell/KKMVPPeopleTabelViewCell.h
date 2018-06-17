//
//  KKFindMVPPeopleTabelViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMVPPeopleModel.h"
@class KKMVPPeopleTabelViewCell;
@protocol KKMVPPeopleTabelViewCellDelegate<NSObject>

- (void)didClickAttention:(KKMVPPeopleTabelViewCell *)view row:(NSInteger)row;
@end

@interface KKMVPPeopleTabelViewCell : UITableViewCell
@property (assign, nonatomic) NSInteger  row;
-(void)buildWithData:(KKMVPPeopleModel *)model;
@property(nonatomic,weak)id<KKMVPPeopleTabelViewCellDelegate>delegate;
@property(nonatomic,assign)BOOL isShowRanking;
@end
