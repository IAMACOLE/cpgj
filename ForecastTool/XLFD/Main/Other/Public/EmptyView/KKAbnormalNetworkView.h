//
//  KKAbnormalNetworkView.h
//  Kingkong_ios
//
//  Created by goulela on 2017/6/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKAbnormalNetworkViewDelegate <NSObject>

- (void)KKAbnormalNetworkView_hitReloadButtonMethod;

@end

@interface KKAbnormalNetworkView : UIView
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, weak) id<KKAbnormalNetworkViewDelegate> customDelegate;

@end
