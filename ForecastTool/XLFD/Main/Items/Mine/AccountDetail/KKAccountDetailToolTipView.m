//
//  KKAccountDetailToolTipView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAccountDetailToolTipView.h"
#import "KKAccountDetailModel.h"

@interface KKAccountDetailToolTipView ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UIButton * confirmButton;

@property (nonatomic, strong) UILabel * time_topLabel;
@property (nonatomic, strong) UILabel * time_bottomLabel;

@property (nonatomic, strong) UILabel * type_topLabel;
@property (nonatomic, strong) UILabel * type_bottomLabel;

@property (nonatomic, strong) UILabel * changeMoney_topLabel;
@property (nonatomic, strong) UILabel * changeMoney_bottomLabel;

@property (nonatomic, strong) UILabel * totalMoney_topLabel;
@property (nonatomic, strong) UILabel * totalMoney_bottomLabel;


@property (nonatomic, strong) UILabel * remark_topLabel;
@property (nonatomic, strong) UILabel * remark_bottomLabel;

@end

@implementation KKAccountDetailToolTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)confirmButtonClicked {
    [self removeFromSuperview];
}


- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(305, 365));
    }];
    
    [self.whiteView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.whiteView).with.offset(0);
        make.bottom.mas_equalTo(self.whiteView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(285, 44));
    }];

    
    [self.whiteView addSubview:self.time_topLabel];
    [self.time_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.whiteView).with.offset(10);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.time_bottomLabel];
    [self.time_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.time_topLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
    }];

    
    //
    [self.whiteView addSubview:self.type_topLabel];
    [self.type_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.time_bottomLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.type_bottomLabel];
    [self.type_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.type_topLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
    }];


    //
    [self.whiteView addSubview:self.changeMoney_topLabel];
    [self.changeMoney_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.type_bottomLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.changeMoney_bottomLabel];
    [self.changeMoney_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.changeMoney_topLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
    }];

    
    //
    [self.whiteView addSubview:self.totalMoney_topLabel];
    [self.totalMoney_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.changeMoney_bottomLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.totalMoney_bottomLabel];
    [self.totalMoney_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.totalMoney_topLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
    }];

    //
    [self.whiteView addSubview:self.remark_topLabel];
    [self.remark_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.totalMoney_bottomLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.remark_bottomLabel];
    [self.remark_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.right.mas_equalTo(self.whiteView).with.offset(-10);
        make.top.mas_equalTo(self.remark_topLabel.mas_bottom).with.offset(10);
    }];
}


#pragma mark - setter & getter

- (void)setModel:(KKAccountDetailModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.time_bottomLabel.text = self.model.time_created;

    self.type_bottomLabel.text = self.model.coin_change_name;
    
    
    NSString * moneyStr;
    if ([[self.model.change_coin substringToIndex:1] isEqualToString:@"-"]) {
        moneyStr  = [NSString stringWithFormat:@"%@元",self.model.change_coin];
        
    } else {
        moneyStr  = [NSString stringWithFormat:@"+%@元",self.model.change_coin];
    }

    self.changeMoney_bottomLabel.text = moneyStr;
    
    
    
    double balance = [self.model.balance doubleValue];
    self.totalMoney_bottomLabel.text = [NSString stringWithFormat:@"%.2f元",balance];
    self.remark_bottomLabel.text = self.model.remark;

    CGFloat height = [self.model.remark boundingRectWithSize:CGSizeMake(285, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: MCFont(15)} context:nil].size.height;
    
    
    [self.remark_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.remark_topLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(height + 10);
    }];
    
    
    [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(305, 350 + height + 10));
    }];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        self.whiteView = [[UIView alloc] init];
        self.whiteView.backgroundColor = MCMineTableCellBgColor;
        self.whiteView.layer.masksToBounds = YES;
        self.whiteView.layer.cornerRadius = 7;
    } return _whiteView;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.confirmButton.backgroundColor = MCUIColorMain;
        self.confirmButton.layer.masksToBounds = YES;
        self.confirmButton.layer.cornerRadius = 6;
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}

- (UILabel *)time_topLabel {
    if (_time_topLabel == nil) {
        self.time_topLabel = [[UILabel alloc] init];
        self.time_topLabel.font = MCFont(16);
        self.time_topLabel.textColor = MCUIColorBlack;
        self.time_topLabel.text = @"时间";
    } return _time_topLabel;
}

- (UILabel *)time_bottomLabel {
    if (_time_bottomLabel == nil) {
        self.time_bottomLabel = [[UILabel alloc] init];
        self.time_bottomLabel.font = MCFont(15);
        self.time_bottomLabel.textColor = MCUIColorMain;
    } return _time_bottomLabel;
}

- (UILabel *)type_topLabel {
    if (_type_topLabel == nil) {
        self.type_topLabel = [[UILabel alloc] init];
        self.type_topLabel.font = MCFont(16);
        self.type_topLabel.textColor = MCUIColorBlack;
        self.type_topLabel.text = @"类型";
    } return _type_topLabel;
}

- (UILabel *)type_bottomLabel {
    if (_type_bottomLabel == nil) {
        self.type_bottomLabel = [[UILabel alloc] init];
        self.type_bottomLabel.font = MCFont(15);
        self.type_bottomLabel.textColor = MCUIColorMain;
    } return _type_bottomLabel;
}


- (UILabel *)changeMoney_topLabel {
    if (_changeMoney_topLabel == nil) {
        self.changeMoney_topLabel = [[UILabel alloc] init];
        self.changeMoney_topLabel.font = MCFont(16);
        self.changeMoney_topLabel.textColor = MCUIColorBlack;
        self.changeMoney_topLabel.text = @"变动金额";
    } return _changeMoney_topLabel;
}

- (UILabel *)changeMoney_bottomLabel {
    if (_changeMoney_bottomLabel == nil) {
        self.changeMoney_bottomLabel = [[UILabel alloc] init];
        self.changeMoney_bottomLabel.font = MCFont(15);
        self.changeMoney_bottomLabel.textColor = MCUIColorMain;
    } return _changeMoney_bottomLabel;
}


- (UILabel *)totalMoney_topLabel {
    if (_totalMoney_topLabel == nil) {
        self.totalMoney_topLabel = [[UILabel alloc] init];
        self.totalMoney_topLabel.font = MCFont(16);
        self.totalMoney_topLabel.textColor = MCUIColorBlack;
        self.totalMoney_topLabel.text = @"变动后的余额";
    } return _totalMoney_topLabel;
}

- (UILabel *)totalMoney_bottomLabel {
    if (_totalMoney_bottomLabel == nil) {
        self.totalMoney_bottomLabel = [[UILabel alloc] init];
        self.totalMoney_bottomLabel.font = MCFont(15);
        self.totalMoney_bottomLabel.textColor = MCUIColorMain;
    } return _totalMoney_bottomLabel;
}


- (UILabel *)remark_topLabel {
    if (_remark_topLabel == nil) {
        self.remark_topLabel = [[UILabel alloc] init];
        self.remark_topLabel.font = MCFont(16);
        self.remark_topLabel.textColor = MCUIColorBlack;
        self.remark_topLabel.text = @"备注";
    } return _remark_topLabel;
}

- (UILabel *)remark_bottomLabel {
    if (_remark_bottomLabel == nil) {
        self.remark_bottomLabel = [[UILabel alloc] init];
        self.remark_bottomLabel.font = MCFont(14);
        self.remark_bottomLabel.textColor = MCUIColorMain;
        self.remark_bottomLabel.numberOfLines = 0;
    } return _remark_bottomLabel;
}



@end
