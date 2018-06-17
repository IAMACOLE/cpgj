//
//  KKSelectedBank_popUpBoxView.h
//  Kingkong_ios
//
//  Created by goulela on 17/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKSelectedBankView_popUpBoxDelegate <NSObject>

- (void)KKSelectedPickerViewRowShowIndex:(NSInteger)index;

@end
@interface KKSelectedBank_popUpBoxView : UIView

@property (nonatomic, weak) id<KKSelectedBankView_popUpBoxDelegate> customDelegate;

@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) UIPickerView * pickerView;

- (void)setPickerViewDataWith:(NSArray *)array;

@end
