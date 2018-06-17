//
//  KKBingingBankcardViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBingingBankcardViewController.h"

#import "KKAlterUserinfoView.h"
#import "KKSelectedBankView.h"
#import "KKSelectedBank_popUpBoxView.h"

@interface KKBingingBankcardViewController ()
<
KKSelectedBankView_popUpBoxDelegate,
UITextFieldDelegate
>
{
    NSInteger _bank_status;
}
@property (nonatomic, strong) KKAlterUserinfoView * alter_oneView;
@property (nonatomic, strong) KKAlterUserinfoView * alter_twoView;
@property (nonatomic, strong) KKAlterUserinfoView * alter_threeView;
@property (nonatomic, strong) KKSelectedBankView  * selecetdBankView;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, strong) UIButton            * confirmButton;
@property (nonatomic, strong) KKSelectedBank_popUpBoxView * popUpBoxView;
@property (nonatomic, strong) NSMutableArray * bankNameArrayM;
@property (nonatomic, strong) NSMutableArray * bankFlagArrayM;
@property (nonatomic, assign) NSInteger _selectedBankIndex;

@end

@implementation KKBingingBankcardViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController.navigationBar setBackgroundImage:[MCTool MCImageWithColor:[UIColor colorWithRed:218/255.0 green:28/255.0 blue:54/255.0 alpha:1/1.0]] forBarMetrics:UIBarMetricsDefault];
//}

#pragma mark - 系统代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.view endEditing:YES];
    return YES;
}

#pragma mark - CustomDelegate
- (void)KKSelectedPickerViewRowShowIndex:(NSInteger)index {
    __selectedBankIndex = index;
}

#pragma mark - 点击事件
- (void)confirmButtonClicked {
    
    if (_bank_status == 1) {
        [MCView BSAlertController_oneOption_viewController:self message:@"已绑定银行卡,欲修改,请联系客服" cancle:^{
        }];
        return;
    }
    
    if (self.alter_oneView.textField.text.length == 0) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请填写真实姓名" cancle:^{
        }];
        return;
    }
    
    if ([self.selecetdBankView.bankButton.titleLabel.text isEqualToString:@"    请您选择开户行"]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请选择开户行" cancle:^{
        }];
        return;
    }
    
    
    if (self.alter_threeView.textField.text.length == 0) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请填写提现银行卡卡号" cancle:^{
        }];
        return;
    }
    
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/bind-bank"];
    
    NSDictionary * parameter = @{
                                 @"user_name"      : self.alter_oneView.textField.text,
                                 @"bank_no"        : self.bankFlagArrayM[__selectedBankIndex],
                                 @"bank_branch_no" : self.alter_twoView.textField.text,
                                 @"account_no"     : self.alter_threeView.textField.text
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BSNotification_reloadPersonalInformation object:nil];
            
            [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"绑定成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}

- (void)bankButtonclicked {
    
    [self.view endEditing:YES];
    [self.view.window addSubview:self.popUpBoxView];
    [self.popUpBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view.window);
    }];
    
    [self.popUpBoxView setPickerViewDataWith:self.bankNameArrayM];
    [self.popUpBoxView.pickerView reloadAllComponents];
}

- (void)popUpBox_confirmClicked {
    [self.selecetdBankView.bankButton setTitle:[NSString stringWithFormat:@"  %@",self.bankNameArrayM[__selectedBankIndex]] forState:UIControlStateNormal];
    self.selecetdBankView.bankButton.selected = YES;
    [self.popUpBoxView removeFromSuperview];
    self.popUpBoxView = nil;
}

- (void)keyboardConfirmClicked {
    [self.view endEditing:YES];
}

- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.bankFlagArrayM removeAllObjects];
    [self.bankNameArrayM removeAllObjects];
    [self sendNetWorking_getAllBankList];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    [self sendNetWorking_getAllBankList];
    
    [self sendNetWorking_searchInfomationOfBindingBank];
}

