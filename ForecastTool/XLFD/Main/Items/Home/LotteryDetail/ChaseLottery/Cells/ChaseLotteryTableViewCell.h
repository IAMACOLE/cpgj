//
//  ChaseLotteryV2TableViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LockTimeModel.h"
#import "DefineDataHeader.h"

@protocol ChaseLotteryTableViewCellDelegate <NSObject>
@optional
-(void)stareEditing:(NSString *)str andStatus:(NSString *)status andSelectTextField:(NSInteger)selectTextFiel;
-(void)ChaseLotteryTableViewCellDelegate:(NSInteger)row;
-(void)changeTotalPrices;

@end


@interface ChaseLotteryTableViewCell : UITableViewCell


@property(nonatomic,strong)LockTimeModel *model;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,weak)id<ChaseLotteryTableViewCellDelegate>delegate;
@end

