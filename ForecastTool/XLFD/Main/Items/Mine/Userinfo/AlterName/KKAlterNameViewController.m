//
//  KKAlterNameViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAlterNameViewController.h"
#import "KKAlterUserinfoView.h"

@interface KKAlterNameViewController ()

@property (nonatomic, strong) KKAlterUserinfoView * alter_oneView;
@property (nonatomic, strong) UIButton            * confirmButton;

@end

@implementation KKAlterNameViewController

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
- (void)confirmButtonClicked {

    if (self.alter_oneView.textField.text.length == 0) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请填写真实姓名" cancle:^{
        }];
        return;
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"真实姓名";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.alter_oneView];
    [self.alter_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-10);
        make.bottom.mas_equalTo(self.view).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
}


#pragma mark - setter & getter

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.backgroundColor = MCUIColorMain;
        self.confirmButton.layer.masksToBounds = YES;
        self.confirmButton.layer.cornerRadius = 5;
        self.confirmButton.titleLabel.font = MCFont(17);
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}

- (KKAlterUserinfoView *)alter_oneView {
    if (_alter_oneView == nil) {
        self.alter_oneView = [[KKAlterUserinfoView alloc] init];
        self.alter_oneView.backgroundColor = MCUIColorWhite;
        self.alter_oneView.titleLabel.text = @"真实姓名";
        self.alter_oneView.textField.placeholder = @"请输入您的真实姓名";
    } return _alter_oneView;
}
@end
