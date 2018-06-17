//
//  ChaseLotteryFooterView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/6.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "ChaseLotteryFooterView.h"
#import "KKBettingSelectedTableViewCell.h"
@interface ChaseLotteryFooterView()

@property(nonatomic,strong)UIButton *immediatelyChaseButton;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIImageView *boomBGView;
@property(nonatomic,strong)UIView *topBGView;
//@property(nonatomic,strong)UIButton * stopChaseNoteButton;
@property(nonatomic,strong)UILabel *totalLabel;
@property(nonatomic,strong)UILabel *selectedNumLabel;
@property(nonatomic,assign)BOOL isSelectedLabel;

@end
@implementation ChaseLotteryFooterView

- (void)drawRect:(CGRect)rect {
    
    [self addSubview:self.topBGView];
    [self.topBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    
    [self addSubview:self.boomBGView];
    
    [self.boomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.topBGView.mas_bottom).with.offset(0);
    }];
    
    [self addSubview:self.selectedNumLabel];
    [self.selectedNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(MCScreenWidth/2);
    }];
//    [self.selectedNumLabel sizeToFit];
    
//    [self addSubview:self.chooseNumButton];
//    [self.chooseNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.selectedNumLabel.mas_right);
//        make.top.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
    [self addSubview:self.stopChaseButton];
    [self.stopChaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(135), 25));
    }];
    
//    [self addSubview:self.stopChaseNoteButton];
//    [self.stopChaseNoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-15);
//        make.size.mas_equalTo(CGSizeMake(15, 15));
//        make.centerY.mas_equalTo(self.stopChaseButton);
//    }];
    
    
    [self addSubview:self.immediatelyChaseButton];
    [self.immediatelyChaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.topBGView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(50), 25));
    }];
    
    
    [self addSubview:self.makeMoneyButton];
    [self.makeMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.immediatelyChaseButton.mas_left).with.offset(-7);
        make.centerY.mas_equalTo(self.immediatelyChaseButton);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(70), 25));
    }];
    
//    UIButton *makeMoneyChooseButton = [[UIButton alloc]init];
//    [makeMoneyChooseButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-select"] forState:UIControlStateNormal];
//    [self addSubview:makeMoneyChooseButton];
//
//    [makeMoneyChooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.makeMoneyButton.mas_left).with.offset(-4);
//        make.centerY.mas_equalTo(self.makeMoneyButton);
//        // make.size.mas_equalTo(CGSizeMake(50, 25));
//    }];
    
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
       make.top.mas_equalTo(self.topBGView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(68), 25));
    }];
    
    [self addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cancelButton.mas_right).with.offset(10);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.cancelButton);
    }];
    
}

-(void)didClickNoteBtn:(UIButton *)sender{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(noteBtnClick)]) {
        [self.delegate noteBtnClick];
    }
}

//赚佣金
- (void)earnCommissionsClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        if (self.delegate &&[self.delegate respondsToSelector:@selector(immediateClick)]) {
            [self.delegate immediateClick];
        }
    }
}

-(void)setBettingNumberStr:(NSString *)bettingNumberStr{
    _bettingNumberStr = bettingNumberStr;
    self.selectedNumLabel.text = [NSString stringWithFormat:@"号码: %@",bettingNumberStr];
}

-(void)didClickChooseNumBtn:(UIButton *)sender{
    self.isSelectedLabel= !self.isSelectedLabel;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectBettingNumberClick:)]) {
        [self.delegate selectBettingNumberClick:self.isSelectedLabel];
    }
}

-(void)cancelClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(cancelClick)]) {
        [self.delegate cancelClick];
    }
}

//投注
-(void)bettingClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(bettingBtnClick)]) {
        [self.delegate bettingBtnClick];
    }
}

-(void)stopChaseClick:(UIButton *)sender{
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}

-(UILabel *)selectedNumLabel{
    if(!_selectedNumLabel){
        _selectedNumLabel = [UILabel new];
        _selectedNumLabel.font = MCFont(kAdapterFontSize(13));
        _selectedNumLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickChooseNumBtn:)];
        [_selectedNumLabel addGestureRecognizer:tap];
    }
    return _selectedNumLabel;
}

//-(UIButton *)chooseNumButton{
//    if(!_chooseNumButton){
//        _chooseNumButton = [UIButton new];
//        [_chooseNumButton setImage:[UIImage imageNamed:@"icon-lotterydetail-model-down"] forState:UIControlStateNormal];
//        [_chooseNumButton setImage:[UIImage imageNamed:@"icon-lotterydetail-model-up"] forState:UIControlStateSelected];
//        [_chooseNumButton addTarget:self action:@selector(didClickChooseNumBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _chooseNumButton;
//}

