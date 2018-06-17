//
//  KKForgetPasswordViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/23.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKForgetPasswordViewController.h"

#import "KKAlterUserinfoView.h"

@interface KKForgetPasswordViewController ()
<
UITextFieldDelegate,
UITextViewDelegate
>

{
    NSTimer       *_timer;     //定时器
    NSInteger      _second;    //倒计时的时间
    
    NSInteger _isWriteUserName;  // 记录用户名是否输入正确
    NSInteger _isWritePassword;  // 记录密码是否输入
    NSInteger _isWriteQRCode;    // 记录是否输入的验证码
}
@property (nonatomic, strong) UIButton * confirmButton;


@property (nonatomic, strong) KKAlterUserinfoView * userNameView;
@property (nonatomic, strong) KKAlterUserinfoView * QRCodeView;
@property (nonatomic, strong) KKAlterUserinfoView * passowordView;
@property (nonatomic, strong) KKAlterUserinfoView * confirmView;



@property (nonatomic, strong) UIButton * codeButton;

@end

@implementation KKForgetPasswordViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 键盘弹出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}

#pragma mark - 通知
#pragma mark 键盘弹起
- (void)keyboardWillShow:(NSNotification *)noti
{
    NSLog(@"键盘弹起");
    
    NSDictionary *dict = noti.userInfo;
    
    NSLog(@"dict:%@", dict);
    
    
    if ([self.confirmView.textField isFirstResponder]) {
        // 当键盘遮住文本框,移动self.view
        // 获取文本框的最大y值.
        CGFloat tfMaxY = CGRectGetMaxY(self.confirmView.frame) + 80;
        
        CGFloat keyboardY = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        
        // 获取键盘弹起时长
        CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        if (tfMaxY > keyboardY) { // 键盘遮住文本框
            [UIView animateWithDuration:duration animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - tfMaxY);
            }];
        } 
    }
    
}

#pragma mark 键盘隐藏
- (void)keyboardWillHide:(NSNotification *)noti {
    NSLog(@"键盘隐藏");
    
    // 获取键盘隐藏动画时长
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 所有形变属性还原
        self.view.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 系统代理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.userNameView.textField) {
        NSString * checkString;

        self.QRCodeView.textField.text = @"";
        self.passowordView.textField.text = @"";
        self.confirmView.textField.text = @"";
        self.confirmButton.enabled = NO;
        self.confirmButton.selected = NO;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];

        if (_timer != nil) {
            //释放定时器
            [_timer invalidate];
            //把定时器设置成空.不然不起作用.
            _timer = nil;
        }
        
        
        if (range.location == 11) {
            return NO;
        } else {
            
            if (![string isEqualToString:@""]) {
                checkString = [self.userNameView.textField.text stringByAppendingString:string];
            } else {
                checkString = [checkString stringByAppendingString:string];
            }
            
            if ([MCTool BSJudge_phoneNumber:checkString]) {
                NSLog(@"号码满足!");
                self.codeButton.selected = YES;
                self.codeButton.enabled = YES;
                _isWriteUserName = 1;
            } else {
                NSLog(@"号码不满足!");

                self.codeButton.selected = NO;
                self.codeButton.enabled = NO;
                _isWriteUserName = 0;
            }
            return YES;
        }
    }
    
    
    if (textField == self.QRCodeView.textField) {
        NSString * checkString;
        
        if (![string isEqualToString:@""]) {
            checkString = [self.userNameView.textField.text stringByAppendingString:string];
        } else {
            checkString = [checkString stringByAppendingString:string];
        }
        
        if (checkString.length > 0) {
            _isWriteQRCode = 1;
        } else {
            _isWriteQRCode = 0;
        }
    }

    
    
    
    if (textField ==self.passowordView.textField) {
        
        if (_isWriteQRCode == 1 && _isWriteUserName == 1) {
            NSString * checkString;
            
            if (![string isEqualToString:@""]) {
                checkString = [self.passowordView.textField.text stringByAppendingString:string];
            } else {
                checkString = [checkString stringByAppendingString:string];
            }
            
            if (checkString.length > 0) {
                _isWritePassword = 1;
            } else {
                _isWritePassword = 0;
            }
        }
    }
    
    
    
    if (textField ==self.confirmView.textField) {
        
        if (_isWriteUserName == 1 && _isWritePassword == 1) {
            
            
            NSString * checkString;
            
            if (![string isEqualToString:@""]) {
                checkString = [self.confirmView.textField.text stringByAppendingString:string];
            } else {
                checkString = [checkString stringByAppendingString:string];
            }
            
            if (checkString.length > 0) {
                self.confirmButton.enabled = YES;
                self.confirmButton.selected = YES;
            } else {
                self.confirmButton.enabled = NO;
                self.confirmButton.selected = NO;
            }
            
        }
    }
    
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}


