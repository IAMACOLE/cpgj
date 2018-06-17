//
//  KKUserNickNameViewController.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKUserNickNameViewController.h"
#import "KKNewUserInfoView.h"

@interface KKUserNickNameViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)KKNewUserInfoView *textFiledView;
@property (nonatomic, strong)UIButton *saveButton;

@end

@implementation KKUserNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
//    [self sendNetWorking];
    [self initUI];
}

#pragma mark - 系统代理


#pragma mark - 基本设置
- (void)basicSetting {
    self.view.backgroundColor = MCMineTableCellBgColor;
    self.titleString = @"昵称修改";
}

#pragma mark - 网络设置
- (void)sendNetWorking {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP,@"user/edit-nickname"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSString *nickNameStr = self.textFiledView.textField.text;
    NSDictionary *param = @{
                            @"user_token": token,
                            @"nick_name": nickNameStr
                            };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        NSDictionary * userinfoDic = [MCTool BSGetObjectForKey:BSUserinfo];
        NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithDictionary:userinfoDic];
        [dictM setObject:nickNameStr forKey:BSUserinfo_nick_name];
        [MCTool BSSetObject:dictM forKey:BSUserinfo];
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"修改成功"];
//        [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
      
    }];
}

#pragma mark - 按钮点击
- (void)buttonClick {
    [self.textFiledView.textField resignFirstResponder];
    [self sendNetWorking];
}

#pragma mark - 配置UI
- (void)initUI {
    [self.view addSubview:self.textFiledView];
    [self.textFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiledView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - 懒加载
- (KKNewUserInfoView *)textFiledView {
    if (_textFiledView == nil) {
        _textFiledView = [[KKNewUserInfoView alloc] init];
        _textFiledView.textField.delegate = self;
        _textFiledView.textField.text = [MCTool BSGetUserinfo_nick_name];
        _textFiledView.textField.placeholder = @"昵称修改";
        _textFiledView.textField.keyboardType = UIKeyboardTypeDefault;
    }
    return _textFiledView;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
        return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 6) {
        return NO;
    }
    
    return YES;
}

- (UIButton *)saveButton {
    if (_saveButton == nil) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setBackgroundColor:MCUIColorMain];
        _saveButton.layer.cornerRadius = 3;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

@end
