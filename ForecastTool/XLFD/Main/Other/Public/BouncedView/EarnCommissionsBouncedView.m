//
//  EarnCommissionsBouncedView.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/13.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "EarnCommissionsBouncedView.h"

@interface EarnCommissionsBouncedView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *whiteBGView;

@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *noteBtn;

@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UILabel *singleAmountLabel;

@property (nonatomic, strong) UILabel *numberTitleLabel;
@property (nonatomic, strong) UIButton *uncoverPublishBtn;
@property (nonatomic, strong) UIButton *followPublishBtn;

@property (nonatomic, strong) UILabel *honorSetTitleLabel;
@property (nonatomic, strong) UITextField *honorSetContentTextField;

@property (nonatomic, strong) UILabel *estimatedEarningsTitleLabel;
@property (nonatomic, strong) UITextField *estimatedEarningsContentTextField;
@property (nonatomic, strong) UILabel *estimatedEarningsContentLabel;

@property (nonatomic, strong) UILabel *instructionsTitleLabel;
@property (nonatomic, strong) UITextView *instructionsContentTextView;
@property (nonatomic, strong) UILabel *placeholder;
@property (nonatomic, strong) UILabel *instructionsRemarksLabel;

@property (nonatomic, strong) UIButton *giveUpBtn;
@property (nonatomic, strong) UIButton *initiatedBtn;

@property (nonatomic, strong) UILabel *remarksLabel;
@property (nonatomic, strong) UILabel *stirngLenghLabel;

@end

@implementation EarnCommissionsBouncedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(305, 400));
    }];
    
