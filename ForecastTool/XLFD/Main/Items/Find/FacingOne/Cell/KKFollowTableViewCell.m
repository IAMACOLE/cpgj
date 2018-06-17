//
//  KKFollowTableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/17.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFollowTableViewCell.h"
@interface KKFollowTableViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *brokerageLabel;
@property (nonatomic, strong) UILabel *ruleLabel;
@property (nonatomic, strong) UILabel *returnLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *desc2Label;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *followLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *rule2Label;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UILabel *chanceLabel;
@property (nonatomic, strong) UIImageView *finishView;
@property (nonatomic, strong) UIView *createValueView;
@property (nonatomic, strong) UILabel *winMoneyLabel;
@property (nonatomic, strong) UILabel *winLabel;
@property (nonatomic, strong) UILabel *stausLabel;
@property (nonatomic, strong) UILabel *kaijiangLabel;
@end



@implementation KKFollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addSubViews];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}

-(void)addSubViews {
    
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.top.mas_equalTo(0);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = MCUIColorFromRGB(0xDFCFC7);
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.bgView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(15);
    }];
    
    
    [self.bgView addSubview:self.ruleLabel];
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(8);
    }];
    
    [self.bgView addSubview:self.chanceLabel];
    [self.chanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.ruleLabel.mas_bottom).with.offset(10);
    }];
    
    [self.bgView addSubview:self.returnLabel];
    [self.returnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chanceLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(self.chanceLabel);
    }];
    
    
    
    [self.bgView addSubview:self.rule2Label];
    [self.rule2Label mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.returnLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(self.chanceLabel);
    }];
    
    
    
    [self.bgView addSubview:self.desc2Label];
    [self.desc2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chanceLabel);
        make.right.mas_equalTo(-150);
        make.top.mas_equalTo(self.chanceLabel.mas_bottom).offset(10);
    }];
    
    [self.bgView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chanceLabel);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    [self.bgView addSubview:self.followLabel];
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.bgView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    [self.bgView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-40);
       // make.size.mas_equalTo(CGSizeMake(64, 42));
    }];
    
    

    
    [self.bgView addSubview:self.createValueView];
    [self.createValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-17);
        make.bottom.mas_equalTo(-35);
        make.size.mas_equalTo(CGSizeMake(83, 42));
    }];
    
    [self.bgView addSubview:self.finishView];
    [self.finishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-4);
    }];
}

