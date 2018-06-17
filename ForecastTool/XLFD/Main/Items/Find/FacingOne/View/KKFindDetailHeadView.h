//
//  KKFindDetailHeadView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/17.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMVPPeopleModel.h"

@class KKFindDetailHeadView;
@protocol KKFindDetailHeadViewDelegate<NSObject>
- (void)didClickAvatarView:(KKFindDetailHeadView *)view;
- (void)didClickAttention:(KKFindDetailHeadView *)view;
@end

@interface KKFindDetailHeadView : UIView
@property(nonatomic,weak)id<KKFindDetailHeadViewDelegate>delegate;
-(void)buildWithData:(KKMVPPeopleModel *)model;
@end
