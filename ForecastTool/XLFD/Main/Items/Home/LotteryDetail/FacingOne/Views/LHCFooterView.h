//
//  LHCFooterView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol LHCFooterViewDelegate <NSObject>
@optional

-(void)bettingClick;
-(void)deleteClick;
-(void)chaseClick;

@end
@interface LHCFooterView : UIView
@property(nonatomic,weak)id<LHCFooterViewDelegate>delegate;

@property(nonatomic, strong)UIButton *timesLabel;
@end
