//
//  KKMessageDetailsViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/4/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "KKNotificationModel.h"

@interface KKMessageDetailsViewController : MCViewController
@property(nonatomic,strong)KKNotificationModel *model;
@property(nonatomic,copy)void (^deleteItemClick)(KKNotificationModel *model) ;
@property(nonatomic,copy)void (^readItemClick)(KKNotificationModel *model);
@end
