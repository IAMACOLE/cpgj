//
//  KKRegisterViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/23.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKRegisterViewController.h"
#import "KKAlterUserinfoView.h"
#import "KKNewUserInfoView.h"
#import <UMShare/UMShare.h>
#import "JPUSHService.h"
#import "KKAuthManager.h"
#import "KKLoginActionManager.h"
#import "KKAlterLoginPasswordViewController.h"
#import "SignInView.h"
#import "KKRegistProtocolViewController.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface KKRegisterViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    NSInteger _isWriteUserName;  // 记录用户名是否输入正确
    NSInteger _isWritePassword;  // 记录密码是否输入
    NSInteger _isConfirm;        // 记录是否确认了密码
    BOOL      _isAgreeAgreement; // 是否同意了用户协议
}

@property (nonatomic, strong) UIButton * confirmButton;


@property (nonatomic, strong) KKNewUserInfoView * userNameView;
@property (nonatomic, strong) KKNewUserInfoView * passwordView;
@property (nonatomic, strong) KKNewUserInfoView * confirmView;
@property (nonatomic, strong) KKNewUserInfoView * phoneView;
@property (nonatomic, strong) KKNewUserInfoView * codeView;
@property (nonatomic, strong) UIView *protocolView;
@property (nonatomic, strong) UILabel *protoclLabel;
@property (nonatomic, strong) UIButton *protoclButton;
@property (nonatomic, copy) NSString *codeId;
@property (nonatomic, strong) UIImageView * codeImageView;
@property (nonatomic, copy)NSString *codeImageUrl;

@property (nonatomic, strong) UITextView * agreementTextView;
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) UIButton *qqLoginBtn;
@property (nonatomic, strong) UIButton *wechatLoginBtn;

@property (nonatomic, strong)SignInView *signInView;

@end

@implementation KKRegisterViewController

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

#pragma mark - 系统代理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_isConfirm == YES && _isAgreeAgreement == YES) {
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
        self.confirmView.textField.text = @"";
        
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
        
        if (self.userNameView.textField.text.length == 0) {
            return NO;
        }
        self.confirmView.textField.text = @"";

            NSString * checkString;
            
            if (![string isEqualToString:@""]) {
                checkString = [self.passwordView.textField.text stringByAppendingString:string];
            } else {
                checkString = [checkString stringByAppendingString:string];
            }
            
            if (checkString.length > 0) {
                _isWritePassword = 1;
            } else {
                _isWritePassword = 0;
            }
    }
    
    if (textField ==self.confirmView.textField) {
        
        if (self.passwordView.textField.text.length == 0) {
            return NO;
        }
        
        if (_isWriteUserName == 1 && _isWritePassword == 1) {
            
            NSString * checkString;
            
            if (![string isEqualToString:@""]) {
                checkString = [self.confirmView.textField.text stringByAppendingString:string];
            } else {
                checkString = [checkString stringByAppendingString:string];
            }
            
            if (checkString.length > 0) {
                _isConfirm = 1;
            } else {
                _isConfirm = 0;
            }
            
            if (_isConfirm == 1 && _isAgreeAgreement == YES) {
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
    
    if (_isConfirm == YES && _isAgreeAgreement == YES) {
        self.confirmButton.enabled = YES;
        self.confirmButton.selected = YES;
    } else {
        self.confirmButton.enabled = NO;
        self.confirmButton.selected = NO;
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"user"]) {
        
        if (![[MCTool BSGetObjectForKey:BSConfig_register_protocol] isEqualToString:@""]) {
            MCH5ViewController * h5 = [[MCH5ViewController alloc] init];
            h5.url = [MCTool BSGetObjectForKey:BSConfig_register_protocol];
            [self.navigationController pushViewController:h5 animated:YES];
            
        }
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        _isAgreeAgreement = self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
}

#pragma mark - 点击事件
- (void)confirmButtonClicked {

    
//    BOOL b = [self pipeizimu:self.userNameView.textField.text];
//    if (b == NO) {
//        [MCView BSAlertController_oneOption_viewController:self message:@"用户名设置不符合规则!" cancle:^{
//        }];
//        return;
//    }
    
    BOOL sign = [self checkIsHaveNumAndLetter:self.passwordView.textField.text];
    if (sign == NO) {
        [MCView BSAlertController_oneOption_viewController:self message:@"密码设置不符合规则!" cancle:^{
        }];
        return;
    }
    
    if (![self.passwordView.textField.text isEqualToString:self.confirmView.textField.text]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"两次输入的密码不一致!" cancle:^{
        }];
        return;
    }
    
//    if(!KK_STATUS){
//        if(kStringIsEmpty(self.phoneView.textField.text)){
//            [MCView BSAlertController_oneOption_viewController:self message:@"请输入手机号码!" cancle:^{
//            }];
//        }
//    }
    
    if (self.codeView.textField.text.length == 0) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"请输入验证码！"];
        return;
    }
    
    
    if (_isAgreeAgreement == NO) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请仔细阅读用户协议,并同意才可注册!" cancle:^{
        }];
        return;
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",KK_STATUS ? STIP : MCIP,@"user/register"];
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.userNameView.textField.text forKey:@"user_id"];
    [parameter setValue:self.passwordView.textField.text forKey:@"password"];
    [parameter setValue:self.codeId forKey:@"code_id"];
    [parameter setValue:self.codeView.textField.text forKey:@"code"];
    if (self.phoneView.textField.text.length) {
        [parameter setValue:self.phoneView.textField.text forKey:@"phone"];
    }
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"注册成功并自动登录"];
        [KKLoginActionManager dealWithUserData:data isOauthorLogin:NO withAddViewBlock:^(BOOL needAdd){
            [self addSignInViewWithIsOauthorLogin:NO andPasswordStatus:YES andNeedAdd:needAdd];
            
        }  errorBlock:^(NSString *message){
            [MCView BSAlertController_oneOption_viewController:self message:message cancle:^{
                
            }];
            [self getCodeImage];
            return;
        }];
  
    } dislike:^(id data) {
        [self getCodeImage];
    } failure:^(NSError *error) {
        [self getCodeImage];
    }];
}


