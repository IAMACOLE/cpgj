//
//  MCNavigationController.m
//  SchoolMakeUp
//
//  Created by goulela on 16/9/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCNavigationController.h"

@interface MCNavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation MCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条的背景颜色以及文字颜色和大小
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    //设置导航条文字 大小和颜色
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:19.0f],NSForegroundColorAttributeName :MCUIColorWhite}];
    
    navigationBar.translucent = NO;
    
    NSString *imgName = @"";
    if(KK_STATUS){
        imgName = @"ST_NavigationBarBG";
    }else{
        if ([[MCTool getDevice] rangeOfString:@"X"].location !=NSNotFound) {
            imgName = @"导航栏bjx";
        } else {
            imgName = @"导航栏bj";
        }
    }
    
    //设置背景图片
    [navigationBar setBackgroundImage:[UIImage imageNamed:imgName] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[MCTool MCImageWithColor:[UIColor clearColor]]];
    self.interactivePopGestureRecognizer.delegate = (id)self;

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2) {
            return NO;
        }
    }
    return YES;
}



@end
