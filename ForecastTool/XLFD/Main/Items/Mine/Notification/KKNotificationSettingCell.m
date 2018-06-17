//
//  KKNotificationSettingCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKNotificationSettingCell.h"
#import <AudioToolbox/AudioToolbox.h>

@interface KKNotificationSettingCell()

@end

@implementation KKNotificationSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUI];
    }
    return  self;
}

- (void)configureUI {
    self.backgroundColor = MCMineTableCellBgColor;

    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self).offset(kAdapterFontSize(20));
        make.centerY.equalTo(self);
    }];
	
    [self addSubview:self.customSwitch];
    [self.customSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(kAdapterFontSize(-20));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)remakeConstraints {
	[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self).offset(kAdapterFontSize(50));
		make.centerY.equalTo(self);
	}];
	self.separatorInset = UIEdgeInsetsMake(0, kAdapterFontSize(50), 0, 0);
}

- (void)restoreConstraints {
	[self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self).offset(kAdapterFontSize(20));
		make.centerY.equalTo(self);
	}];
	self.separatorInset = UIEdgeInsetsMake(0, kAdapterFontSize(15), 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UISwitch *)customSwitch {
    if (_customSwitch == nil) {
        _customSwitch = [[UISwitch alloc] init];
        _customSwitch.onTintColor = MCUIColorMain;
//        _customSwitch.tintColor = MCUIColorBrown;
        [_customSwitch addTarget:self action:@selector(switchOnOrOff:) forControlEvents:UIControlEventValueChanged];
    }
    return _customSwitch;
}

- (void)switchOnOrOff:(UISwitch *)sender {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self.delegate switchOnOrOff:sender];
}

@end
