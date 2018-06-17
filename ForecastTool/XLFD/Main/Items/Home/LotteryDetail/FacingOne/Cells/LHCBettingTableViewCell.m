 //
//  LHCBettingTableViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LHCBettingTableViewCell.h"


@interface LHCBettingTableViewCell ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UIView   * bgView;
@property (nonatomic, strong) UILabel  * titleLabel;
@property (nonatomic, strong) UILabel  * oddsLabel;      // 赔率odds
@property (nonatomic, strong) UILabel  * standardLabel;  // 规格
@property (nonatomic, strong) UIButton * deleteButton;
// 金额
@property (nonatomic, strong) UILabel * money_leftLabel;
@property (nonatomic, strong) UITextField * money_centerTextField;
@property (nonatomic, strong) UILabel * money_rightLabel;

@end

@implementation LHCBettingTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    } return self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
     _model.money = textField.text;
}
- (void)deleteButtonClicked {
    if (self.deleteBlock) {
        self.deleteBlock(self.cellRow);
    }
}

- (void)addSubviews {
    
    [self addSubview:self.bgView];
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 5, 0));
    }];
    
    [self.bgView addSubview:self.oddsLabel];
    [self.oddsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).with.offset(15);
        make.centerY.mas_equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oddsLabel);
        make.bottom.mas_equalTo(self.oddsLabel.mas_top).with.offset(-5);
    }];
    
    [self.bgView addSubview:self.standardLabel];
    [self.standardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oddsLabel);
        make.top.mas_equalTo(self.oddsLabel.mas_bottom).with.offset(3);
    }];
    
    [self.bgView addSubview:self.deleteButton];
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.top.mas_equalTo(self.bgView).with.offset(10);
       // make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.bgView addSubview:self.money_rightLabel];
    [self.money_rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).with.offset(-10);
        make.bottom.mas_equalTo(self.bgView).with.offset(-15);
    }];
    
    [self.bgView addSubview:self.money_centerTextField];
    [self.money_centerTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.money_rightLabel.mas_left).with.offset(-2);
        make.centerY.mas_equalTo(self.money_rightLabel);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [self.bgView addSubview:self.money_leftLabel];
    [self.money_leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.money_centerTextField.mas_left).with.offset(-2);
        make.centerY.mas_equalTo(self.money_rightLabel);
    }];
}

-(void)setModel:(LHCLotteryModel *)model{
    _model = model;
    self.titleLabel.text = model.pl_name;
    if ([model.money integerValue]>0) {
        self.money_centerTextField.text = model.money;
    }
    self.oddsLabel.text = [NSString stringWithFormat:@"赔率:%@",model.award_money];
    self.standardLabel.text = model.species;
    
}
-(void)keyboardConfirmClicked{
    [self.money_centerTextField endEditing:YES];
}
#pragma mark - Setter & Getter
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
    } return _bgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textColor = MCUIColorMain;
        self.titleLabel.text = @"绿波";
    } return _titleLabel;
}

- (UILabel *)oddsLabel {
    if (_oddsLabel == nil) {
        self.oddsLabel = [[UILabel alloc] init];
        self.oddsLabel.font = [UIFont systemFontOfSize:14];
        self.oddsLabel.textColor = [UIColor blackColor];
        self.oddsLabel.text = @"赔率: 23";
    } return _oddsLabel;
}

- (UILabel *)standardLabel {
    if (_standardLabel == nil) {
        self.standardLabel = [[UILabel alloc] init];
        self.standardLabel.font = [UIFont systemFontOfSize:14];
        self.standardLabel.textColor = [UIColor blackColor];
        self.standardLabel.text = @"7色波-种类";
    } return _standardLabel;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"Home_cancel"] forState:UIControlStateNormal];
       
        [self.deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _deleteButton;
}

- (UILabel *)money_leftLabel {
    if (_money_leftLabel == nil) {
        self.money_leftLabel = [[UILabel alloc] init];
        self.money_leftLabel.font = [UIFont systemFontOfSize:14];
        self.money_leftLabel.textColor = [UIColor blackColor];
        self.money_leftLabel.text = @"金额:";
    } return _money_leftLabel;
}

- (UITextField *)money_centerTextField {
    if (_money_centerTextField == nil) {
        self.money_centerTextField = [[UITextField alloc] init];
        self.money_centerTextField.backgroundColor = MCUIColorLighttingBrown;
        self.money_centerTextField.textAlignment = NSTextAlignmentCenter;
        self.money_centerTextField.placeholder = @"请输入金额";
        self.money_centerTextField.returnKeyType = UIReturnKeyDone;
        _money_centerTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.money_centerTextField.font = [UIFont systemFontOfSize:13];
        self.money_centerTextField.textColor = MCUIColorMain;
        self.money_centerTextField.delegate = self;
        [self.money_centerTextField setValue:MCMineTableCellBgColor forKeyPath:@"_placeholderLabel.textColor"];
         self.money_centerTextField.layer.cornerRadius = 4;
         self.money_centerTextField.layer.masksToBounds = YES;
        self.money_centerTextField.backgroundColor = MCUIColorLighttingBrown;
       
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, MCScreenWidth,44)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MCScreenWidth - 60, 7,50, 30)];
        [button setTitle:@"确认"forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyboardConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [bar addSubview:button];
        
        [bar layoutIfNeeded];
        [bar sendSubviewToBack:bar.subviews.lastObject];
        self.money_centerTextField.inputAccessoryView = bar;
        //       self.money_centerTextField.keyboardType = UIKeyboardTypeNumberPad;
    } return _money_centerTextField;
}

- (UILabel *)money_rightLabel {
    if (_money_rightLabel == nil) {
        self.money_rightLabel = [[UILabel alloc] init];
        self.money_rightLabel.font = [UIFont systemFontOfSize:14];
        self.money_rightLabel.textColor = [UIColor blackColor];
        self.money_rightLabel.text = @"元";
    } return _money_rightLabel;
}

@end