-(UIView *)topBGView {
    if (!_topBGView) {
        _topBGView = [[UIView alloc]init];
        _topBGView.backgroundColor = MCUIColorLighttingBrown;
    }
    return _topBGView;
}

-(UIView *)boomBGView {
    if (!_boomBGView) {
        _boomBGView = [[UIImageView alloc]init];
        _boomBGView.image = [UIImage imageNamed: @"icon-lotterydetail-boombar"];
    }
    return _boomBGView;
}

-(UIView *)totalLabel {
    if (!_totalLabel) {
        self.totalLabel = [[UILabel alloc]init];
        self.totalLabel.text = @"共5期59878元";
        self.totalLabel.textColor = [UIColor whiteColor];
        self.totalLabel.font = MCFont(kAdapterFontSize(13));
    }
    return _totalLabel;
}

-(UIButton *) makeMoneyButton {
    if (!_makeMoneyButton) {
        _makeMoneyButton = [[UIButton alloc]init];
        _makeMoneyButton.layer.cornerRadius = 4;
        _makeMoneyButton.clipsToBounds = YES;
        [_makeMoneyButton setTitle:@"赚佣金" forState:UIControlStateNormal];
        _makeMoneyButton.backgroundColor = MCUIColorWithRGB(57, 57, 59, 1);
        _makeMoneyButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
        [_makeMoneyButton setTitleColor:MCUIColorBetLightGray forState:UIControlStateNormal];
        [_makeMoneyButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-select"] forState:UIControlStateSelected];
        [_makeMoneyButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-nor"]forState:UIControlStateNormal];
        [_makeMoneyButton addTarget:self action:@selector(earnCommissionsClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeMoneyButton;
}

//-(UIButton *) stopChaseNoteButton{
//    if (!_stopChaseNoteButton) {
//         _stopChaseNoteButton = [[UIButton alloc]init];
//         _stopChaseNoteButton.userInteractionEnabled = NO;
//        [_stopChaseNoteButton setImage:[UIImage imageNamed:@"icon-lotterydetail-top-note"] forState:UIControlStateNormal];
//        [_stopChaseButton addTarget:self action:@selector(didClickNoteBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _stopChaseNoteButton;
//}

-(UIButton *)stopChaseButton{
    if (!_stopChaseButton) {
        _stopChaseButton = [[UIButton alloc]init];
        [_stopChaseButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-nor"] forState:UIControlStateNormal];
        [_stopChaseButton setImage:[UIImage imageNamed:@"icon-lotterydetail-money-select"] forState:UIControlStateSelected];
        [_stopChaseButton setTitle:@" 中奖后停止追号" forState:UIControlStateNormal];
        _stopChaseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _stopChaseButton.titleLabel.font = MCFont(kAdapterFontSize(13));
        [_stopChaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _stopChaseButton.selected = YES;
        [_stopChaseButton addTarget:self action:@selector(stopChaseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopChaseButton;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]init];
        self.cancelButton.layer.cornerRadius = 4;
        self.cancelButton.clipsToBounds = YES;
        self.cancelButton.backgroundColor = MCUIColorFromRGB(0x36393B);
        [self.cancelButton setTitle:@"修改号码" forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
        [self.cancelButton setTitleColor:MCUIColorFromRGB(0xC3C3C3) forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIButton *)immediatelyChaseButton{
    if (!_immediatelyChaseButton) {
        
        _immediatelyChaseButton = [[UIButton alloc]init];
        _immediatelyChaseButton.clipsToBounds = YES;
        [_immediatelyChaseButton setTitle:@"投注" forState:UIControlStateNormal];
        _immediatelyChaseButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
        _immediatelyChaseButton.layer.masksToBounds = YES;
        _immediatelyChaseButton.layer.cornerRadius = 4;

        [_immediatelyChaseButton setTitleColor:MCUIColorFromRGB(0x271309) forState:UIControlStateNormal];
        _immediatelyChaseButton.backgroundColor = MCUIColorFromRGB(0xFFBF00);
        [_immediatelyChaseButton addTarget:self action:@selector(bettingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _immediatelyChaseButton;
}

-(void)setAllperiod:(NSString *)period andMoneyStr:(NSString *)money{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%@期%@元",period,money]];

    [str addAttribute:NSForegroundColorAttributeName value: MCUIColorFromRGB(0xD8AB28) range:NSMakeRange(2+period.length,money.length)];
    self.totalLabel.attributedText = str;
}

@end
