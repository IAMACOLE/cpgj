//
//  LotteryDetailTabViewController.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "BaseLotteryDetailViewController.h"
#import "DefineDataHeader.h"

@interface LotteryDetailTabViewController : BaseLotteryDetailViewController
@property(nonatomic,copy)NSString *lottery_id;
@property(nonatomic,copy)NSString *wf_flag;
@property(nonatomic,copy)NSString *lottery_type;     
@end
