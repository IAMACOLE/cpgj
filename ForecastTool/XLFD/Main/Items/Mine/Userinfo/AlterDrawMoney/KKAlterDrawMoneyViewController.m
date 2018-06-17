//
//  KKAlterDrawMoneyViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAlterDrawMoneyViewController.h"

#import "KKAlterUserinfoView.h"

@interface KKAlterDrawMoneyViewController ()

@property (nonatomic, strong) KKAlterUserinfoView * originalView;
@property (nonatomic, strong) KKAlterUserinfoView * alter_oneView;
@property (nonatomic, strong) KKAlterUserinfoView * alter_twoView;
@property (nonatomic, strong) UILabel * promptLabel;

@property (nonatomic, strong) UIButton            * confirmButton;

@end

@implementation KKAlterDrawMoneyViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}

#pragma mark - 系统代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 点击事件

- (void)keyboardConfirmClicked {
    [self.view endEditing:YES];
}
- (void)confirmButtonClicked {
    
    if (self.alter_oneView.textField.text.length != 6) {
        [MCView BSAlertController_oneOption_viewController:self message:@"提现密码必须6位!" cancle:^{
        }];
        return;
    }

    if (![self.alter_oneView.textField.text isEqualToString:self.alter_twoView.textField.text]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"两次输入的提现密码不一致" cancle:^{
        }];
        return;
    }
    
    
    NSString * urlStr;
    NSDictionary * parameter;
    if (self.isChange == YES) {
        if (self.originalView.textField.text.length == 0) {
            [MCView BSAlertController_oneOption_viewController:self message:@"请填写原始密码!" cancle:^{
            }];
            return;
        }
        
        urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/edit-bank-passwd"];
        parameter = @{
                      @"new_passwd"  : self.alter_oneView.textField.text,
                      @"bank_passwd"  : self.originalView.textField.text
                      };
        
    } else {
        urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/set-bank-passwd"];
        parameter = @{
                      @"bank_passwd"  : self.alter_oneView.textField.text
                      };
    }
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            NSMutableDictionary * userinfoDict = [NSMutableDictionary dictionaryWithDictionary:[MCTool BSGetObjectForKey:BSUserinfo]];
            [userinfoDict removeObjectForKey:BSbank_passwd_status];
            [userinfoDict setValue:@"1" forKey:BSbank_passwd_status];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BSNotification_reloadPersonalInformation object:nil];

            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"设置提现密码成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
      
    }];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    if (self.isChange == YES) {
        self.titleString = @"修改提款密码";
    } else {
        self.titleString = @"提款密码";
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UI布局
- (void)initUI {
    
    if (self.isChange == YES) {
        [self.view addSubview:self.originalView];
        [self.originalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view).with.offset(0);
            make.right.mas_equalTo(self.view).with.offset(0);
            make.top.mas_equalTo(self.view).with.offset(0);
            make.height.mas_equalTo(94);
        }];
    } else {
        [self.view addSubview:self.originalView];
        [self.originalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view).with.offset(0);
            make.right.mas_equalTo(self.view).with.offset(0);
            make.top.mas_equalTo(self.view).with.offset(0);
            make.height.mas_equalTo(0);
        }];
        self.originalView.hidden = YES;
    }
    
    [self.view addSubview:self.alter_oneView];
    [self.alter_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.originalView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    [self.view addSubview:self.alter_twoView];
    [self.alter_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.alter_oneView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];

    
    [self.view addSubview:self.promptLabel];
    [self.promptLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(15);
        make.top.mas_equalTo(self.alter_twoView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(40);
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

- (KKAlterUserinfoView *)originalView {
    if (_originalView == nil) {
        self.originalView = [[KKAlterUserinfoView alloc] init];
        self.originalView.backgroundColor = MCMineTableCellBgColor;
        self.originalView.titleLabel.text = @"原始密码";
        self.originalView.textField.placeholder = @"请输入您的原始密码";
        self.originalView.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.originalView.textField.secureTextEntry = YES;
        
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, MCScreenWidth,44)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MCScreenWidth - 60, 7,50, 30)];
        [button setTitle:@"确认"forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyboardConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [bar addSubview:button];
        [bar layoutIfNeeded];
        [bar sendSubviewToBack:bar.subviews.lastObject];
        self.originalView.textField.inputAccessoryView = bar;
        
    } return _originalView;
}

- (KKAlterUserinfoView *)alter_oneView {
    if (_alter_oneView == nil) {
        self.alter_oneView = [[KKAlterUserinfoView alloc] init];
        self.alter_oneView.backgroundColor =MCMineTableCellBgColor;
        self.alter_oneView.titleLabel.text = @"设置提现密码";
        self.alter_oneView.textField.placeholder = @"请输入您的提现密码(6位)";
        self.alter_oneView.textField.secureTextEntry = YES;
        
        
        self.alter_oneView.textField.keyboardType = UIKeyboardTypeNumberPad;
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, MCScreenWidth,44)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MCScreenWidth - 60, 7,50, 30)];
        [button setTitle:@"确认"forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyboardConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [bar addSubview:button];
        [bar layoutIfNeeded];
        [bar sendSubviewToBack:bar.subviews.lastObject];

        self.alter_oneView.textField.inputAccessoryView = bar;
    } return _alter_oneView;
}

- (KKAlterUserinfoView *)alter_twoView {
    if (_alter_twoView == nil) {
        self.alter_twoView = [[KKAlterUserinfoView alloc] init];
        self.alter_twoView.backgroundColor = MCMineTableCellBgColor;
        self.alter_twoView.titleLabel.text = @"确认提现密码";
        self.alter_twoView.textField.placeholder = @"请再次输入您的提现密码";
        self.alter_twoView.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.alter_twoView.textField.secureTextEntry = YES;
        
        
        self.alter_twoView.textField.keyboardType = UIKeyboardTypeNumberPad;
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, MCScreenWidth,44)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MCScreenWidth - 60, 7,50, 30)];
        [button setTitle:@"确认"forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyboardConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [bar addSubview:button];
        [bar layoutIfNeeded];
        [bar sendSubviewToBack:bar.subviews.lastObject];
        self.alter_twoView.textField.inputAccessoryView = bar;
        
    } return _alter_twoView;
}

- (UILabel *)promptLabel {
    if (_promptLabel == nil) {
        self.promptLabel = [[UILabel alloc] init];
        self.promptLabel.font = MCFont(12);
        self.promptLabel.textColor = MCUIColorMiddleGray;
        self.promptLabel.text = @"提现密码必须为6位纯数字";
    } return _promptLabel;
}

@end
