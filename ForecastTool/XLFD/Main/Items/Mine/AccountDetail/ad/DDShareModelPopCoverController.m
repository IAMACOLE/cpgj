//
//  DDShareModelPopCoverController.m
//  Kingkong_ios
//
//   Created by hello on 2018/5/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "DDShareModelPopCoverController.h"

@interface DDShareModelPopCoverController()

@property (nonatomic , weak) UIButton *dismissButton;

@end

@implementation DDShareModelPopCoverController

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    return  [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}

-(void)containerViewWillLayoutSubviews{
    self.presentedView.frame = CGRectMake(0, MCScreenHeight * 0.6, MCScreenWidth , MCScreenHeight * 0.4);
}

- (void)presentationTransitionWillBegin{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    dismissButton.frame = self.containerView.bounds;
    [self.containerView addSubview:dismissButton];
    [dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)dismissButtonClicked{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
