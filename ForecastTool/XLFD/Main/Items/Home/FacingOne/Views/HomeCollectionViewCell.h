//
//  HomeCollectionViewCell.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/3.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

#define NOTIFICATION_TIME @"notificationTime"

@interface HomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)NSString *lottery_id;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, assign) BOOL isHiddened;
@property (nonatomic, strong) UIView *rightVerticalLine;
@property (nonatomic, strong) UIView *bottomHorizontalLine;

- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath;
@end
