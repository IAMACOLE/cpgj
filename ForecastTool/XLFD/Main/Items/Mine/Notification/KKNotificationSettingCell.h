//
//  KKNotificationSettingCell.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchOnOrOffDelegate
@required

- (void)switchOnOrOff:(UISwitch *)sender;

@end

@interface KKNotificationSettingCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UISwitch *customSwitch;
@property (nonatomic, weak)id<SwitchOnOrOffDelegate> delegate;

- (void)remakeConstraints;
- (void)restoreConstraints;

@end
