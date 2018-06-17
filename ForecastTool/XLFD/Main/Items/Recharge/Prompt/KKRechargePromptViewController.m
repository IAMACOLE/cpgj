//
//  KKRechargePromptViewController.m
//  Kingkong_ios
//
//  Created by goulela on 2017/6/20.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKRechargePromptViewController.h"

#import "KKRechargeRecordViewController.h"

@interface KKRechargePromptViewController ()

@property (nonatomic, strong) UIImageView * promptImageView;
@property (nonatomic, strong) UILabel * promptLabel;
@property (nonatomic, strong) UIButton * continueButton;
@property (nonatomic, strong) UIButton * lookButton;

@end

@implementation KKRechargePromptViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}

#pragma mark - 系统代理

#pragma mark - 点击事件
- (void)continueButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lookButtonClicked {
    KKRechargeRecordViewController * record = [[KKRechargeRecordViewController alloc] init];
    [self.navigationController pushViewController:record animated:YES];
}
#pragma mark - 网络请求
- (void)sendNetWorking {
    
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"充值提示";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.promptImageView];
    [self.promptImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(209, 109));
    }];
    
    [self.view addSubview:self.promptLabel];
    [self.promptLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(20);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.top.mas_equalTo(self.promptImageView.mas_bottom).with.offset(50);
    }];
    
    
    [self.view addSubview:self.continueButton];
    [self.continueButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-10);
        make.top.mas_equalTo(self.promptLabel.mas_bottom).with.offset(50);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.lookButton];
    [self.lookButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-10);
        make.top.mas_equalTo(self.continueButton.mas_bottom).with.offset(10);
        make.height.mas_equalTo(44);
    }];

}


#pragma mark - setter & getter
- (UIImageView *)promptImageView {
    if (_promptImageView == nil) {
        self.promptImageView = [[UIImageView alloc] init];
        self.promptImageView.image = [UIImage imageNamed:@"Reuse_prompt"];
    } return _promptImageView;
}

- (UILabel *)promptLabel {
    if (_promptLabel == nil) {
        self.promptLabel = [[UILabel alloc] init];
        self.promptLabel.text = @"当您充值成功后,请耐心等待几分钟,进入「充值记录」查看充值到账情况";
        self.promptLabel.font = MCFont(16);
        self.promptLabel.textColor = MCUIColorBlack;
        self.promptLabel.numberOfLines = 0;
        self.promptLabel.textAlignment = NSTextAlignmentCenter;
    } return _promptLabel;
}

- (UIButton *)continueButton {
    if (_continueButton == nil) {
        self.continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.continueButton.backgroundColor = MCUIColorMain;
        self.continueButton.layer.cornerRadius = 5;
        self.continueButton.layer.masksToBounds = YES;
        self.continueButton.titleLabel.font = MCFont(14);
        [self.continueButton setTitle:@"继续充值" forState:UIControlStateNormal];
        [self.continueButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.continueButton addTarget:self action:@selector(continueButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _continueButton;
}

- (UIButton *)lookButton {
    if (_lookButton == nil) {
        self.lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.lookButton.backgroundColor = MCUIColorFromRGB(0xaa4773);
        self.lookButton.layer.cornerRadius = 5;
        self.lookButton.layer.masksToBounds = YES;
        self.lookButton.titleLabel.font = MCFont(14);
        [self.lookButton setTitle:@"充值记录" forState:UIControlStateNormal];
        [self.lookButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.lookButton addTarget:self action:@selector(lookButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _lookButton;
}

@end
