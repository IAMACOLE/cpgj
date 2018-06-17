//
//  LotteryDetailBJ28ViewController.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/17.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCViewController.h"
#import "DefineDataHeader.h"
#import "BaseLotteryDetailViewController.h"
@interface LotteryDetailBJ28ViewController : BaseLotteryDetailViewController
@property(nonatomic,copy)NSString *lottery_id;
@property(nonatomic,copy)NSString *wf_flag;
@property(nonatomic,copy)NSString *lottery_type;
@property(nonatomic,assign)BOOL isAddOtherWager;

@end
