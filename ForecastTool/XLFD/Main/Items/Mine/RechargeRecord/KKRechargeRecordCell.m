//
//  KKRechargeRecordCell.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKRechargeRecordCell.h"

#import "KKAccountDetailModel.h"

@interface KKRechargeRecordCell ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UILabel * statusLabel;

@end

@implementation KKRechargeRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    } return self;
}

- (void)addSubviews {
    
    self.backgroundColor = MCUIColorLighttingBrown;
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 2, 0));
    }];
    
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.top.mas_equalTo(self.bgView).with.offset(17);
        make.height.mas_equalTo(12);
    }];
    
    
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.bottom.mas_equalTo(self.bgView).with.offset(-17);
        make.height.mas_equalTo(16);
    }];
    
    
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(1, 14));
    }];
    
    [self.bgView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.lineView.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(15);
    }];
    
    [self.bgView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.centerY.mas_equalTo(self.bgView);
        make.height.mas_equalTo(16);
    }];
}

#pragma mark - setter & getter
- (void)setModel:(KKAccountDetailModel *)model {
    if (_model != model) {
        _model = model;
    }

    self.nameLabel.text = self.model.coin_change_name;
    self.timeLabel.text = self.model.time_created;
    self.statusLabel.text = self.model.flag_name;
    
    
    NSInteger flag = [self.model.flag integerValue];
    if (flag == 1) {
        self.statusLabel.textColor = MCUIColorGolden;
    } else if (flag == 2) {
        self.statusLabel.textColor = MCUIColorMain;
    } else if (flag == 3) {
        self.statusLabel.textColor = MCUIColorMain;
    } else {
        self.statusLabel.textColor = MCUIColorBlack;
    }
    
    NSString * moneyStr = [NSString stringWithFormat:@"+%@元",self.model.change_coin];
    self.moneyLabel.attributedText = [MCTool BSNSAttributedString_fontAndColorWithColorRange:NSMakeRange(0, moneyStr.length - 1) fontRange:NSMakeRange(0, moneyStr.length) color:MCUIColorGolden font:15 text:moneyStr];
}


- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = MCMineTableCellBgColor;
    } return _bgView;
}


- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = MCFont(12);
        self.timeLabel.textColor = MCUIColorMiddleGray;
    } return _timeLabel;
}


- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = MCFont(16);
        self.nameLabel.textColor = MCUIColorGray;
    } return _nameLabel;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = MCUIColorLighttingBrown;
    } return _lineView;
}

- (UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        self.moneyLabel = [[UILabel alloc] init];
        self.moneyLabel.font = MCFont(15);
        self.moneyLabel.textColor = MCUIColorBlack;
    } return _moneyLabel;
}


- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.font = MCFont(16);
    } return _statusLabel;
}




@end

