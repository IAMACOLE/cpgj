//
//  KeyBoardView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol KeyBoardViewDelegate <NSObject>
@optional
-(void)KeyBoardViewSureClick:(NSString *)str;
@end
@interface KeyBoardView : UIView
@property(nonatomic,weak)id<KeyBoardViewDelegate>delegate;
@property(nonatomic,strong) UITextField *countTextField;
-(void)setTimesOrPreiod:(NSString *)str;//设置倍或期
@end
