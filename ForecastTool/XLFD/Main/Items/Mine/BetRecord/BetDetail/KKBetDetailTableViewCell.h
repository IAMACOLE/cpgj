//
//  KKBetDetailTableViewCell.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/26.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKBetDetailModel.h"

@interface KKBetDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) KKBetDetailModel *model;
@property (nonatomic, strong) UILabel *promptLabel;

@end
