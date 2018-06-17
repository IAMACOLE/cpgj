//
//  KKLoginViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/23.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKLoginViewController.h"

#import "KKAlterUserinfoView.h"
#import "KKNewUserInfoView.h"

#import "KKRegisterViewController.h"
#import "KKForgetPasswordViewController.h"
#import <UMShare/UMShare.h>
#import "KKAuthManager.h"
#import "KKLoginActionManager.h"
#import "JPUSHService.h"
#import "SignInView.h"
#import "KKAlterLoginPasswordViewController.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface KKLoginViewController ()
<
UITextFieldDelegate
>

{
    NSInteger _isWriteUserName;  // 记录用户名是否输入正确
}
@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) UIButton * forgetButton;
@property (nonatomic, strong) UIButton * registerButton;

@property (nonatomic, strong) KKNewUserInfoView * userNameView;
@property (nonatomic, strong) KKNewUserInfoView * passwordView;
@property (nonatomic, strong) KKNewUserInfoView * codeView;

@property (nonatomic, strong) UIImageView * codeImageView;
@property (nonatomic, copy)NSString *codeImageUrl;
@property (nonatomic, copy)NSString *codeId;

@property (nonatomic, strong) UIButton *qqLoginBtn;
@property (nonatomic, strong) UIButton *wechatLoginBtn;

@property (nonatomic, strong)SignInView *signInView;

@end

@implementation KKLoginViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    [self initUI];
    [self getCodeImage];
}

-(void)getCodeImage{
    [MCTool getCodeImageSuccess:^(UIImage *image, NSString *codeID) {
        self.codeId = codeID;
        self.codeImageView.image = image;
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

#pragma mark - 系统代理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.userNameView.textField.text.length > 0 && self.passwordView.textField.text.length > 0) {
        self.confirmButton.enabled = YES;
        self.confirmButton.selected = YES;
    } else {
        self.confirmButton.enabled = NO;
        self.confirmButton.selected = NO;
    }

    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.userNameView.textField) {
        
        // 当用户名修改了,清空密码!
        self.passwordView.textField.text = @"";
        
        NSString * checkString;
        
        if (range.location == 11) {
            return NO;
        } else {
            
            if (![string isEqualToString:@""]) {
                checkString = [self.userNameView.textField.text stringByAppendingString:string];
            } else {
                checkString = [checkString stringByAppendingString:string];
            }
            
            if ([MCTool BSJudge_accountWith:checkString]) {
                _isWriteUserName = 1;
            } else {
                _isWriteUserName = 0;
            }
            return YES;
        }
    }

    if (textField ==self.passwordView.textField) {
        
        if (_isWriteUserName == 1) {
            
            NSString * checkString;

            if (![string isEqualToString:@""]) {
                checkString = [self.passwordView.textField.text stringByAppendingString:string];
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
    
    
    if (self.userNameView.textField.text.length > 0 && self.passwordView.textField.text.length > 0  && self.codeView.textField.text.length > 0) {
        self.confirmButton.enabled = YES;
        self.confirmButton.selected = YES;
    } else {
        self.confirmButton.enabled = NO;
        self.confirmButton.selected = NO;
    }
    
    return YES;
}


#pragma mark - 点击事件
- (void)leftItemClicked {
    if (self.isMandatory == YES) {
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        [MCTool BSRemoveObjectforKey:BSUserinfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:BSNotification_ChangeLoginStatus object:nil];
     
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        } seq:0];
        
        //发出通知 刷新首页的数据
        NSNotification * notification = [NSNotification notificationWithName:@"RELOADHOMEPAGE" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightItemClicked {
    if (![[MCTool BSGetObjectForKey:BSConfig_customer_service_url] isEqualToString:@""]) {
        MCH5ViewController * h5 = [[MCH5ViewController alloc] init];
        h5.url = [MCTool BSGetObjectForKey:BSConfig_customer_service_url];
        [self.navigationController pushViewController:h5 animated:YES];
    }
}

- (void)forgetButtonClicked {
    NSString *url = [MCTool BSGetObjectForKey:BSConfig_customer_service_url];
    if (url.length > 0) {
        MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
        mch5Vc.url = url;
        [self.navigationController pushViewController:mch5Vc animated:YES];
        
    }
//    KKForgetPasswordViewController * forget = [[KKForgetPasswordViewController alloc] init];
//    [self.navigationController pushViewController:forget animated:YES];
 
}

- (void)confirmButtonClicked {
    
    BOOL b = [self pipeizimu:self.userNameView.textField.text];
    if (b == NO) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请输入正确的用户名称!" cancle:^{
        }];
        return;
    }

    NSString * urlStr  = [NSString stringWithFormat:@"%@%@",KK_STATUS ? STIP : MCIP,@"user/login"];
    
    NSDictionary * parameter = @{
                                 @"user_id" : self.userNameView.textField.text,
                                 @"code_id" : self.codeId,
                                 @"code"    : self.codeView.textField.text,
                                 @"password" : self.passwordView.textField.text
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self success:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"登录成功"];
        [KKLoginActionManager dealWithUserData:data isOauthorLogin:NO withAddViewBlock:^(BOOL needAdd){
            [self addSignInViewWithIsOauthorLogin:NO andPasswordStatus:YES andNeedAdd:needAdd];
        }  errorBlock:^(NSString *message){
            [MCView BSAlertController_oneOption_viewController:self message:message cancle:^{
                
            }];
            [self getCodeImage];
            return;
        }];
    } error:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:data];
        [self getCodeImage];
    } failure:^(NSError *error) {
        [self getCodeImage];
    }];
}

