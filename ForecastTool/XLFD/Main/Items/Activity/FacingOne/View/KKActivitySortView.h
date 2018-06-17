//
//  KKActivitySortView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class KKActivitySortView;
@protocol KKActivitySortViewDelegate<NSObject>

- (void)didSelectSortAtIndex:(KKActivitySortView *)view atIndex:(NSInteger) index;
@end
@interface KKActivitySortView : UIView
@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic,weak)id<KKActivitySortViewDelegate>delegate;
-(void)selectIndex:(NSInteger)index;
@end