- (void)protocolButtonClick {
//    if (![[MCTool BSGetObjectForKey:BSConfig_register_protocol] isEqualToString:@""]) {
//        MCH5ViewController * h5 = [[MCH5ViewController alloc] init];
//        h5.url = [MCTool BSGetObjectForKey:BSConfig_register_protocol];
//        [self.navigationController pushViewController:h5 animated:YES];
//    }
    KKRegistProtocolViewController *registProtocolVC = [KKRegistProtocolViewController new];
    [self.navigationController pushViewController:registProtocolVC animated:YES];
}

- (void)protocolIsSelect:(BOOL)select {
    NSString * str = @"注册即表示同意《用户协议》";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSLinkAttributeName value:@"user://" range:[[attributedString string] rangeOfString:@"《用户协议》"]];
    
    CGFloat font = 15;
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];

    [attributedString addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithRed:78/255.0 green:166/255.0 blue:237/255.0 alpha:1.0] range:NSMakeRange(7, str.length-8)];

    self.agreementTextView.attributedText = attributedString;

}

#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    _isAgreeAgreement = YES;
    self.isSelect = YES;
    if(KK_STATUS){
        self.navigationItem.leftBarButtonItem = self.STcustomLeftItem;
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
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", KK_STATUS ? STIP : MCIP, @"/user/third-login"];
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

//添加签到页面
- (void)addSignInViewWithIsOauthorLogin:(BOOL)isOauthorLogin andPasswordStatus:(BOOL)passwordStatus andNeedAdd:(BOOL)needAdd{
    
    if(needAdd){
        [[UIApplication sharedApplication].keyWindow addSubview:self.signInView];
        [self.signInView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo([UIApplication sharedApplication].keyWindow);
        }];
    }

    if(isOauthorLogin && !passwordStatus){
        [MCView BSAlertController_twoOptions_viewController:self message:@"您还没有设置密码" confirmTitle:@"去设置" cancelTitle:@"取消" confirm:^{
            KKAlterLoginPasswordViewController *settingPasswordVC = [KKAlterLoginPasswordViewController new];
            settingPasswordVC.isSettingPassword = YES;
            [[MCTool getCurrentVC].navigationController pushViewController:settingPasswordVC animated:YES ];
        } cancle:^{
            
        }];
    }
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
    
    [self.view addSubview:self.confirmView];
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.passwordView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    if(!KK_STATUS){
        [self.view addSubview:self.phoneView];
        [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view).with.offset(0);
            make.right.mas_equalTo(self.view).with.offset(0);
            make.top.mas_equalTo(self.confirmView.mas_bottom).with.offset(0);
            make.height.mas_equalTo(60);
        }];
    }
    
    
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        if(KK_STATUS){
           make.top.mas_equalTo(self.confirmView.mas_bottom);
        }else{
           make.top.mas_equalTo(self.phoneView.mas_bottom);
        }
        
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
        make.top.mas_equalTo(self.codeImageView.mas_bottom).with.offset(30);
        make.height.mas_equalTo(50);
    }];
    
