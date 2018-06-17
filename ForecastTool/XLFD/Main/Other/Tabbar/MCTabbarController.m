//
//  MCTabbarController.m
//  SchoolMakeUp
//
//  Created by goulela on 16/9/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCTabbarController.h"
#import "HomeViewController.h"
#import "KKActivityViewController.h"
#import "KKRechargeViewController.h"
#import "KKTrendViewController.h"
#import "KKNewMineViewController.h"
#import "KKFindViewController.h"

#import "MCNavigationController.h"

#import "UIImage+image.h"


@interface MCTabbarController ()<UITabBarControllerDelegate>

@property(nonatomic,strong)MCNavigationController *findNav;
@end

@implementation MCTabbarController

//修改本类下的TabbarItem的字体颜色
+ (void)initialize
{
    //获取当前类下的UITabbarItem

    UITabBarItem * item = [UITabBarItem appearance];

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    dic[NSForegroundColorAttributeName] =  KK_STATUS ? STUIColorBlue : MCUIColorGolden;
    
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.delegate = self;
    self.tabBar.backgroundImage = [MCTool MCImageWithColor:[UIColor whiteColor]];
    
    //添加所有自控制器
    [self addAllChildViewController];
    
}

- (void)addAllChildViewController
{
    // 主页
    //    AnotherVersionKKHomeViewController *home = [[AnotherVersionKKHomeViewController alloc] init];
    //    KKHomeViewController *home = [[KKHomeViewController alloc] init];
    HomeViewController *home = [[HomeViewController alloc] init];
    home.isFirstVC = YES;
    MCNavigationController * homeNav = [[MCNavigationController alloc] initWithRootViewController:home];
    [self setUpOneChildViewController:homeNav image:@"Tabbar_home" selectedImage:@"Tabbar_home_sel" andTitle:@" 大厅"];
    
    //
    KKRechargeViewController * recharege = [[KKRechargeViewController alloc] init];
    recharege.isFirstVC = YES;
    MCNavigationController * recharegeNav = [[MCNavigationController alloc] initWithRootViewController:recharege];
    [self setUpOneChildViewController:recharegeNav image:@"Tabbar_recharge" selectedImage:@"Tabbar_recharge_sel" andTitle:@" 充值"];
    
    //
    KKFindViewController *findVC = [[KKFindViewController alloc] init];
    findVC.isFirstVC = YES;
    self.findNav = [[MCNavigationController alloc] initWithRootViewController:findVC];
    [self setUpOneChildViewController:self.findNav image:@"Tabbar_find" selectedImage:@"Tabbar_find_sel" andTitle:@" 发现"];
    
    if([[MCTool BSGetObjectForKey:BSActivityViewControllerState] integerValue]){
        KKActivityViewController * activity = [[KKActivityViewController alloc] init];
        MCNavigationController * activityNav = [[MCNavigationController alloc] initWithRootViewController:activity];
        [self setUpOneChildViewController:activityNav image:@"Tabbar_activity" selectedImage:@"Tabbar_activity_sel" andTitle:@" 活动"];
    }
    
    // 我的
    //    KKMineViewController * mine = [[KKMineViewController alloc] init];
    KKNewMineViewController *mine = [[KKNewMineViewController alloc] init];
    mine.isFirstVC = YES;
    MCNavigationController * mineNav = [[MCNavigationController alloc] initWithRootViewController:mine];
    [self setUpOneChildViewController:mineNav image:@"Tabbar_mine" selectedImage:@"Tabbar_mine_sel" andTitle:@" 我的"];
    

}

#pragma mark 添加一个子控制器
- (void)setUpOneChildViewController:(UINavigationController *)nav image:(NSString *)image selectedImage:(NSString *)selectedImage andTitle:(NSString *)title
{
    nav.view.backgroundColor = [UIColor whiteColor];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageWithOriginalName:image];
    
    //添加一张原始的没有被渲染的图片.
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:selectedImage];
    [self addChildViewController:nav];
}



@end