-(BOOL)pipeizimu:(NSString *)str {
    
    if (str.length > 11 || str.length < 6) {
        return NO;
    }
    
    NSString *regex =  @"^[A-Za-z][A-Za-z0-9]*$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pre evaluateWithObject:str];
    if (isMatch)
        return YES;
    else
        return NO;
}

//添加签到页面
- (void)addSignInViewWithIsOauthorLogin:(BOOL)isOauthorLogin andPasswordStatus:(BOOL)passwordStatus andNeedAdd:(BOOL)needAdd{
    if(needAdd){
        [[UIApplication sharedApplication].keyWindow addSubview:self.signInView];
        [self.signInView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo([UIApplication sharedApplication].keyWindow);
        }];
    }
    
    if(isOauthorLogin && !passwordStatus){
        UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:nil message:@"您还没有设置密码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        alertView.delegate = self;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        KKAlterLoginPasswordViewController *settingPasswordVC = [[KKAlterLoginPasswordViewController alloc] init];
        settingPasswordVC.isSettingPassword = YES;
        [[MCTool getCurrentVC].navigationController pushViewController:settingPasswordVC animated:YES ];
    }
}

- (void)registerButtonClicked {
    KKRegisterViewController * registerViewController = [[KKRegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
}


#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    if(KK_STATUS){
        self.navigationItem.leftBarButtonItem = self.STcustomLeftItem;
    }else{
        [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(18, 18) target:self selected:@selector(rightItemClicked) image:@"Reuse_Service" isLeft:NO];
    }
    
}

-(void)didClickQQLoginBtn{
    [KKAuthManager getUserInfoForPlatform:UMSocialPlatformType_QQ success:^(UMSocialUserInfoResponse *resp) {
         [self oauthorLoginForPlatform:UMSocialPlatformType_QQ WithUserInforRespone:resp];
    }];
}

-(void)didClickWechatLoginBtn{
    [KKAuthManager getUserInfoForPlatform:UMSocialPlatformType_WechatSession success:^(UMSocialUserInfoResponse *resp) {
        [self oauthorLoginForPlatform:UMSocialPlatformType_WechatSession WithUserInforRespone:resp];
    }];
}

-(void)oauthorLoginForPlatform:(UMSocialPlatformType)platform WithUserInforRespone:(UMSocialUserInfoResponse *)resp{
    NSString *platformNum = platform == UMSocialPlatformType_WechatSession ? @"01" : @"02";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", KK_STATUS ? STIP : MCIP, @"/user/third-login"] ;
    NSDictionary *param = @{@"access_token": resp.accessToken,
                            @"third_flag"  : platformNum,
                            @"openid"      : resp.openid,
                            @"unionid"     : kStringIsEmpty(resp.unionId)? @"" :resp.unionId ,
                            @"nickname"    : resp.name,
                            @"headimgurl"  : resp.iconurl,
                            };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"登录成功"];
        [KKLoginActionManager dealWithUserData:data isOauthorLogin:YES withAddViewBlock:^(BOOL needAdd){
            [self addSignInViewWithIsOauthorLogin:YES andPasswordStatus:[data[@"login_passwd_status"] integerValue] andNeedAdd:needAdd];
        }  errorBlock:^(NSString *message){
            [self getCodeImage];
            return;
        }];
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.userNameView];
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.view).with.offset(10);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.userNameView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.passwordView.mas_bottom);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(MCScreenWidth * 5 /8);
    }];

    [self.view addSubview:self.codeImageView];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeView.mas_right).mas_offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.codeView);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(15);
        make.right.mas_equalTo(self.view).with.offset(-15);
        make.top.mas_equalTo(self.codeView.mas_bottom).with.offset(15);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(10);
        make.top.mas_equalTo(self.confirmButton.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    if(!KK_STATUS){
        [self.view addSubview:self.forgetButton];
        [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view).with.offset(-10);
            make.top.mas_equalTo(self.confirmButton.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
    }
    
    UILabel *otherLogin = [UILabel new];
    [self.view addSubview:otherLogin];
    [otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.registerButton.mas_bottom).mas_offset(30);
    }];
    otherLogin.textColor = [UIColor grayColor];
    otherLogin.text = @"其他登录方式";
    otherLogin.font = MCFont(14);
    otherLogin.hidden = OpenOauth;
    
    [self.view addSubview:self.qqLoginBtn];
    [self.qqLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64);
        make.centerX.mas_equalTo(32+15);
        make.top.mas_equalTo(otherLogin.mas_bottom).mas_offset(15);
    }];
    
    [self.view addSubview:self.wechatLoginBtn];
    [self.wechatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64);
        make.centerX.mas_equalTo(-32-15);
        make.top.mas_equalTo(otherLogin.mas_bottom).mas_offset(15);
    }];
}