//    [self.whiteView addSubview:self.whiteBGView];
//    [self.whiteBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self);
//    }];
//
//    [self.whiteView addSubview:self.titleView];
    
    [self.whiteView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.whiteView).with.offset(22);
        make.height.mas_equalTo(25);
    }];
    
    [self.whiteView addSubview:self.noteBtn];
    [self.noteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.whiteView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
//    [self.whiteView addSubview:self.middleView];
//    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleView.mas_bottom);
//        make.left.right.equalTo(self.whiteView);
//        make.height.mas_equalTo(30);
//    }];
    
//    [self.middleView addSubview:self.totalMoneyLabel];
//    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.middleView).offset(5);
//        make.left.equalTo(self.middleView).offset(20);
//        make.bottom.equalTo(self.middleView).offset(-5);
//    }];
    
//    [self.middleView addSubview:self.singleAmountLabel];
//    [self.singleAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.middleView).offset(5);
//        make.right.equalTo(self.middleView).offset(-20);
//        make.bottom.equalTo(self.middleView).offset(-5);
//    }];
    
    
    
    [self.whiteView addSubview:self.numberTitleLabel];
    [self.numberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.equalTo(self.whiteView).offset(20);
    }];

    [self.whiteView addSubview:self.uncoverPublishBtn];
    [self.uncoverPublishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numberTitleLabel);
        make.left.mas_equalTo(self.numberTitleLabel.mas_right).mas_offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(36);
    }];
    
    [self.whiteView addSubview:self.followPublishBtn];
    [self.followPublishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numberTitleLabel);
        make.left.mas_equalTo(self.uncoverPublishBtn.mas_right).mas_offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(36);
    }];
    
    [self.whiteView addSubview:self.honorSetTitleLabel];
    [self.honorSetTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.uncoverPublishBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.numberTitleLabel);
    }];
    [self.whiteView addSubview:self.honorSetContentTextField];
    [self.honorSetContentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.honorSetTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.honorSetTitleLabel);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    UILabel *persentsLabel = [UILabel new];
    [self.whiteView addSubview:persentsLabel];
    [persentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.honorSetContentTextField.mas_right).mas_offset(2);
        make.centerY.equalTo(self.honorSetContentTextField);
    }];
    persentsLabel.text = @"%";
    persentsLabel.font = MCFont(16);
    persentsLabel.textColor = [UIColor blackColor];
    
    [self.whiteView addSubview:self.estimatedEarningsTitleLabel];
    [self.estimatedEarningsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(persentsLabel.mas_right).offset(10);
        make.centerY.equalTo(self.honorSetContentTextField);
    }];
    [self.whiteView addSubview:self.estimatedEarningsContentTextField];
    [self.estimatedEarningsContentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.estimatedEarningsTitleLabel.mas_right).offset(2);
        make.centerY.equalTo(self.estimatedEarningsTitleLabel);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.whiteView addSubview:self.estimatedEarningsContentLabel];
    [self.estimatedEarningsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.estimatedEarningsContentTextField.mas_right).offset(2);
        make.centerY.equalTo(self.estimatedEarningsContentTextField);
    }];
    
    [self.whiteView addSubview:self.instructionsTitleLabel];
    [self.instructionsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.honorSetTitleLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.honorSetTitleLabel);
    }];
    [self.whiteView addSubview:self.instructionsContentTextView];
    [self.instructionsContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.honorSetContentTextField.mas_bottom).offset(10);
        make.right.equalTo(self.estimatedEarningsContentLabel);
        make.left.equalTo(self.honorSetContentTextField);
        make.height.mas_equalTo(80);
    }];
    
    _placeholder = [[UILabel alloc]initWithFrame:CGRectMake(3, 2, 200, 20)];
    _placeholder.enabled = NO;
    _placeholder.text = @"潜心研究了这组跟单，跟我必胜!";
    _placeholder.font =  MCFont(12);
    _placeholder.textColor = MCUIColorMain;
    [self.instructionsContentTextView addSubview:_placeholder];
    
    [self.whiteView addSubview:self.stirngLenghLabel];
    [self.stirngLenghLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.instructionsContentTextView.mas_left).mas_offset(-5);
        make.bottom.mas_equalTo(self.instructionsContentTextView);
    }];
    
    [self.whiteView addSubview:self.instructionsRemarksLabel];
    [self.instructionsRemarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.instructionsContentTextView.mas_bottom).offset(5);
        make.left.equalTo(self.instructionsContentTextView);
        make.right.mas_equalTo(-10);
    }];
    NSInteger padding = 40;
    [self.whiteView addSubview:self.giveUpBtn];
    [self.whiteView addSubview:self.initiatedBtn];
    [@[self.giveUpBtn, self.initiatedBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
    [@[self.giveUpBtn, self.initiatedBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.instructionsRemarksLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [self.whiteView addSubview:self.remarksLabel];
    [self.remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.giveUpBtn.mas_bottom).offset(10);
        make.left.equalTo(self.whiteView).offset(10);
        make.right.equalTo(self.whiteView).offset(-2);
        make.bottom.equalTo(self.whiteView).offset(-10);
    }];
    
    NSMutableArray *settingInfor = [[NSUserDefaults standardUserDefaults]objectForKey:@"EarnCommisonInfor"];
    if(settingInfor && settingInfor.count){
        self.honorSetContentTextField.text = settingInfor[0];
        self.estimatedEarningsContentTextField.text = settingInfor[1];
        if(!kStringIsEmpty(settingInfor[2])){
            self.instructionsContentTextView.text = settingInfor[2];
            _placeholder.hidden = YES;
        }
    }
}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    self.placeholder.hidden = YES;
    //允许提交按钮点击操作
    //实时显示字数
    self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/100", (unsigned long)textView.text.length];
    
    //字数限制操作
    if (textView.text.length >= 100) {
        textView.text = [textView.text substringToIndex:100];
        self.stirngLenghLabel.text = @"100/100";
    }
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.placeholder.hidden = NO;
    }
}

#pragma mark - 点击

-(void)didClickFollowOrUncoverBtn:(UIButton *)sender{
    self.uncoverPublishBtn.selected = !self.uncoverPublishBtn.selected;
    self.followPublishBtn.selected = !self.followPublishBtn.selected;
}

- (void)noteBtnClick {
    NSString *commissionsUrl = [MCTool BSGetObjectForKey:BSConfig_gd_helper_url];
    if(!kStringIsEmpty(commissionsUrl)){
        MCH5ViewController * h5 = [[MCH5ViewController alloc] init];
        h5.url = commissionsUrl;
        h5.title = @"发起跟单说明";
        if([self.delegate isKindOfClass:[UIViewController class]]){
            UIViewController *VC = (UIViewController *)self.delegate;
            [VC.navigationController pushViewController:h5 animated:YES];
        }
    }
}

-(void)giveUpButtonClick {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(didClickCancelBtn)]) {
        [self.delegate didClickCancelBtn];
    }
    [self removeSelf];
}

