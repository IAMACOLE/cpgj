//
//  AppDelegate.h
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)BOOL allowRotation;
@property(nonatomic,assign)BOOL isSignIn;

+(AppDelegate *)sharedApplicationDelegate;


@end

