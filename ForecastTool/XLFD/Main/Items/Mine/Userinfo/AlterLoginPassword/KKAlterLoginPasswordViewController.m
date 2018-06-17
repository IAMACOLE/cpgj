//
//  KKAlterLoginPasswordViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAlterLoginPasswordViewController.h"

#import "KKAlterUserinfoView.h"

@interface KKAlterLoginPasswordViewController ()

@property (nonatomic, strong) KKAlterUserinfoView * alter_oneView;
@property (nonatomic, strong) KKAlterUserinfoView * alter_twoView;
@property (nonatomic, strong) KKAlterUserinfoView * alter_threeView;

@property (nonatomic, strong) UIButton            * confirmButton;

@end

@implementation KKAlterLoginPasswordViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self initUI];
}

#pragma mark - 点击事件
- (void)confirmButtonClicked {
    
    if(_isSettingPassword){
        [self settingPassword];
    }else{
        [self modifyPassword];
    }
    
}

-(void)settingPassword{
    
    if (self.alter_twoView.textField.text.length == 0) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请填写密码"cancle:^{
        }];
        return;
    }
    
    if (![self.alter_twoView.textField.text isEqualToString:self.alter_threeView.textField.text]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"两次输入的密码不一致!" cancle:^{
        }];
        return;
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/set-passwd"];
    
    NSDictionary * parameter = @{
                                 @"password"   : self.alter_twoView.textField.text,
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"设置成功"];
            NSMutableDictionary * userinfoDict = [NSMutableDictionary dictionaryWithDictionary:[MCTool BSGetObjectForKey:BSUserinfo]];
            [userinfoDict removeObjectForKey:BSUserinfo_password_status];
            [userinfoDict setValue:@"1" forKey:BSUserinfo_password_status];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)modifyPassword{
    
    if (self.alter_oneView.textField.text.length == 0) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请填写原始密码" cancle:^{
        }];
        return;
    }
    
    if (self.alter_twoView.textField.text.length == 0) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请填写新密码"cancle:^{
        }];
        return;
    }
    
    if (![self.alter_twoView.textField.text isEqualToString:self.alter_threeView.textField.text]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"两次输入的密码不一致!" cancle:^{
        }];
        return;
    }

    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/edit-passwd"];
    
    NSDictionary * parameter = @{
                                 @"password"   : self.alter_oneView.textField.text,
                                 @"new_passwd" : self.alter_twoView.textField.text
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:nil isShowTabbar:NO success:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"修改成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 基本设置
- (void)basicSetting {
    if(_isSettingPassword){
        self.titleString = @"设置密码";
    }else{
        self.titleString = @"修改密码";
    }

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
    
    if(_isSettingPassword){
        [self.alter_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
 
    [self.view addSubview:self.alter_twoView];
    [self.alter_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.alter_oneView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    [self.view addSubview:self.alter_threeView];
    [self.alter_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.alter_twoView.mas_bottom).with.offset(0);
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

- (KKAlterUserinfoView *)alterUserinfoViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder{
    KKAlterUserinfoView *userInforView = [[KKAlterUserinfoView alloc] init];
    userInforView .backgroundColor = MCMineTableCellBgColor;
    userInforView .titleLabel.text =title;
    userInforView .textField.placeholder = placeholder;
    userInforView .textField.keyboardType = UIKeyboardTypeASCIICapable;
    userInforView .textField.secureTextEntry = YES;
    userInforView .textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    return userInforView;
}

- (KKAlterUserinfoView *)alter_oneView {
    if (_alter_oneView == nil) {
        self.alter_oneView = [self alterUserinfoViewWithTitle:@"原始密码" placeholder:@"请输入您的原始密码"];
    } return _alter_oneView;
}

- (KKAlterUserinfoView *)alter_twoView {
    if (_alter_twoView == nil) {
        if(_isSettingPassword){
            self.alter_twoView = [self alterUserinfoViewWithTitle:@"密码" placeholder:@"请输入您的密码"];
        }else{
            self.alter_twoView = [self alterUserinfoViewWithTitle:@"新密码" placeholder:@"请输入您的新密码"];
        }
    } return _alter_twoView;
}

- (KKAlterUserinfoView *)alter_threeView {
    if (_alter_threeView == nil) {
        if(_isSettingPassword){
            self.alter_threeView = [self alterUserinfoViewWithTitle:@"确认密码" placeholder:@"请再次输入您的密码"];
        }else{
            self.alter_threeView = [self alterUserinfoViewWithTitle:@"确认密码" placeholder:@"请再次输入您的新密码"];
        }
    } return _alter_threeView;
}



@end
