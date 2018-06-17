//
//  ChaseLotteryFooterView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/6.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol ChaseLotteryFooterViewDelegate <NSObject>
@optional
-(void)immediateClick;
-(void)cancelClick;
-(void)bettingBtnClick;
-(void)noteBtnClick;
-(void)selectBettingNumberClick:(BOOL)isSenderSelected;

@end


@interface ChaseLotteryFooterView : UIView
@property(nonatomic,strong)UIButton * stopChaseButton;
@property(nonatomic,copy)NSString *bettingNumberStr;
@property(nonatomic,strong)UIButton *makeMoneyButton;
//@property(nonatomic,strong)UIButton *chooseNumButton;
@property(nonatomic,weak)id<ChaseLotteryFooterViewDelegate>delegate;
-(void)setAllperiod:(NSString *)period andMoneyStr:(NSString *)money;


@end
