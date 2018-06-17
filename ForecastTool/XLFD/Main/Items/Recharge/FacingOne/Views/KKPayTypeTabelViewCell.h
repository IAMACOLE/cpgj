//
//  KKPayTypeTabelViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/3/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPayChannelModel.h"
@interface KKPayTypeTabelViewCell : UITableViewCell

-(void)buildWithData: (KKPayChannelModel *) model;
@end
