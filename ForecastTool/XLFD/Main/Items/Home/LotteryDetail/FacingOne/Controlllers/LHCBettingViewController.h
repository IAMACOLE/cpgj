//
//  LHCBettingViewController.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "DefineDataHeader.h"

@interface LHCBettingViewController : MCViewController
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *wf_pl;
@property(nonatomic,copy)NSString *lottery_id;
@property(nonatomic,copy)NSString *wf_flag;
@property(nonatomic,copy)NSString *lottery_qh;
@end