#pragma mark - 点击事件
- (void)confirmButtonClicked {
    
    if (![self.passowordView.textField.text isEqualToString:self.confirmView.textField.text]) {
        
        [MCView BSAlertController_oneOption_viewController:self message:@"两次输入的密码不一致!" cancle:^{
        }];
        return;
    }
    
    [MCView BSAlertController_oneOption_viewController:self message:@"修改密码成功,请登录" cancle:^{
    }];
}

- (void)codeButtonClicked {
    
    _second = 60;
    
    self.codeButton.selected = NO;
    self.codeButton.enabled = NO;
    
    [self.QRCodeView.textField becomeFirstResponder];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
}

#pragma mark 定时器调用的方法
- (void)changeTime
{
    
    //每一秒调用一次改方法, 每次调用,_second 减一.
    _second --;
    
    
    //修改倒计时标签文字   ->   把按钮文字改成倒计时的时间
    [self.codeButton setTitle:[NSString stringWithFormat:@"%@ s",@(_second)] forState:UIControlStateNormal];
    
    
    //如果时间到了 0 秒, 把定时器取消掉
    if (_second == -1)
    {
        //释放定时器
        [_timer invalidate];
        //把定时器设置成空.不然不起作用.
        _timer = nil;
        
        
        //把修改的验证码按钮调整为初始状态
        self.codeButton.selected = YES;
        self.codeButton.enabled = YES;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
    }
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.userNameView];
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    
    [self.view addSubview:self.QRCodeView];
    [self.QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(-120);
        make.top.mas_equalTo(self.userNameView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    
    [self.view addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view).with.offset(-10);
        make.bottom.mas_equalTo(self.QRCodeView);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    [self.view addSubview:self.passowordView];
    [self.passowordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.QRCodeView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    [self.view addSubview:self.confirmView];
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.passowordView.mas_bottom).with.offset(0);
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

- (KKAlterUserinfoView *)userNameView {
    if (_userNameView == nil) {
        self.userNameView = [[KKAlterUserinfoView alloc] init];
        self.userNameView.backgroundColor = MCUIColorWhite;
        self.userNameView.titleLabel.text = @"用户名";
        self.userNameView.textField.placeholder = @"请输入您的姓名";
        self.userNameView.textField.delegate = self;
        self.userNameView.textField.keyboardType = UIKeyboardTypeNumberPad;

    } return _userNameView;
}

- (KKAlterUserinfoView *)QRCodeView {
    if (_QRCodeView == nil) {
        self.QRCodeView = [[KKAlterUserinfoView alloc] init];
        self.QRCodeView.backgroundColor = MCUIColorWhite;
        self.QRCodeView.titleLabel.text = @"验证码";
        self.QRCodeView.textField.placeholder = @"请输入验证码";
        self.QRCodeView.textField.delegate = self;
        self.QRCodeView.textField.keyboardType = UIKeyboardTypeNumberPad;

    } return _QRCodeView;
}

- (KKAlterUserinfoView *)passowordView {
    if (_passowordView == nil) {
        self.passowordView = [[KKAlterUserinfoView alloc] init];
        self.passowordView.backgroundColor = MCUIColorWhite;
        self.passowordView.titleLabel.text = @"新密码";
        self.passowordView.textField.placeholder = @"请输入新密码";
        self.passowordView.textField.delegate = self;
        self.passowordView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        self.passowordView.textField.secureTextEntry = YES;

    } return _passowordView;
}

- (KKAlterUserinfoView *)confirmView {
    if (_confirmView == nil) {
        self.confirmView = [[KKAlterUserinfoView alloc] init];
        self.confirmView.backgroundColor = MCUIColorWhite;
        self.confirmView.titleLabel.text = @"确认新密码";
        self.confirmView.textField.placeholder = @"请再次输入新密码";
        self.confirmView.textField.delegate = self;
        self.confirmView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        self.confirmView.textField.secureTextEntry = YES;

    } return _confirmView;
}


- (UIButton *)codeButton {
    if (_codeButton == nil) {
        self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.codeButton setBackgroundImage:[MCTool MCImageWithColor:MCUIColorMiddleGray] forState:UIControlStateNormal];
        [self.codeButton setBackgroundImage:[MCTool MCImageWithColor:MCUIColorMain] forState:UIControlStateSelected];
        self.codeButton.enabled = NO;
        self.codeButton.layer.masksToBounds = YES;
        self.codeButton.layer.cornerRadius = 5;
        self.codeButton.titleLabel.font = MCFont(14);
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.codeButton addTarget:self action:@selector(codeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _codeButton;
}




- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmButton setBackgroundImage:[MCTool MCImageWithColor:MCUIColorMiddleGray] forState:UIControlStateNormal];
        [self.confirmButton setBackgroundImage:[MCTool MCImageWithColor:MCUIColorMain] forState:UIControlStateSelected];
        self.confirmButton.enabled = NO;
        self.confirmButton.layer.masksToBounds = YES;
        self.confirmButton.layer.cornerRadius = 5;
        self.confirmButton.titleLabel.font = MCFont(14);
        [self.confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}



@end
