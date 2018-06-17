//
//  KKBetDetailHeaderView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBetDetailHeaderView.h"

@interface KKBetDetailHeaderView ()

@property (nonatomic, strong) UIView * bgView;



@end

@implementation KKBetDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 1, 0));
    }];
    
    [self.bgView addSubview:self.periodicalLabel];
    [self.periodicalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_centerY).with.offset(-5);
        make.height.mas_equalTo(12);
    }];
    
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.top.mas_equalTo(self.bgView.mas_centerY).with.offset(5);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.centerY.mas_equalTo(self.periodicalLabel);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.centerY.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(15);
    }];
}




- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = MCMineTableCellBgColor;
    } return _bgView;
}

- (UILabel *)periodicalLabel {
    if (_periodicalLabel == nil) {
        self.periodicalLabel = [[UILabel alloc] init];
        self.periodicalLabel.font = MCFont(12);
        self.periodicalLabel.textColor = MCUIColorMiddleGray;
    } return _periodicalLabel;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:17];
        self.nameLabel.textColor = MCUIColorGray;
    } return _nameLabel;
}


- (UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        self.moneyLabel = [[UILabel alloc] init];
        self.moneyLabel.font = MCFont(17);
        self.moneyLabel.textColor = MCUIColorMain;
    } return _moneyLabel;
}


- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.font = MCFont(12);
        self.statusLabel.textColor = MCUIColorMiddleGray;
    } return _statusLabel;
}



@end
