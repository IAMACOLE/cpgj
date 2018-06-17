//
//  FootView.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol FootViewDelegate <NSObject>
@optional
-(void)stareEditing:(NSString *)str;
-(void)chaseClick;
-(void)bettingClick;
-(void)deleteClick;
-(void)lookBonusClick;
-(void)earnCommissionsClick;
-(void)moneyModelStareEditing;
@end

@interface FootView : UIView
@property(nonatomic, strong)UILabel *bonusLabel;
@property(nonatomic,strong)UILabel *balanceLabel;
@property(nonatomic,strong)UITextField *timesTextField;
@property(nonatomic,strong)UILabel *bettingMoneyLabel;
@property(nonatomic,strong)UITextField * modelTextField;
@property(nonatomic,strong)UIButton *makeMoneyButton;
@property(nonatomic,weak)id<FootViewDelegate>delegate;

@end
