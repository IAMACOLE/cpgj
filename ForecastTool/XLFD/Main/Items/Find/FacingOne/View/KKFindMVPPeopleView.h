//
//  KKFindMVPPeopleView.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMVPPeopleModel.h"
@interface KKFindMVPPeopleView : UIView
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIButton *bgButton;
-(void)buildWithData:(KKMVPPeopleModel *)model;
@end
