//
//  KKAccountTypeViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/5/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKAccountTypeViewController : UIViewController
@property(nonatomic,copy)void (^determineButtonClick)(NSString *type,NSString *sub_type);


@end
