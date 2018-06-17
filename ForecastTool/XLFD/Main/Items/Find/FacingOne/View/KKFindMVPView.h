//
//  KKFindMVPView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKFindMVPView;
@protocol KKFindMVPViewDelegate<NSObject>
- (void)didClickMvpPeople:(KKFindMVPView *)view index:(NSInteger)index;
- (void)didClickLookMore:(KKFindMVPView *)view;
@end
@interface KKFindMVPView : UIView
-(CGFloat)heightFowView;
-(void)buildWithData:(NSMutableArray *)modelArray;
@property(nonatomic,weak)id<KKFindMVPViewDelegate>delegate;
@end
