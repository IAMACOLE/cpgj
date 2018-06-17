//
//  KKDrawMoney_bindingView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/14.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKDrawMoney_bindingView.h"

@interface KKDrawMoney_bindingView ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UIImageView * bigImageView;
@property (nonatomic, strong) UILabel * promptLabel;


@end

@implementation KKDrawMoney_bindingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)addSubviews {

    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(305, 290 + 50));
    }];
    
    [self.whiteView addSubview:self.bigImageView];
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(self.whiteView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(144, 131));
    }];
    
    [self.whiteView addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.whiteView);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.bigImageView.mas_bottom).with.offset(25);
    }];
    
    [self.whiteView addSubview:self.bindingButton];
    [self.bindingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.right.mas_equalTo(self.whiteView).with.offset(-10);
        make.top.mas_equalTo(self.promptLabel.mas_bottom).with.offset(45);
        make.height.mas_equalTo(44);
    }];
    
    [self.whiteView addSubview:self.exitButton];
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(self.bindingButton.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
}


#pragma mark - setter & getter 
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        self.whiteView = [[UIView alloc] init];
        self.whiteView.backgroundColor = MCUIColorWhite;
        self.whiteView.layer.masksToBounds = YES;
        self.whiteView.layer.cornerRadius = 5;
    } return _whiteView;
}

- (UIImageView *)bigImageView {
    if (_bigImageView == nil) {
        self.bigImageView = [[UIImageView alloc] init];
        self.bigImageView.image = [UIImage imageNamed:@"Mine_darwMoney_binding"]; // 288 262
    } return _bigImageView;
}
- (UILabel *)promptLabel {
    if (_promptLabel == nil) {
        self.promptLabel = [[UILabel alloc] init];
        self.promptLabel.textColor = MCUIColorMiddleGray;
        self.promptLabel.font = MCFont(16);
        self.promptLabel.text = @"您还未绑定银行卡,先去绑定吧!";
    } return _promptLabel;
}

- (UIButton *)bindingButton {
    if (_bindingButton == nil) {
        self.bindingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bindingButton.backgroundColor = MCUIColorMain;
        self.bindingButton.layer.masksToBounds = YES;
        self.bindingButton.layer.cornerRadius = 5;
        self.bindingButton.titleLabel.font = MCFont(17);
        [self.bindingButton setTitle:@"绑定" forState:UIControlStateNormal];
        [self.bindingButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
    } return _bindingButton;
}

- (UIButton *)exitButton {
    if (_exitButton == nil) {
        self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exitButton.titleLabel.font = MCFont(17);
        [self.exitButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.exitButton setTitle:@"取消" forState:UIControlStateNormal];
    } return _exitButton;
}

@end