-(void)initiatedButtonClick{
    
    if(kStringIsEmpty(self.honorSetContentTextField.text)){
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:@"请填写酬金金额"];
        return;
    }
    
    if(self.honorSetContentTextField.text.integerValue > 10){
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:@"酬金金额不能大于10"];
        self.honorSetContentTextField.text = @"10";
        return;
    }
    
    if(kStringIsEmpty(self.estimatedEarningsContentTextField.text)){
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:@"请填写收益倍数"];
        return;
    }
    
    if(self.estimatedEarningsContentTextField.text.integerValue > 100){
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:@"收益倍数不能大于100"];
        self.estimatedEarningsContentTextField.text = @"100";
        return;
    }
    
    if(self.instructionsContentTextView.text.length > 100){
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:@"输入内容不能过长"];
        return;
    }
    
    
    NSMutableArray *settingInfor = [NSMutableArray array];
    [settingInfor addObject:self.honorSetContentTextField.text];
    [settingInfor addObject:self.estimatedEarningsContentTextField.text];
    NSString *contetnt = @"";
    if(!kStringIsEmpty(self.instructionsContentTextView.text) || !kStringIsEmpty([self.instructionsContentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""])){
        contetnt = self.instructionsContentTextView.text;
    }
    [settingInfor addObject:contetnt];
    [[NSUserDefaults standardUserDefaults]setObject:settingInfor forKey:@"EarnCommisonInfor"];
    
    if(kStringIsEmpty(self.instructionsContentTextView.text) || kStringIsEmpty([self.instructionsContentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""])){
        self.instructionsContentTextView.text = self.placeholder.text;
    }
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(didClickConfirmBtnWithCommission:rate:content:isUncoverPublish:)]) {
        [self.delegate didClickConfirmBtnWithCommission:[self.honorSetContentTextField.text integerValue]rate:[self.estimatedEarningsContentTextField.text integerValue] content:self.instructionsContentTextView.text isUncoverPublish:self.uncoverPublishBtn.selected];
    }
    [self removeSelf];
}

- (void)removeSelf {
    [self removeFromSuperview];
}

#pragma mark - get

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc] init];
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.image = [UIImage imageNamed:@"follow-alert1-bg"];
        [self.whiteView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
    } return _whiteView;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = MCFont(20);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"发起跟单";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)noteBtn {
    if (_noteBtn == nil) {
        _noteBtn = [[UIButton alloc] init];
        _noteBtn.adjustsImageWhenHighlighted = NO;
        _noteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_noteBtn setImage:[UIImage imageNamed:@"icon-lotterydetail-note"] forState: UIControlStateNormal];
        [_noteBtn addTarget:self action:@selector(noteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteBtn;
}

- (UIView *)middleView {
    if (_middleView == nil) {
        _middleView = [[UIView alloc] init];
        _middleView.backgroundColor = [UIColor colorWithRed:19/255.0 green:67/255.0 blue:42/255.0 alpha:1.0f];
    }
    return _middleView;
}

- (UILabel *)totalMoneyLabel {
    if (_totalMoneyLabel == nil) {
        _totalMoneyLabel = [[UILabel alloc] init];
        _totalMoneyLabel.font = MCFont(14);
        _totalMoneyLabel.text = @"方案总额:984930元";
        _totalMoneyLabel.textColor = [UIColor blackColor];
        _totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
        [_totalMoneyLabel sizeToFit];
    }
    return _totalMoneyLabel;
}

- (UILabel *)singleAmountLabel {
    if (_singleAmountLabel == nil) {
        _singleAmountLabel = [[UILabel alloc] init];
        _singleAmountLabel.font = MCFont(14);
        _singleAmountLabel.text = @"单倍金额:8元";
        _singleAmountLabel.textColor = [UIColor blackColor];
        _singleAmountLabel.textAlignment = NSTextAlignmentRight;
        [_singleAmountLabel sizeToFit];
    }
    return _singleAmountLabel;
}

- (UILabel *)numberTitleLabel {
    if (_numberTitleLabel == nil) {
        _numberTitleLabel = [[UILabel alloc] init];
        _numberTitleLabel.font = MCFont(16);
        _numberTitleLabel.text = @"方案公开:";
        _numberTitleLabel.textColor = [UIColor blackColor];
        _numberTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_numberTitleLabel sizeToFit];
    }
    return _numberTitleLabel;
}

- (UILabel *)honorSetTitleLabel {
    if (_honorSetTitleLabel == nil) {
        _honorSetTitleLabel = [[UILabel alloc] init];
        _honorSetTitleLabel.font = MCFont(16);
        _honorSetTitleLabel.text = @"酬金设置:";
        _honorSetTitleLabel.textColor = [UIColor blackColor];
        _honorSetTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_honorSetTitleLabel sizeToFit];
    }
    return _honorSetTitleLabel;
}

