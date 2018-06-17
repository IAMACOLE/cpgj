//
//  KKInfoSegmentView.h
//  Kingkong_ios
//
//  Created by hello on 2018/3/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKInfoSegmentView;
@protocol KKInfoSegmentViewDelegate<NSObject>

- (void)didSelectFollowAtIndex:(KKInfoSegmentView *)view atIndex:(NSInteger) index;
@end

@interface KKInfoSegmentView : UIView
@property(nonatomic,weak)id<KKInfoSegmentViewDelegate>delegate;
@end
