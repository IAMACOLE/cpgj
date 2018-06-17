//
//  KKMessageDetailsView.h
//  Kingkong_ios
//
//  Created by hello on 2018/4/26.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNotificationModel.h"

@interface KKMessageDetailsView : UIView
@property(nonatomic,strong)KKNotificationModel *model;
@property(nonatomic,copy)void (^deleteItemClick)(KKNotificationModel *model) ;
@property(nonatomic,copy)void (^readItemClick)(KKNotificationModel *model);
@property(nonatomic,copy)void (^loginClick)(void);
@end
