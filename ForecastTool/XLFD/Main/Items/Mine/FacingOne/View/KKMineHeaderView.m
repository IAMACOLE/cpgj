//
//  KKMineHeaderView.m
//  Kingkong_ios
//
//  Created by 222 on 2018/2/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMineHeaderView.h"

@interface KKMineHeaderView ()

@property (nonatomic, strong) UIImageView *avatarImgView;
@property (nonatomic, strong) UIImageView *avatarBgImgView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIImageView *balanceBgView;
@property (nonatomic, strong) UILabel *balanceTitle;


@end

@implementation KKMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

#pragma mark - 修改状态
- (void)isLogin:(BOOL)loginStatus {
    if (loginStatus) {
        [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:[MCTool BSGetUserinfo_imageUrl]] placeholderImage:[UIImage imageNamed:@"avatar"]];
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
        [changeContent addAttribute:NSFontAttributeName value:MCFont(kAdapterFontSize(16)) range:range1];
        [changeContent addAttribute:NSFontAttributeName value:MCFont(kAdapterFontSize(14)) range:range2];
        [changeContent addAttribute:NSForegroundColorAttributeName value: MCUIColorWithRGB(118,118,118,1) range:range2];
        self.contentLabel.attributedText = changeContent;
        
        [self.avatarBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kAdapterWith(80), kAdapterWith(80)));
        }];
        
        [self.avatarImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarBgImgView);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kAdapterWith(60), kAdapterWith(60)));
        }];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarBgImgView.mas_bottom).offset(kAdapterWith(10));
            make.centerX.equalTo(self);
        }];
        
       
        self.balanceBgView.hidden = NO;
        [self addSubview:self.balanceBgView];
        [self.balanceBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(5);
            make.width.mas_equalTo(220);
        }];
        
        self.balanceContent.hidden = NO;
        [self addSubview:self.balanceContent];
        [self.balanceContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.balanceBgView).mas_offset(20);
            make.centerY.mas_equalTo(self.balanceBgView);
        }];
    } else {
        [self.balanceTitle removeFromSuperview];
        [self.balanceContent removeFromSuperview];
        self.contentLabel.text = @"登录/注册";
		self.avatarImgView.image = [UIImage imageNamed:@"avatar"];
        [self.avatarBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(35);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kAdapterWith(80), kAdapterWith(80)));
        }];
        [self.avatarImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatarBgImgView);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kAdapterWith(60), kAdapterWith(60)));
        }];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarBgImgView.mas_bottom).offset(kAdapterWith(10));
            make.centerX.equalTo(self);
        }];
        self.balanceBgView.hidden = YES;
        self.balanceContent.hidden = YES;
    }
}

#pragma mark - 点击事件
- (void)buttonClick {
    [self.delegate buttonClickToPushController];
}

#pragma mark - 配置UI
- (void)configureUI {
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.avatarBgImgView];
    [self addSubview:self.avatarImgView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIImageView *)avatarBgImgView{
    
    if(_avatarBgImgView == nil){
        _avatarBgImgView = [UIImageView new];
        _avatarBgImgView.image = [UIImage imageNamed:@"avatarBg"];
    }
    return _avatarBgImgView;
}

- (UIImageView *)avatarImgView {
    if (_avatarImgView == nil) {
        _avatarImgView = [[UIImageView alloc] init];
        _avatarImgView.image = [UIImage imageNamed:@"avatar"];
        _avatarImgView.layer.masksToBounds = YES;
        _avatarImgView.layer.cornerRadius = 30;
    }
    return _avatarImgView;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"登录/注册";
        _contentLabel.textColor = MCUIColorBlack;
        _contentLabel.font = MCFont(kAdapterFontSize(18));
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIImageView *)balanceBgView{
    if(_balanceBgView == nil){
        _balanceBgView = [UIImageView new];
        _balanceBgView.image = [UIImage imageNamed:@"balanceBg"];
    }
    return _balanceBgView;
}

- (UILabel *)balanceTitle {
    if (_balanceTitle == nil) {
        _balanceTitle = [[UILabel alloc] init];
        _balanceTitle.text = @"余额";
        _balanceTitle.textColor = MCUIColorBlack;
        _balanceTitle.font = MCFont(kAdapterFontSize(16));
        _balanceTitle.textAlignment = NSTextAlignmentCenter;
        [_balanceTitle sizeToFit];
    }
    return _balanceTitle;
}

- (UILabel *)balanceContent {
    if (_balanceContent == nil) {
        _balanceContent = [[UILabel alloc] init];
        _balanceContent.textColor = MCUIColorWhite;
        _balanceContent.font = MCFont(kAdapterFontSize(15));
        _balanceContent.textAlignment = NSTextAlignmentCenter;
        [_balanceContent sizeToFit];
    }
    return _balanceContent;
}
@end