- (void)sendNetWorking_searchInfomationOfBindingBank {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/bank-info"];

    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSInteger bank_status = [data[@"bank_status"] integerValue];
        
        if (bank_status == 0) {  // 未绑定
            _bank_status = 0;
        } else {                 // 绑定了
            _bank_status = 1;
            self.titleString = @"银行卡信息";
            self.confirmButton.backgroundColor = MCUIColorMiddleGray;
            
            NSString * user_name = data[@"user_name"];
            NSString * bank_no = data[@"bank_no"];
            NSString * bank_branch_no = data[@"bank_branch_no"];
            NSString * account_no = data[@"account_no"];
            
            if (bank_branch_no.length == 0) {
                bank_branch_no = @"未填写开户支行信息";
            }
            
            self.alter_oneView.textField.text = user_name;
            self.alter_oneView.textField.enabled = NO;
            self.alter_twoView.textField.text = bank_branch_no;
            self.alter_twoView.textField.enabled = NO;
            self.alter_threeView.textField.text = account_no;
            self.alter_threeView.textField.enabled = NO;
            [self.selecetdBankView setBankNameStr:bank_no];
            self.selecetdBankView.bankButton.selected = YES;
            self.selecetdBankView.bankButton.userInteractionEnabled = NO;
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}

- (void)sendNetWorking_getAllBankList {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"config/bank-list"];
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
        NSArray * dataArray = (NSArray *)data;
        
        for (NSDictionary * dict in dataArray) {
            
            NSString * name = dict[@"name"];
            NSString * flag = dict[@"flag"];
            [self.bankNameArrayM addObject:name];
            [self.bankFlagArrayM addObject:flag];
            
            [self.popUpBoxView setPickerViewDataWith:self.bankNameArrayM];
            [self.popUpBoxView.pickerView reloadAllComponents];
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        [self setIsShow404View:YES];
    }];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"绑定银行卡";
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
    
    [self.view addSubview:self.selecetdBankView];
    [self.selecetdBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.alter_oneView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(94);
    }];

    [self.view addSubview:self.alter_twoView];
    [self.alter_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.selecetdBankView.mas_bottom).with.offset(0);
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

- (KKAlterUserinfoView *)alter_oneView {
    if (_alter_oneView == nil) {
        self.alter_oneView = [[KKAlterUserinfoView alloc] init];
        self.alter_oneView.backgroundColor = MCMineTableCellBgColor;
        self.alter_oneView.titleLabel.text = @"真实姓名";
        self.alter_oneView.textField.placeholder = @"请输入您的真实姓名";
        self.alter_oneView.textField.delegate = self;
        self.alter_oneView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    } return _alter_oneView;
}

- (KKAlterUserinfoView *)alter_twoView {
    if (_alter_twoView == nil) {
        self.alter_twoView = [[KKAlterUserinfoView alloc] init];
        self.alter_twoView.backgroundColor = MCMineTableCellBgColor;
        self.alter_twoView.titleLabel.text = @"开户支行";
        self.alter_twoView.textField.placeholder = @"请输入您的开户支行";
        self.alter_twoView.textField.delegate = self;
        self.alter_twoView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    } return _alter_twoView;
}

- (KKAlterUserinfoView *)alter_threeView {
    if (_alter_threeView == nil) {
        self.alter_threeView = [[KKAlterUserinfoView alloc] init];
        self.alter_threeView.backgroundColor = MCMineTableCellBgColor;
        self.alter_threeView.titleLabel.text = @"确认提现银行卡";
        self.alter_threeView.textField.placeholder = @"请输入您的银行卡卡号";
        self.alter_threeView.textField.delegate = self;
        self.alter_threeView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;

        self.alter_threeView.textField.keyboardType = UIKeyboardTypeNumberPad;
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, MCScreenWidth,44)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MCScreenWidth - 60, 7,50, 30)];
        [button setTitle:@"确认"forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyboardConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [bar addSubview:button];
        [bar layoutIfNeeded];
        [bar sendSubviewToBack:bar.subviews.lastObject];

        self.alter_threeView.textField.inputAccessoryView = bar;
    } return _alter_threeView;
}

- (KKSelectedBankView *)selecetdBankView {
    if (_selecetdBankView == nil) {
        self.selecetdBankView = [[KKSelectedBankView alloc] init];
        self.selecetdBankView.backgroundColor = MCMineTableCellBgColor;
        self.selecetdBankView.titleLabel.text = @"银行开户行";
        [self.selecetdBankView.bankButton addTarget:self action:@selector(bankButtonclicked) forControlEvents:UIControlEventTouchUpInside];
    } return _selecetdBankView;
}

- (KKSelectedBank_popUpBoxView *)popUpBoxView {
    if (_popUpBoxView == nil) {
        self.popUpBoxView = [[KKSelectedBank_popUpBoxView alloc] init];
        self.popUpBoxView.backgroundColor = [UIColor clearColor];
        self.popUpBoxView.customDelegate = self;
        [self.popUpBoxView.confirmButton addTarget:self action:@selector(popUpBox_confirmClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _popUpBoxView;
}

- (NSMutableArray *)bankNameArrayM {
    if (_bankNameArrayM == nil) {
        self.bankNameArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _bankNameArrayM;
}

- (NSMutableArray *)bankFlagArrayM {
    if (_bankFlagArrayM == nil) {
        self.bankFlagArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _bankFlagArrayM;
}

@end
