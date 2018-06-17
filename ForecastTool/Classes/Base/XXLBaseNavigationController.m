//
//  BaseNavigationController.m
//  baseProgram
//
//  Created by iMac on 2017/7/24.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "XXLBaseNavigationController.h"

@interface XXLBaseNavigationController ()

@end

@implementation XXLBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.barTintColor = GlobalOrangeColor;
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.translucent = NO;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
