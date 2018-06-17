//
//  KKTrend_roundCell.h
//  Kingkong_ios
//
//  Created by goulela on 2017/6/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKTrendModel;

@protocol KKTrend_roundCellDelegate <NSObject>

- (void)KKTrend_roundCell_jumpWithIndex:(NSInteger)index;

@end

@interface KKTrend_roundCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) KKTrendModel * model;
@property (nonatomic, weak) id<KKTrend_roundCellDelegate> customDelegate;
@property (nonatomic, assign) BOOL isHideArrowView;
@end
