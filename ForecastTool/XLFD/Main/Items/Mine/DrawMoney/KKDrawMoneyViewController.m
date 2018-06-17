//
//  KKDrawMoneyViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKDrawMoneyViewController.h"
#import "KKAlterUserinfoView.h"


#import "KKDrawMoney_bindingView.h"
#import "KKBingingBankcardViewController.h"
#import "KKAlterDrawMoneyViewController.h"


@interface KKDrawMoneyViewController ()
<
UITextFieldDelegate
>

@property (nonatomic, strong) UIButton * moneyButton;

@property (nonatomic, strong) UIView * grayView;

@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) KKAlterUserinfoView * alter_oneView;
@property (nonatomic, strong) KKDrawMoney_bindingView * bindingView;
@property (nonatomic, strong) UITextField * passwordTextField;
@property (nonatomic, strong) UILabel * promptLabel;



@end

@implementation KKDrawMoneyViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sendNetworking];
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];

    [self initUI];
}

#pragma mark - 系统代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.alter_oneView.textField) {

        
        //如果输入的是“.”  判断之前已经有"."或者字符串为空
        if ([string isEqualToString:@"."] && ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""])) {
            return NO;
        }
        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
        [str insertString:string atIndex:range.location];
        if (str.length >= [str rangeOfString:@"."].location+4){
            return NO;
        }
    
    }
    return YES;
}


#pragma mark - 点击事件
- (void)confirmButtonClicked {
    
    CGFloat drawMoney = [self.alter_oneView.textField.text floatValue];
    if (drawMoney < 100) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请正确输入提现金额" cancle:^{}];
        return;
    }
    
    [self seeBankPasswordStatus];
}
- (void)keyboardConfirmClicked {
    NSLog(@"退出键盘");
    [self.alter_oneView.textField resignFirstResponder];
}

- (void)binding_exitButton {
    [self.bindingView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bing_confirmButton {
    KKBingingBankcardViewController * binding = [[KKBingingBankcardViewController alloc] init];
    [self.navigationController pushViewController:binding animated:YES];
}

#pragma mark - 网络请求

- (void)sendNetworking {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/user-info"];
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSString * balance = data[@"balance"];
        
        NSString * moneyStr = [NSString stringWithFormat:@"  余额: %@元",balance];
        [self.moneyButton setTitle:moneyStr forState:UIControlStateNormal];
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}

//查看银行卡密码状
-(void)seeBankPasswordStatus{
    NSString * token = [MCTool BSGetUserinfo_token];
    if(token.length <= 0){return;}
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/user-info"];
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:[MCTool getCurrentVC] isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSInteger bank_status = [data[@"bank_passwd_status"] integerValue];
        if (bank_status == 1){
            [self sendNetWorking_checkBank];
        }else{
            UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:nil message:@"您还没有设置提现密码，请先设置！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            alertView.delegate = self;
            alertView.tag = 1;
            [alertView show];
        }
    } dislike:^(id data) {
    } failure:^(NSError *error) { }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
            KKAlterDrawMoneyViewController * drawMoney = [[KKAlterDrawMoneyViewController alloc] init];
            [self.navigationController pushViewController:drawMoney animated:YES];
        }else{
            [self bing_confirmButton];
        }
    }
}

- (void)sendNetWorking_checkBank {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/bank-info"];
    NSDictionary * parameter = @{};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSInteger bank_status = [data[@"bank_status"] integerValue];
        if (bank_status == 1) {
            [self confirmPassword];
        } else {
            
            UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:nil message:@"您当前未绑定银行卡，请先绑定！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去绑定", nil];
            alertView.delegate = self;
            alertView.tag = 2;
            [alertView show];
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}

- (void)sendNetworking_drawMoney {

    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user-info/withdraw-cash"];
    

    
    NSDictionary * parameter = @{
                                 @"bank_passwd" : [self.passwordTextField.text md5Encrypt],
                                 @"money"       : self.alter_oneView.textField.text
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            [MCView BSAlertController_oneOption_viewController:self message:@"申请成功" cancle:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
//       
    }];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"提现";

}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.moneyButton];
    [self.moneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(20);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(68);
    }];
    
    [self.view addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.moneyButton.mas_bottom).with.offset(0);
        make.height.mas_equalTo(7);
    }];
    
    [self.view addSubview:self.alter_oneView];
    [self.alter_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.grayView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];
    
    [self.view addSubview:self.promptLabel];
    [self.promptLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.alter_oneView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-10);
        make.bottom.mas_equalTo(self.view).with.offset(-10);
        make.height.mas_equalTo(44);
    }];
}

- (void)confirmPassword {
    
    UIAlertController * altert = [UIAlertController alertControllerWithTitle:@"输入提现密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 提现接口
        [self sendNetworking_drawMoney];
    }];
    [altert addAction:cancel];
    [altert addAction:confirm];
    
    [altert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输出提现密码";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.secureTextEntry = YES;
        self.passwordTextField = textField;
    }];
    
    [self presentViewController:altert animated:YES completion:nil];
}



#pragma mark - setter & getter
- (UIButton *)moneyButton {
    if (_moneyButton == nil) {
        self.moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moneyButton.frame = CGRectMake(20, 0, MCScreenWidth - 20, 68);
        self.moneyButton.titleLabel.font = MCFont(16);
        [self.moneyButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.moneyButton setImage:[UIImage imageNamed:@"balance"] forState:UIControlStateNormal];
        self.moneyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.moneyButton.userInteractionEnabled = NO;
    } return _moneyButton;
}

- (UIView *)grayView {
    if (_grayView == nil) {
        self.grayView = [[UIView alloc] init];
        self.grayView.backgroundColor = MCMineTableViewBgColor;
    } return _grayView;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.backgroundColor = MCUIColorMain;
        self.confirmButton.layer.masksToBounds = YES;
        self.confirmButton.layer.cornerRadius = 5;
        self.confirmButton.titleLabel.font = MCFont(17);
        [self.confirmButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}

- (KKAlterUserinfoView *)alter_oneView {
    if (_alter_oneView == nil) {
        self.alter_oneView = [[KKAlterUserinfoView alloc] init];
        self.alter_oneView.backgroundColor = MCMineTableCellBgColor;
        self.alter_oneView.titleLabel.text = @"提现金额";
        self.alter_oneView.textField.placeholder = @"请输入提现金额";
        self.alter_oneView.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.alter_oneView.textField.delegate = self;
        
        
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

- (KKDrawMoney_bindingView *)bindingView {
    if (_bindingView == nil) {
        self.bindingView = [[KKDrawMoney_bindingView alloc] init];
        self.bindingView.backgroundColor = MCMineTableCellBgColor;
        [self.bindingView.exitButton addTarget:self action:@selector(binding_exitButton) forControlEvents:UIControlEventTouchUpInside];
        [self.bindingView.bindingButton addTarget:self action:@selector(bing_confirmButton) forControlEvents:UIControlEventTouchUpInside];
    } return _bindingView;
}
- (UILabel *)promptLabel {
    if (_promptLabel == nil) {
        self.promptLabel = [[UILabel alloc] init];
        self.promptLabel.textColor = MCUIColorMiddleGray;
        self.promptLabel.text = @"    提现金额最低100元";
        self.promptLabel.font = MCFont(12);
    } return _promptLabel;
}

@end
