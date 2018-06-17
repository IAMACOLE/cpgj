//
//  ChaseLotteryViewController.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "DefineDataHeader.h"

@interface ChaseLotteryViewController : MCViewController
@property(nonatomic,copy)NSString *bet_number;
@property(nonatomic,copy)NSString *lottery_modes;
@property(nonatomic,copy)NSString *lottery_id;
@property(nonatomic,copy)NSString *wf_flag;
@property(nonatomic,assign)NSInteger selectAllCount;
@property(nonatomic,strong)NSString *bet_times;
@end
