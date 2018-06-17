//
//  GameSelectViewController.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "GameSelectDetailModel.h"
#import "DefineDataHeader.h"

@interface GameSelectViewController : MCViewController
@property(nonatomic,copy)NSString *lottery_id;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,copy)void (^selectItemClick)(GameSelectDetailModel *) ;
@end
