//
//  KKProgramDetailViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "KKProgramDetailHaedView.h"
@interface KKProgramDetailViewController : MCViewController
@property(nonatomic,strong)NSMutableArray *gdDetailModelArray;

@property (nonatomic, strong)  UITableView *tableView;
@end
