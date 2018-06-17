//
//  KKAlterUserinfoView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAlterUserinfoView.h"

@interface KKAlterUserinfoView ()
<
UITextFieldDelegate
>


@end

@implementation KKAlterUserinfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self endEditing:YES];
    return YES;
}


- (void)addSubviews {

    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.offset(10);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self).with.offset(10);
    }];
    
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self).with.offset(-10);
    }];
}

#pragma mark - seter & getter 
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = MCFont(17);
        self.titleLabel.textColor = MCUIColorMain;
    } return _titleLabel;
}

- (UITextField *)textField {
    if (_textField == nil) {
        self.textField = [[UITextField alloc] init];
        self.textField.backgroundColor = MCUIColorFromRGB(0xE0CBC2);
        self.textField.layer.masksToBounds = YES;
        self.textField.layer.cornerRadius = 5;
        self.textField.font = MCFont(14);
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.delegate = self;
    //    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 10, 10);
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.leftView = view;
    } return _textField;
}

@end
