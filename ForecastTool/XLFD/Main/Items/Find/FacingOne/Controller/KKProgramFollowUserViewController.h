//
//  KKProgramFollowUserViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "KKFindModel.h"
@interface KKProgramFollowUserViewController : MCViewController
@property(nonatomic,strong)NSMutableArray *gdUserModelArray;
@property(nonatomic,strong)KKFindModel *findModel;
@property (nonatomic, strong)  UITableView *tableView;
@property (assign, nonatomic)  NSInteger page;
@property (assign, nonatomic)  NSInteger pageSize;
@end
