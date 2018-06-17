//
//  KKAccountDetailCell.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAccountDetailCell.h"

#import "KKAccountDetailModel.h"

@interface KKAccountDetailCell ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * totalMoneyLabel;

@property (nonatomic, strong) UILabel * addMoneyLabel;
@property (nonatomic, strong) UIImageView * arrowImageView;

@end

@implementation KKAccountDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    } return self;
}

- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 1, 0));
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_centerY).with.offset(-2);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.top.mas_equalTo(self.bgView.mas_centerY).with.offset(8);
        make.height.mas_equalTo(12);
    }];

    [self.bgView addSubview:self.addMoneyLabel];
    [self.addMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-38);
        make.bottom.mas_equalTo(self.bgView.mas_centerY).with.offset(-2);
        make.height.mas_equalTo(21);
    }];
    
    [self.bgView addSubview:self.totalMoneyLabel];
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-38);
        make.top.mas_equalTo(self.bgView.mas_centerY).with.offset(8);
        make.height.mas_equalTo(12);
    }];
    
    [self.bgView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.centerY.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(8, 14));
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = MCUIColorLighttingBrown;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - setter & getter
- (void)setModel:(KKAccountDetailModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.nameLabel.text = self.model.coin_change_name;
    self.timeLabel.text = self.model.time_created;
    

    NSString * moneyStr;
    UIColor * color;
    if ([[self.model.change_coin substringToIndex:1] isEqualToString:@"-"]) {
        color = MCUIColorMain;
        moneyStr  = [NSString stringWithFormat:@"%@元",self.model.change_coin];

    } else {
        color = MCUIColorGolden;
        moneyStr  = [NSString stringWithFormat:@"+%@元",self.model.change_coin];
    }
    self.addMoneyLabel.attributedText = [MCTool BSNSAttributedString_fontAndColorWithColorRange:NSMakeRange(0, moneyStr.length - 1) fontRange:NSMakeRange(0, moneyStr.length) color:color font:15 text:moneyStr];

    
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@%@元",@"余额: ",self.model.balance];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = MCMineTableCellBgColor;
    } return _bgView;
}


- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = MCFont(16);
        self.nameLabel.textColor = MCUIColorGray;
    } return _nameLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = MCFont(12);
        self.timeLabel.textColor = MCUIColorMiddleGray;
    } return _timeLabel;
}


- (UILabel *)addMoneyLabel {
    if (_addMoneyLabel == nil) {
        self.addMoneyLabel = [[UILabel alloc] init];
        self.addMoneyLabel.font = MCFont(21);
    } return _addMoneyLabel;
}


- (UILabel *)totalMoneyLabel {
    if (_totalMoneyLabel == nil) {
        self.totalMoneyLabel = [[UILabel alloc] init];
        self.totalMoneyLabel.font = MCFont(12);
        self.totalMoneyLabel.textColor = MCUIColorMiddleGray;
    } return _totalMoneyLabel;
}


- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        self.arrowImageView = [[UIImageView alloc] init];
        self.arrowImageView.image = [UIImage imageNamed:@"Reuse_arrow"];
    } return _arrowImageView;
}


@end
