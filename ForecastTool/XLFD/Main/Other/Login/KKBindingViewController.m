//
//  KKBindingViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/23.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBindingViewController.h"

#import "KKAlterUserinfoView.h"

#import "KKBindingViewController.h"

@interface KKBindingViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    NSTimer       *_timer;     //定时器
    NSInteger      _second;    //倒计时的时间
}
@property (nonatomic, strong) UIButton * confirmButton;


@property (nonatomic, strong) KKAlterUserinfoView * userNameView;
@property (nonatomic, strong) KKAlterUserinfoView * QRCodeView;

@property (nonatomic, strong) UIButton * codeButton;

@end

@implementation KKBindingViewController

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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    
    if (textField == self.userNameView.textField) {
        NSString * checkString;
        
        self.QRCodeView.textField.text = @"";
        
        
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
            } else {
                NSLog(@"号码不满足!");
                self.codeButton.selected = NO;
                self.codeButton.enabled = NO;
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
            self.confirmButton.enabled = YES;
            self.confirmButton.selected = YES;
        } else {
            self.confirmButton.enabled = NO;
            self.confirmButton.selected = NO;
        }
    }
    
    
    return YES;
}

#pragma mark - 点击事件
- (void)confirmButtonClicked {
    

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
        [self.codeButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
    }
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"注册";
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
        [self.confirmButton setTitle:@"完成注册" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}



@end
