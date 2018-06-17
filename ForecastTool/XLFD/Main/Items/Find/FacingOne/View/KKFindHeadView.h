//
//  KKFindHeadView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKFindHeadView;
@protocol KKFindHeadViewDelegate<NSObject>

- (void)didClickMpv:(KKFindHeadView *)view;
- (void)didClickLottery:(KKFindHeadView *)view;
- (void)didClickFollow:(KKFindHeadView *)view;
@end

@interface KKFindHeadView : UIView
-(CGFloat)heightFowView;
@property(nonatomic,weak)id<KKFindHeadViewDelegate>delegate;
@end
