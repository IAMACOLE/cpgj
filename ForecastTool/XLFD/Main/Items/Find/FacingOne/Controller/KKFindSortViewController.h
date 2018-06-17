//
//  KKFindSortViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/3/7.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCViewController.h"

@class KKFindSortViewController;
@protocol KKLotterySortViewDelegate<NSObject>

- (void)didClickLottery:(KKFindSortViewController *)view lottery_id:(NSString *)lottery_id lottery_title:(NSString *)lottery_title;
- (void)didClickAll:(KKFindSortViewController *)view;

@end


@interface KKFindSortViewController : MCViewController
@property(nonatomic,weak)id<KKLotterySortViewDelegate>delegate;
@end
