//
//  KKBetDetailCell.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/10.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBetDetailCell.h"
#import "KKBetDetailModel.h"

@interface KKBetDetailCell ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * detailLabel;

@end

@implementation KKBetDetailCell

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
    
    
    [self.bgView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(10);
        make.right.mas_equalTo(self.detailLabel.mas_left).with.offset(-10);
        make.top.bottom.mas_equalTo(self.bgView);
    }];
    

}

#pragma mark - setter 

- (void)setModel:(KKBetDetailModel *)model {

    _model = model;
    self.nameLabel.text = self.model.name;
    self.detailLabel.text = self.model.detail;
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
        self.nameLabel.font = MCFont(15);
        self.nameLabel.textColor = MCUIColorGray;
        self.nameLabel.numberOfLines = 0;
    } return _nameLabel;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.font = MCFont(13);
        self.detailLabel.textColor = MCUIColorMiddleGray;
        self.detailLabel.textAlignment = NSTextAlignmentRight;
    } return _detailLabel;
}

@end
