//
//  BannerDetailTableViewCell.h
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol BannerDetailTableViewCellDelegate <NSObject>
@optional
-(void)BannerDetailTableViewCellButtonClick:(NSInteger)row andSection:(NSInteger)section;
@end
@interface BannerDetailTableViewCell : UITableViewCell
-(void)setDetailButton:(NSArray *)dataArray;
@property (nonatomic,assign,readonly)CGFloat rowHeight;
@property (nonatomic,weak)id<BannerDetailTableViewCellDelegate>delegate;
+(id)cellWithCellTableView:(UITableView *)tableView andIndex:(NSIndexPath*)indexPath;
@end