//    [self.view addSubview:self.agreementTextView];
//    [self protocolIsSelect:YES];
//    [self.agreementTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).with.offset(10);
//        make.top.mas_equalTo(self.confirmButton.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(40);
//    }];
    
    [self.view addSubview:self.protocolView];
    [self.protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(15);
        make.top.mas_equalTo(self.confirmButton.mas_bottom).with.offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(200);
    }];
    [self.protocolView addSubview:self.protoclLabel];
    [self.protoclLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.protocolView);
        make.centerY.equalTo(self.protocolView);
        
    }];
    
    [self.protocolView addSubview:self.protoclButton];
    [self.protoclButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.protocolView);
        make.left.equalTo(self.protoclLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *otherLogin = [UILabel new];
    [self.view addSubview:otherLogin];
    [otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.protoclButton.mas_bottom).mas_offset(30);
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

//直接调用这个方法就行
-(BOOL)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return NO;
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return YES;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return YES;
    } else {
        return NO;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
}
#pragma mark - setter & getter

- (SignInView *)signInView {
    if (_signInView == nil) {
        _signInView = [[SignInView alloc] init];
    }
    return _signInView;
}

- (KKNewUserInfoView *)userNameView {
    if (_userNameView == nil) {
        _userNameView = [[KKNewUserInfoView alloc] init];
        _userNameView.textField.placeholder = @"用户账号";
        _userNameView.textField.delegate = self;
        _userNameView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _userNameView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userNameView.textField.autocorrectionType = UITextAutocorrectionTypeNo;

    } return _userNameView;
}

- (KKNewUserInfoView *)phoneView {
    if (_phoneView == nil) {
        _phoneView = [[KKNewUserInfoView alloc] init];
        NSString *holderText = @"手机号码  (为了您的顺利出款,请如实填写!)";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName value:MCUIColorRed range:NSMakeRange(6, holderText.length-6)];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(6, holderText.length-6)];
        _phoneView.textField.attributedPlaceholder = placeholder;
        _phoneView.textField.delegate = self;
        _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phoneView.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
    } return _phoneView;
}

- (KKNewUserInfoView *)passwordView {
    if (_passwordView == nil) {
        _passwordView = [[KKNewUserInfoView alloc] init];
        _passwordView.textField.placeholder = @"以字母开头6-16位密码";
        _passwordView.textField.delegate = self;
        _passwordView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordView.textField.secureTextEntry = YES;
        _passwordView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
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
//        _codeView.backgroundColor = MCMineTableCellBgColor;
        _codeView.textField.placeholder = @"验证码";
        _codeView.textField.delegate = self;
        _codeView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _codeView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeView.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    } return _codeView;
}

- (KKNewUserInfoView *)confirmView {
    if (_confirmView == nil) {
        _confirmView = [[KKNewUserInfoView alloc] init];
        _confirmView.textField.placeholder = @"确认密码";
        _confirmView.textField.delegate = self;
        _confirmView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _confirmView.textField.secureTextEntry = YES;
        _confirmView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _confirmView.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    } return _confirmView;
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
        [_confirmButton setTitle:@"注册" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}


- (UITextView *)agreementTextView {
    if (_agreementTextView == nil) {
        _agreementTextView = [[UITextView alloc] init];
        _agreementTextView.delegate = self;
        _agreementTextView.editable = NO;
        _agreementTextView.scrollEnabled = NO;
        _agreementTextView.textAlignment = NSTextAlignmentCenter;
    } return _agreementTextView;
}

- (UIView *)protocolView {
    if (_protocolView == nil) {
        _protocolView = [[UIView alloc] init];
//        _protocolView.backgroundColor = MCMineTableCellBgColor;
    }
    return _protocolView;
}

- (UILabel *)protoclLabel {
    if (_protoclLabel == nil) {
        _protoclLabel = [[UILabel alloc] init];
        _protoclLabel.text = @"注册即表示同意";
        _protoclLabel.font = [UIFont systemFontOfSize:15];
        _protoclLabel.textColor =  [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1/1.0];
        [_protoclLabel sizeToFit];
    }
    return _protoclLabel;
}

- (UIButton *)protoclButton {
    if (_protoclButton == nil) {
        _protoclButton = [[UIButton alloc] init];
        [_protoclButton setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [_protoclButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        _protoclButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_protoclButton sizeToFit];
        [_protoclButton addTarget:self action:@selector(protocolButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protoclButton;
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
