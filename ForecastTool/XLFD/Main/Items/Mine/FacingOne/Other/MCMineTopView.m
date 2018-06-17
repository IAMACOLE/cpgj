//
//  MCMineTopView.m
//  Kingkong_ios
//
//  Created by goulela on 17/3/30.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCMineTopView.h"

@interface MCMineTopView ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * arrowImageView;

@end

@implementation MCMineTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)setIconImage:(UIImage *)iconImage {
    self.iconImageView.image = iconImage;
}

- (void)topView_updateConstraintsWithIsLogin:(BOOL)isLogin {

    if (isLogin) {
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[MCTool BSGetUserinfo_imageUrl]] placeholderImage:[UIImage imageNamed:@"Reuse_icon"]];
        NSString *nickName = [MCTool BSGetUserinfo_nick_name];
        NSString *userId = [MCTool BSGetUserinfo_userId];
        NSString *content;
        if (nickName.length > 0) {
            content = [NSString stringWithFormat:@"%@\n%@", nickName, userId];
        } else {
            content = [NSString stringWithFormat:@"%@", userId];
        }
        NSMutableAttributedString *changeContent = [[NSMutableAttributedString alloc] initWithString:content];
        NSRange range1 = [[changeContent string] rangeOfString:[NSString stringWithFormat:@"%@", nickName]];
        NSRange range2 = [[changeContent string] rangeOfString:[NSString stringWithFormat:@"%@", userId]];
        [changeContent addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
        [changeContent addAttribute:NSFontAttributeName value: [UIFont systemFontOfSize:16] range:range2];
        [changeContent addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithRed:255/255.0 green:223/255.0 blue:27/255.0 alpha:1/1.0] range:range2];
        self.nameLabel.attributedText = changeContent;
    } else {
        self.iconImageView.image = [UIImage imageNamed:@"Reuse_icon"];
        self.nameLabel.text = @"登录 / 注册";
    }
}

- (void)iconImageViewClicked {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(MCMineTopViewMethod_changeIcon)]) {
        [self.customDelegate MCMineTopViewMethod_changeIcon];
    }
}

- (void)addSubviews {

    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.bgView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(12);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY).offset(0);
    }];

    [self.bgView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-15);
        make.centerY.mas_equalTo(self.bgView);
    }];
}


#pragma mark - setter & getter 
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = MCUIColorMain;
    } return _bgView;
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        self.iconImageView = [[UIImageView alloc] init];
//        self.iconImageView.image = [UIImage imageNamed:@"Reuse_icon"];
        self.iconImageView.backgroundColor = [UIColor redColor];
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.layer.cornerRadius = 35;
        self.iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClicked)];
        [self.iconImageView addGestureRecognizer:tap];
    } return _iconImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.text = @"登录/注册";
        self.nameLabel.numberOfLines = 0;
        [self.nameLabel sizeToFit];
    } return _nameLabel;
}

- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        self.arrowImageView = [[UIImageView alloc] init];
        self.arrowImageView.image = [UIImage imageNamed:@"Reuse_arrow-withe"];
    } return _arrowImageView;
}

@end
