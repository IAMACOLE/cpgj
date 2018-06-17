//
//  KKActivityHeadView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKActivityHeadView;
@protocol KKActivityHeadViewDelegate<NSObject>

- (void)didSelectCategoryAtIndex:(KKActivityHeadView *)view atIndex:(NSInteger) index;
@end

@interface KKActivityHeadView : UIView
@property(nonatomic,weak)id<KKActivityHeadViewDelegate>delegate;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *titleArray;
- (instancetype)initWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray;
-(void)selectIndex:(NSInteger)index;
@end