-(void)buildWithData:(KKMyFollowModel *)model {
    
    
    NSMutableAttributedString *chanceStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"佣金:%.2f%%",model.commission]];
    [chanceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(0,3)];
    NSInteger chanceStrLength = [NSString stringWithFormat:@"%.2f",model.commission].length;
    [chanceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,chanceStrLength+1)];
    [self.chanceLabel setAttributedText:chanceStr];
    

    NSMutableAttributedString *returnStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"回报率:%d倍",model.back_rate]];
    [returnStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(0,4)];
    NSInteger returnStrLength = [NSString stringWithFormat:@"%d",model.back_rate].length;
    [returnStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(4,returnStrLength+1)];
    [self.returnLabel setAttributedText:returnStr];
    // self.returnLabel.text = [NSString stringWithFormat:@"回报率:%d%%",model.back_rate];
    
    
    
    NSMutableAttributedString *total_moneyStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@元起投",model.bet_min_money]];
    
    NSInteger betminiLength = [NSString stringWithFormat:@"%@",model.bet_min_money].length;
    [total_moneyStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(0,betminiLength)];
    
    
    
    
    [total_moneyStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(betminiLength,3)];
    [self.rule2Label setAttributedText:total_moneyStr];

    
    
    self.descLabel.text = [NSString stringWithFormat:@"%@  %@  下一期开奖%@",model.lottery_name,model.wf_name,model.plan_kj_time];
    
    
    self.desc2Label.text = model.content;
    NSString *stopStr = @"";
    
    if (model.zhuih_win_stop == YES) {
        stopStr = @" 中奖即停";
    }
    
    
    
    
    //追号10期 剩4期 中奖即停
    
    NSMutableAttributedString *ruleStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"追号%d期 剩%d期%@",model.zhuih_count_qs,model.left_qh_count,stopStr]];
    
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x626262) range:NSMakeRange(0,2)];
    
    NSInteger zhuih_count_qsLenght =  [NSString stringWithFormat:@"%d",model.zhuih_count_qs].length;
    
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,zhuih_count_qsLenght)];
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x626262) range:NSMakeRange(2+zhuih_count_qsLenght,3)];
    
    NSInteger left_qh_countLenght =  [NSString stringWithFormat:@"%d",model.left_qh_count].length;
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2+zhuih_count_qsLenght+3,left_qh_countLenght)];
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x626262) range:NSMakeRange(2+zhuih_count_qsLenght+3+left_qh_countLenght,1+stopStr.length)];
    
    self.ruleLabel.text = [ruleStr string];
    
    
    
    
    self.moneyLabel.text = [NSString stringWithFormat:@"自购%.2f元",model.user_pay_money];
    
    self.followLabel.text = [NSString stringWithFormat:@"跟单%d人",model.gd_total_people];
    
    self.totalLabel.text =  [NSString stringWithFormat:@"当前跟单金额%.2f元",model.gd_total_money];
    
    
    
    
    self.winMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.create_value];
    
    [self.finishView setHidden:YES];
    
    [self.stausLabel setHidden:NO];
    [self.createValueView setHidden:NO];
    [self.winMoneyLabel setHidden:YES];
    [self.winLabel setHidden:YES];
    [self.followButton setHidden:YES];
    // 开奖结果(0:进行中 1:获胜,2:未中奖,3:撤销)
    if (model.order_status == 1) {
        [self.stausLabel setHidden:YES];
        [self.winMoneyLabel setHidden:NO];
        [self.winLabel setHidden:NO];
        self.finishView.image = [UIImage imageNamed:@"icon-follow-finish2"];
        [self.finishView setHidden:NO];
        self.createValueView.backgroundColor = MCUIColorMain;
    }else if (model.order_status == 0) {
        self.stausLabel.text = @"进行中";
        self.stausLabel.textColor = MCUIColorFromRGB(0x47BBE3);
        [self.createValueView setHidden:YES];
         [self.followButton setHidden:NO];
    }else if (model.order_status == 2) {
        self.stausLabel.text = @"失败";
        self.createValueView.backgroundColor = MCUIColorFromRGB(0xC39E8C);
        self.stausLabel.textColor = MCUIColorFromRGB(0x626262);
        self.finishView.image = [UIImage imageNamed:@"icon-follow-finish"];
        [self.finishView setHidden:NO];
    }else if (model.order_status == 3) {
        self.stausLabel.text = @"撤销";
        self.stausLabel.textColor = MCUIColorFromRGB(0x6A7076);
    }else{
        self.stausLabel.text = @"异常";
        self.stausLabel.textColor = MCUIColorFromRGB(0x6BA58B);
    }
    
    
}


-(UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    
    return _bgView;
}
-(UILabel *)chanceLabel {
    if (_chanceLabel == nil) {
        _chanceLabel = [[UILabel alloc] init];
        _chanceLabel.text = @"佣金:0.1%";
        _chanceLabel.font = MCFont(12);

        _chanceLabel.textAlignment = NSTextAlignmentCenter;
        _chanceLabel.textColor = MCUIColorFromRGB(0xB3B3B3);
    }
    
    return _chanceLabel;
}



-(UILabel *)ruleLabel {
    if (_ruleLabel == nil) {
        _ruleLabel = [[UILabel alloc] init];
        _ruleLabel.text = @"追号10期 剩4期 中奖即停";
        _ruleLabel.font = MCFont(12);
        _ruleLabel.textColor = MCUIColorFromRGB(0x626262);
    }
    
    return _ruleLabel;
}

-(UILabel *)returnLabel {
    if (_returnLabel == nil) {
        _returnLabel = [[UILabel alloc] init];
        _returnLabel.text = @"回报率:85倍";
        _returnLabel.font = MCFont(12);

        _returnLabel.textAlignment = NSTextAlignmentCenter;
        _returnLabel.textColor = MCUIColorFromRGB(0xB3B3B3);
    }
    
    return _returnLabel;
}




-(UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"重庆时时彩  五星定位胆  下一期开奖12-23 22:50 ";
        _descLabel.font = MCFont(10);
        _descLabel.textColor = MCUIColorFromRGB(0x626262);
    }
    
    return _descLabel;
}
-(UILabel *)rule2Label {
    if (_rule2Label == nil) {
        _rule2Label = [[UILabel alloc] init];
        _rule2Label.text = @"2元起投";
        _rule2Label.font = MCFont(12);
        _rule2Label.textColor = MCUIColorFromRGB(0x999999);
    }
    
    return _rule2Label;
}


