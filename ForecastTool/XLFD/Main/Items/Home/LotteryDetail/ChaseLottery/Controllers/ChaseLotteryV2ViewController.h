//
//  ChaseLotteryV2ViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "DefineDataHeader.h"

@interface ChaseLotteryV2ViewController : MCViewController
@property(nonatomic,copy)NSString *wf_flag;
@property(nonatomic,copy)NSString *bet_number;
@property(nonatomic,copy)NSString *bet_times;
@property(nonatomic,copy)NSString *lottery_modes;
@property(nonatomic,copy)NSString *lottery_id;
@property(nonatomic,assign)NSInteger selectAllCount;
@property(nonatomic,assign)NSInteger commission;
@property(nonatomic,assign)NSInteger back_rate;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)BOOL isUncoverPublish;

@end
