//
//  KKLotteryDetailScrollView.h
//  lotteryViewDemo
//
//  Created by hello on 2018/3/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLotteryDetailHeaderView.h"

@interface KKLotteryDetailScrollView : UIView

@property (nonatomic,copy)void(^didClickShowMoreDataBtnBlock)(void);
@property (nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame HeaderView:(KKLotteryDetailHeaderView  *)headerView  headerHeight:(CGFloat)headerHeight viewController:(UIViewController *)viewController subView:(UIScrollView *)subView;

-(void)updateFrameWithDataCount:(NSInteger)dataCount andRowHeight:(CGFloat)rowHeight;


-(void)scrollToChangeStatus;
@end