#pragma mark - setter & getter

- (KKNewUserInfoView *)userNameView {
    if (_userNameView == nil) {
        _userNameView = [[KKNewUserInfoView alloc] init];
        _userNameView.textField.placeholder = @"会员账号";
        _userNameView.textField.delegate = self;
        _userNameView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _userNameView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userNameView.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    } return _userNameView;
}

- (KKNewUserInfoView *)passwordView {
    if (_passwordView == nil) {
        _passwordView = [[KKNewUserInfoView alloc] init];
        _passwordView.textField.placeholder = @"密码";
        _passwordView.textField.secureTextEntry = YES;
        _passwordView.textField.delegate = self;
        _passwordView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordView.textField.secureTextEntry = YES;
        _passwordView.textField.autocorrectionType = UITextAutocorrectionTypeNo;

    } return _passwordView;
}

-(UIImageView *)codeImageView{
    if(!_codeImageView){
        _codeImageView = [UIImageView new];
        _codeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _codeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCodeImage)];
        [_codeImageView addGestureRecognizer:tap];
        [_codeImageView sd_setImageWithURL:[NSURL URLWithString:self.codeImageUrl] placeholderImage:[UIImage imageNamed:@"Mine_CodeImage"]];
    }
    return _codeImageView;
}

- (KKNewUserInfoView *)codeView {
    if (_codeView == nil) {
        _codeView = [[KKNewUserInfoView alloc] init];
        _codeView.textField.placeholder = @"验证码";
        _codeView.textField.delegate = self;
        _codeView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _codeView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeView.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    } return _codeView;
}

- (UIButton *)forgetButton {
    if (_forgetButton == nil) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.titleLabel.font = MCFont(14);
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(forgetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _forgetButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.titleLabel.font = MCFont(14);
        [_registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerButton setTitleColor:KK_STATUS ? STUIColorBlue : MCUIColorMain forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _registerButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundImage:[MCTool MCImageWithColor:MCUIColorMiddleGray] forState:UIControlStateNormal];
        if(KK_STATUS){
           [_confirmButton setBackgroundImage:[MCTool MCImageWithColor:STUIColorBlue] forState:UIControlStateSelected];
        }else{
           [_confirmButton setBackgroundImage:[MCTool MCImageWithColor:MCUIColorMain] forState:UIControlStateSelected];
        }
        _confirmButton.enabled = NO;
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 5;
        _confirmButton.titleLabel.font = MCFont(14);
        [_confirmButton setTitle:@"登录" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}


- (SignInView *)signInView {
    if (_signInView == nil) {
        _signInView = [[SignInView alloc] init];
    }
    return _signInView;
}

- (UIButton *)qqLoginBtn{
    if(!_qqLoginBtn){
        _qqLoginBtn = [UIButton new];
        [_qqLoginBtn setBackgroundImage:[UIImage imageNamed:@"QQ登录"] forState:UIControlStateNormal];
        [_qqLoginBtn addTarget:self action:@selector(didClickQQLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        _qqLoginBtn.hidden = OpenOauth;
    }
    return _qqLoginBtn;
}

- (UIButton *)wechatLoginBtn{
    if(!_wechatLoginBtn){
        _wechatLoginBtn = [UIButton new];
        [_wechatLoginBtn setBackgroundImage:[UIImage imageNamed:@"Wechat登录"] forState:UIControlStateNormal];
        [_wechatLoginBtn addTarget:self action:@selector(didClickWechatLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        _wechatLoginBtn.hidden = OpenOauth;
    }
    return _wechatLoginBtn;
}

@end
