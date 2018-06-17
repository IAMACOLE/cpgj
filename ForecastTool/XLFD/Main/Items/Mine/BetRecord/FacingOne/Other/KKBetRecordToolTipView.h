//
//  KKBetRecordToolTipView.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKBetRecordToolTipViewDelegate <NSObject>

- (void)KKBetRecordToolTipViewMethod_closeView;
- (void)KKBetRecordToolTipViewMethod_selectedItem:(NSString *)statusStr andIndex:(NSInteger)index;
@end

@interface KKBetRecordToolTipView : UIView

@property (nonatomic, weak) id<KKBetRecordToolTipViewDelegate> customDelegate;
@property (nonatomic, assign) NSInteger index;
@end