-(UILabel *)desc2Label {
    if (_desc2Label == nil) {
        _desc2Label = [[UILabel alloc] init];
        _desc2Label.text = @"连红模式开启此单必中！大家准备收米就来夫…";
        _desc2Label.font = MCFont(12);
        _desc2Label.textColor = MCUIColorFromRGB(0x272522);
    }
    
    return _desc2Label;
}

-(UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"自购22,33333元";
        _moneyLabel.font = MCFont(12);
        _moneyLabel.textColor = MCUIColorFromRGB(0x272522);
    }
    
    return _moneyLabel;
}




-(UIImageView *)finishView {
    if (_finishView == nil) {
        _finishView = [[UIImageView alloc] init];
        [_finishView setImage:[UIImage imageNamed:@"icon-follow-finish"]];
    }
    
    return _finishView;
}

-(UILabel *)followLabel {
    if (_followLabel == nil) {
        _followLabel = [[UILabel alloc] init];
        _followLabel.text = @"跟单64人";
        _followLabel.font = MCFont(12);
        _followLabel.textColor = MCUIColorFromRGB(0x272522);
    }
    
    return _followLabel;
}

-(UILabel *)kaijiangLabel {
    if (_kaijiangLabel == nil) {
        _kaijiangLabel = [[UILabel alloc] init];
        _kaijiangLabel.text = @"下一期开奖12-23 22:20";
        _kaijiangLabel.font = MCFont(12);
        _kaijiangLabel.textColor = MCUIColorFromRGB(0x272522);
    }
    
    return _totalLabel;
}
-(UILabel *)totalLabel {
    if (_totalLabel == nil) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = @"当前跟单金额5555,333元";
        _totalLabel.font = MCFont(12);
        _totalLabel.textColor = MCUIColorFromRGB(0x272522);
    }
    
    return _totalLabel;
}

-(UIView *)createValueView {
    if (_createValueView == nil) {
        _createValueView = [[UIView alloc] init];
        _createValueView.backgroundColor = MCUIColorMain;
        _createValueView.layer.masksToBounds = YES;
        _createValueView.layer.cornerRadius = 4;
        _winLabel = [[UILabel alloc] init];
        _winLabel.text = @"胜利";
        _winLabel.textAlignment = NSTextAlignmentCenter;
        _winLabel.frame = CGRectMake(0, 5, 83, 17);
        _winLabel.font = MCFont(12);
        _winLabel.textColor = MCUIColorFromRGB(0xE5E5E5);
        [_createValueView addSubview:_winLabel];
        _winMoneyLabel = [[UILabel alloc] init];
        _winMoneyLabel.text = @"￥33300.99";
        _winMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _winMoneyLabel.frame = CGRectMake(0, CGRectGetMaxY(_winLabel.frame) + 1, 83, 10);
        _winMoneyLabel.font = MCFont(12);
        _winMoneyLabel.textColor = MCUIColorFromRGB(0xE5E5E5);
        
        [_createValueView addSubview:_winMoneyLabel];
        
        
        _stausLabel = [[UILabel alloc] init];
        _stausLabel.text = @"￥33300.99";
        _stausLabel.textAlignment = NSTextAlignmentCenter;
        _stausLabel.frame = CGRectMake(0, 0, 83, 42);
        _stausLabel.font = MCFont(12);
        _stausLabel.textColor = MCUIColorFromRGB(0xE5E5E5);
        
        
        [_createValueView addSubview:_stausLabel];
    }
    
    return _createValueView;
}

-(UIButton *)followButton {
    if (_followButton == nil) {
        _followButton = [[UIButton alloc] init];
        [_followButton setBackgroundImage:[UIImage imageNamed:@"icon-follow-button"] forState:UIControlStateNormal];
        
        //[_followButton setTitle:@"查看跟单" forState: UIControlStateNormal];
        _followButton.titleLabel.font = MCFont(12);
        _followButton.userInteractionEnabled = NO;
        //_followButton.backgroundColor = MCUIColorMain;
        _followButton.layer.masksToBounds = YES;
        _followButton.layer.cornerRadius = 4;
        [_followButton addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _followButton;
}
-(void)followButtonClick{
    
    //    if ([self.delegate respondsToSelector:@selector(didSelectFollowAtIndex:atIndex:)] && self.delegate) {
    //        [self.delegate didSelectFollowAtIndex:self atIndex:self.row];
    //    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
