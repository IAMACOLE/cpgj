//
//  KKSelectedBankView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKSelectedBankView.h"

@interface KKSelectedBankView ()


@end

@implementation KKSelectedBankView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)addSubviews {
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.offset(10);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self).with.offset(10);
    }];
    
    [self addSubview:self.bankButton];
    [self.bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).with.offset(10);
        make.right.mas_equalTo(self).with.offset(-10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - seter & getter
- (void)setBankNameStr:(NSString *)bankNameStr {
    [self.bankButton setTitle:[NSString stringWithFormat:@"  %@",bankNameStr] forState:UIControlStateNormal];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = MCFont(17);
        self.titleLabel.textColor = MCUIColorMain  ;
    } return _titleLabel;
}

- (UIButton *)bankButton {
    if (_bankButton == nil) {
        self.bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bankButton.backgroundColor = MCUIColorFromRGB(0xE0CBC2);
        self.bankButton.layer.masksToBounds = YES;
        self.bankButton.layer.cornerRadius = 5;
        self.bankButton.titleLabel.font = MCFont(14);
        [self.bankButton setTitle:@"  请选择银行开户行" forState:UIControlStateNormal];
        [self.bankButton setTitleColor:MCUIColorPlaceHolder forState:UIControlStateNormal];
        [self.bankButton setTitleColor:MCUIColorGray forState:UIControlStateSelected];

        self.bankButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } return _bankButton;
}

@end
