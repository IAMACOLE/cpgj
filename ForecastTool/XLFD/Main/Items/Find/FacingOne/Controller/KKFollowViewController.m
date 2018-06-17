//
//  KKFollowViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFollowViewController.h"
#import "KKMyInvolvedFollowViewController.h"
#import "KKMySettingFollowViewController.h"
#import "KKFollowBetView.h"
@interface KKFollowViewController ()
@property (nonatomic, strong)  NSMutableArray *titleList;
@end

@implementation KKFollowViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self basicSetting];
   
    [self initUI];
    
    
    self.magicView.headerHidden = YES;
    self.magicView.headerHeight = 0;
    self.magicView.navigationHeight = 30;
    self.magicView.againstStatusBar = NO;
    self.magicView.itemWidth  = MCScreenWidth / 2;
    
    self.magicView.sliderColor = MCUIColorFromRGB(0xDA1C36);
    self.magicView.sliderHeight = 0.5;
    self.magicView.navigationColor = MCUIColorFromRGB(0xF2E9E4);
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.separatorColor = [UIColor clearColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    
    self.titleList = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.titleList addObject:@"我参与的跟单"];
    
    [self.titleList addObject:@"我发起的跟单"];
    
    [self.magicView reloadData];
    
}

#pragma mark 基本设置
- (void)basicSetting {
      self.title = @"我的跟单";
    [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(18, 18) target:self selected:@selector(leftItemClicked) image:@"Reuse_Back" isLeft:YES];
    //    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    //    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    //    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
-(void)initUI {
   
}

-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    
    return self.titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:MCUIColorFromRGB(0x6E6E6E) forState:UIControlStateNormal];
        [menuItem setTitleColor:MCUIColorMain forState:UIControlStateSelected];
        menuItem.titleLabel.font = MCFont(14);
        menuItem.backgroundColor = [UIColor clearColor];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    if ( pageIndex == 0) {
        static NSString *recomId = @"recom.Involved";
        KKMyInvolvedFollowViewController *viewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!viewController) {
            viewController = [[KKMyInvolvedFollowViewController alloc] init];
        }
        
        return viewController;
    }else{
        static NSString *recomId = @"recom.Setting";
        KKMySettingFollowViewController *viewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!viewController) {
            viewController = [[KKMySettingFollowViewController alloc] init];
        }
        
        return viewController;
    }

    
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidAppear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidDisappear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}


@end
