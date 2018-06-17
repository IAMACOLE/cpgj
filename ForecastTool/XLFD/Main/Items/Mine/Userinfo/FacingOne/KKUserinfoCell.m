//
//  KKUserinfoCell.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKUserinfoCell.h"
#import "KKUserinfoModel.h"

@interface KKUserinfoCell ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UIImageView * arrowImageView;
@property (nonatomic, strong) UILabel * warningLabel;

@end

@implementation KKUserinfoCell

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
    
    [self.bgView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(15);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(15);
        make.centerY.mas_equalTo(self.iconImageView).with.offset(0);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(8, 14));
    }];
    
    [self.bgView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.arrowImageView.mas_left).with.offset(-10);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.height.mas_equalTo(14);
    }];
    
    [self.bgView addSubview:self.warningLabel];
    [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
        make.centerY.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(12);
    }];
}

#pragma mark - setter & getter 

- (void)setModel:(KKUserinfoModel *)model {
    _model = model;
    self.iconImageView.image = self.model.icon;
    self.nameLabel.text = self.model.name;
    self.detailLabel.text = self.model.detail;
    
    self.warningLabel.text = self.model.isBinding;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor clearColor];
    } return _bgView;
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        self.iconImageView = [[UIImageView alloc] init];
    } return _iconImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = MCFont(16);
        self.nameLabel.textColor = MCUIColorBlack;
    } return _nameLabel;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.font = MCFont(14);
        self.detailLabel.textColor = MCUIColorBrown;
    } return _detailLabel;
}

- (UILabel *)warningLabel {
    if (_warningLabel == nil) {
        self.warningLabel = [[UILabel alloc] init];
        self.warningLabel.font = MCFont(12);
        self.warningLabel.textColor = MCUIColorMain;
    } return _warningLabel;
}

- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        self.arrowImageView = [[UIImageView alloc] init];
        self.arrowImageView.image = [UIImage imageNamed:@"Reuse_arrow"];
    } return _arrowImageView;
}


@end