- (UITextField *)honorSetContentTextField {
    if (_honorSetContentTextField == nil) {
        _honorSetContentTextField = [[UITextField alloc] init];
        _honorSetContentTextField.backgroundColor = MCUIColorLighttingBrown;
        _honorSetContentTextField.layer.cornerRadius = 3;
        _honorSetContentTextField.layer.masksToBounds = YES;
        _honorSetContentTextField.textAlignment = NSTextAlignmentCenter;
        _honorSetContentTextField.keyboardType = UIKeyboardTypeNumberPad;
        _honorSetContentTextField.textColor = MCUIColorMain;
    }
    return _honorSetContentTextField;
}

- (UILabel *)estimatedEarningsTitleLabel {
    if (_estimatedEarningsTitleLabel == nil) {
        _estimatedEarningsTitleLabel = [[UILabel alloc] init];
        _estimatedEarningsTitleLabel.font = MCFont(16);
        _estimatedEarningsTitleLabel.text = @"预计收益:";
        _estimatedEarningsTitleLabel.textColor = [UIColor blackColor];
        _estimatedEarningsTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_estimatedEarningsTitleLabel sizeToFit];
    }
    return _estimatedEarningsTitleLabel;
}

- (UITextField *)estimatedEarningsContentTextField {
    if (_estimatedEarningsContentTextField == nil) {
        _estimatedEarningsContentTextField = [[UITextField alloc] init];
        _estimatedEarningsContentTextField.backgroundColor = MCUIColorLighttingBrown;
        _estimatedEarningsContentTextField.layer.cornerRadius = 3;
        _estimatedEarningsContentTextField.layer.masksToBounds = YES;
        _estimatedEarningsContentTextField.textAlignment = NSTextAlignmentCenter;
        _estimatedEarningsContentTextField.keyboardType  = UIKeyboardTypeNumberPad;
        _estimatedEarningsContentTextField.textColor = MCUIColorMain;
    }
    return _estimatedEarningsContentTextField;
}

- (UILabel *)estimatedEarningsContentLabel {
    if (_estimatedEarningsContentLabel == nil) {
        _estimatedEarningsContentLabel = [[UILabel alloc] init];
        _estimatedEarningsContentLabel.font = MCFont(16);
        _estimatedEarningsContentLabel.text = @"倍";
        _estimatedEarningsContentLabel.textColor = [UIColor blackColor];
        _estimatedEarningsContentLabel.textAlignment = NSTextAlignmentLeft;
        [_estimatedEarningsContentLabel sizeToFit];
    }
    return _estimatedEarningsContentLabel;
}

- (UILabel *)instructionsTitleLabel {
    if (_instructionsTitleLabel == nil) {
        _instructionsTitleLabel = [[UILabel alloc] init];
        _instructionsTitleLabel.font = MCFont(16);
        _instructionsTitleLabel.text = @"跟单说明:";
        _instructionsTitleLabel.textColor = [UIColor blackColor];
        _instructionsTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_instructionsTitleLabel sizeToFit];
    }
    return _instructionsTitleLabel;
}

- (UITextView *)instructionsContentTextView {
    if (_instructionsContentTextView == nil) {
        _instructionsContentTextView = [[UITextView alloc] init];
        _instructionsContentTextView.backgroundColor = MCUIColorLighttingBrown;
        _instructionsContentTextView.layer.cornerRadius = 3;
        _instructionsContentTextView.layer.masksToBounds = YES;
        _instructionsContentTextView.delegate =self;
        _instructionsContentTextView.font = MCFont(12);
        _instructionsContentTextView.textColor = MCUIColorMain;
    }
    return _instructionsContentTextView;
}

