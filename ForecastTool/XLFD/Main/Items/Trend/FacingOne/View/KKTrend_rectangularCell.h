//
//  KKTrend_rectangularCell.h
//  Kingkong_ios
//
//  Created by goulela on 2017/6/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKTrendModel;

@protocol KKTrend_rectangularCellDelegate <NSObject>

- (void)KKTrend_rectangularCell_jumpWithIndex:(NSInteger)index;

@end


@interface KKTrend_rectangularCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) KKTrendModel * model;
@property (nonatomic, weak) id<KKTrend_rectangularCellDelegate> customDelegate;
@property (nonatomic, assign) BOOL isHideArrowView;

@end
