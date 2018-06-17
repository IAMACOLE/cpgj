//
//  LHCFooterView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LHCFooterView.h"
@interface LHCFooterView()<UITextFieldDelegate>

@property(nonatomic, strong)UIButton *deleteButton;
@property(nonatomic,strong)UIImageView *boomBGView;
@property(nonatomic,strong)UIButton *bettingButton;
@property(nonatomic,strong)UIButton *ChaseButton;

@end

@implementation LHCFooterView

- (void)drawRect:(CGRect)rect {

    [self addSubview:self.boomBGView];
    [self.boomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [self addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        //make.centerY.mas_equalTo(0);
         make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(53, 25));
    }];
    
    [self addSubview:self.bettingButton];
    [self.bettingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        //make.centerY.mas_equalTo(0);
         make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(53, 25));
    }];
    
//    [self addSubview:self.ChaseButton];
//    [self.ChaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.bettingButton.mas_left).with.offset(-10);
//        make.centerY.mas_equalTo(self.bettingButton);
//        make.size.mas_equalTo(CGSizeMake(kAdapterWith(40), 25));
//    }];
    
    [self addSubview:self.timesLabel];
    [self.timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        //make.top.mas_equalTo(self).with.offset(8);
        make.top.mas_equalTo(self).with.offset(10);
        make.centerX.mas_equalTo(0);
        //make.centerY.mas_equalTo(self).with.offset(0);
       // make.size.mas_equalTo(CGSizeMake(120, 34));
    }];
}

//追号
-(void)chaseClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(chaseClick)]) {
        [self.delegate chaseClick];
    }
}

//删除
-(void)deleteClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(deleteClick)]) {
        [self.delegate deleteClick];
    }
}
//投注
-(void)bettingClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(bettingClick)]) {
        [self.delegate bettingClick];
    }
}
-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc]init];
       
        [_deleteButton setTitle:@"清空" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = MCFont(14);
        _deleteButton.layer.cornerRadius = 5;
        _deleteButton.clipsToBounds = YES;
        _deleteButton.backgroundColor = MCUIColorFromRGB(0x36393B);
        [_deleteButton setTitleColor:MCUIColorFromRGB(0xC3C3C3) forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(UIImageView *) boomBGView{
    if (!_boomBGView) {
        _boomBGView = [[UIImageView alloc] init];
        _boomBGView.image = [UIImage imageNamed:@"icon-lotterydetail-boombar"];
    }
     return _boomBGView;
}

-(UIButton *)bettingButton{
    if (!_bettingButton) {
        self.bettingButton = [[UIButton alloc]init];

        self.bettingButton.clipsToBounds = YES;
        [self.bettingButton setTitle:@"投注" forState:UIControlStateNormal];
        self.bettingButton.titleLabel.font = MCFont(14);
        self.bettingButton.layer.cornerRadius = 5;
        self.bettingButton.backgroundColor = MCUIColorFromRGB(0xFFBF00);
        [self.bettingButton setTitleColor:MCUIColorFromRGB(0x271309) forState:UIControlStateNormal];
        [self.bettingButton addTarget:self action:@selector(bettingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bettingButton;
}

-(UIButton *)ChaseButton{
    if (!_ChaseButton) {
        self.ChaseButton = [[UIButton alloc]init];
        self.ChaseButton.layer.cornerRadius = 4;
        self.ChaseButton.clipsToBounds = YES;
        [self.ChaseButton setTitle:@"追号" forState:UIControlStateNormal];
        self.ChaseButton.backgroundColor = MCUIColorWithRGB(57, 57, 59, 1);
        self.ChaseButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterWith(13)];
        [self.ChaseButton setTitleColor:MCUIColorBetLightGray forState:UIControlStateNormal];
        [self.ChaseButton addTarget:self action:@selector(chaseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ChaseButton;
}

-(UIButton *)timesLabel{
    if (!_timesLabel) {
        _timesLabel = [[UIButton alloc]init];
        [_timesLabel setTitle:@"0注" forState:UIControlStateNormal];
        _timesLabel.titleLabel.font = MCFont(14);
        [_timesLabel setTitleColor:MCUIColorFromRGB(0xC3C3C3) forState:UIControlStateNormal];
        _timesLabel.layer.masksToBounds = YES;
        _timesLabel.layer.borderWidth = 1;
        _timesLabel.layer.cornerRadius = 4;
        _timesLabel.layer.borderColor = MCUIColorFromRGB(0x36393B).CGColor;
        [_timesLabel setContentEdgeInsets:UIEdgeInsetsMake(3, 10, 3, 10)];
    }
    return _timesLabel;
}
@end
