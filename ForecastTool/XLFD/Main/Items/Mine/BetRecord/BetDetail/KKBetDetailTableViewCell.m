//
//  KKBetDetailTableViewCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/26.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKBetDetailTableViewCell.h"

@interface KKBetDetailTableViewCell()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation KKBetDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    self.backgroundColor = MCMineTableCellBgColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.promptLabel);
        make.left.equalTo(self.promptLabel.mas_right).offset(5);
        make.height.equalTo(self.promptLabel);
        make.width.equalTo(self.promptLabel.mas_height);
    }];
}

- (void)setModel:(KKBetDetailModel *)model {
    
    _model = model;
    self.promptLabel.text = self.model.name;
}

- (UILabel *)promptLabel {
    if (_promptLabel == nil) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = MCFont(15);
        _promptLabel.text = @"参与跟单成功后公布";
        [_promptLabel sizeToFit];
    }
    return _promptLabel;
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-find-lock"]];
    }
    return _imgView;
}

@end