-(UILabel *)stirngLenghLabel{
    if(!_stirngLenghLabel){
        _stirngLenghLabel = [UILabel new];
        _stirngLenghLabel.font = MCFont(12);
        _stirngLenghLabel.text = @"0/100";
        _stirngLenghLabel.textColor = MCUIColorMain;
    }
    return _stirngLenghLabel;
}

- (UILabel *)instructionsRemarksLabel {
    if (_instructionsRemarksLabel == nil) {
        _instructionsRemarksLabel = [[UILabel alloc] init];
        _instructionsRemarksLabel.font = MCFont(9);
        _instructionsRemarksLabel.text = @"跟单说明很重要，玩家将从您的描述中决定是否购买，请您认真填写！";
        _instructionsRemarksLabel.textColor = MCUIColorLighttingBrown;
        _instructionsRemarksLabel.textAlignment = NSTextAlignmentLeft;
        _instructionsRemarksLabel.numberOfLines = 0;
        [_instructionsRemarksLabel sizeToFit];
    }
    return _instructionsRemarksLabel;
}

- (UIButton *)giveUpBtn {
    if (_giveUpBtn == nil) {
        _giveUpBtn = [[UIButton alloc] init];
        [_giveUpBtn setTitle:@"放弃发起" forState:UIControlStateNormal];
        _giveUpBtn.titleLabel.font = MCFont(18);
        [_giveUpBtn setTitleColor:MCUIColorFromRGB(0x848484) forState:UIControlStateNormal];
        _giveUpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_giveUpBtn setBackgroundImage:[UIImage imageNamed:@"follow-alert-cancle"] forState:UIControlStateNormal];
        [_giveUpBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
        [_giveUpBtn addTarget:self action:@selector(giveUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giveUpBtn;
}

- (UIButton *)initiatedBtn {
    if (_initiatedBtn == nil) {
        _initiatedBtn = [[UIButton alloc] init];
        [_initiatedBtn setTitle:@"确认" forState:UIControlStateNormal];
        _initiatedBtn.titleLabel.font = MCFont(18);
        _initiatedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_initiatedBtn setTitleColor:MCUIColorFromRGB(0x9A6424) forState:UIControlStateNormal];
        [_initiatedBtn setBackgroundImage:[UIImage imageNamed:@"follow-alert-confirm"] forState:UIControlStateNormal];
        [_initiatedBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
        [_initiatedBtn addTarget:self action:@selector(initiatedButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _initiatedBtn;
}

- (UILabel *)remarksLabel {
    if (_remarksLabel == nil) {
        _remarksLabel = [[UILabel alloc] init];
        _remarksLabel.font = MCFont(12);
        _remarksLabel.text = @"温馨提示:您可以在我的-跟单列表界面查看跟单明细\n发起跟单将会在您成功付款后展示";
        _remarksLabel.textColor = MCUIColorLighttingBrown;
        _remarksLabel.textAlignment = NSTextAlignmentLeft;
        _remarksLabel.numberOfLines = 0;
    }
    return _remarksLabel;
}

-(UIButton *)followPublishBtn{
    if(!_followPublishBtn){
        _followPublishBtn = [UIButton new];
        [_followPublishBtn setTitle:@"跟单后" forState:UIControlStateNormal];
        _followPublishBtn.titleLabel.font = MCFont(16);
        [_followPublishBtn setTitleColor:MCUIColorMain forState:UIControlStateSelected];
        [_followPublishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_followPublishBtn setBackgroundImage:[UIImage imageNamed:@"发起跟单"] forState:UIControlStateSelected];
        [_followPublishBtn addTarget:self action:@selector(didClickFollowOrUncoverBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followPublishBtn;
}

-(UIButton *)uncoverPublishBtn{
    if(!_uncoverPublishBtn){
        _uncoverPublishBtn = [UIButton new];
        [_uncoverPublishBtn setTitle:@"结束后" forState:UIControlStateNormal];
        _uncoverPublishBtn.titleLabel.font = MCFont(16);
        _uncoverPublishBtn.selected = YES;
        [_uncoverPublishBtn setTitleColor:MCUIColorMain forState:UIControlStateSelected];
        [_uncoverPublishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_uncoverPublishBtn setBackgroundImage:[UIImage imageNamed:@"发起跟单"] forState:UIControlStateSelected];
        [_uncoverPublishBtn addTarget:self action:@selector(didClickFollowOrUncoverBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uncoverPublishBtn;
}


@end
