//
//  KKFindSortView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKFindSortView;
@protocol KKFindSortViewDelegate<NSObject>

- (void)didClickSortAll:(KKFindSortView *)view;
- (void)didClickSortBrokerage:(KKFindSortView *)view;
@end
@interface KKFindSortView : UIView
@property (nonatomic, strong) UIButton *allButton;
@property(nonatomic,weak)id<KKFindSortViewDelegate>delegate;
@end
