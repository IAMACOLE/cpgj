//
//  KKFindDetailInfoView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/17.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindDetailInfoView.h"
@interface KKFindDetailInfoView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *brokerageLabel;
@property (nonatomic, strong) UILabel *projectLabel;
@property (nonatomic, strong) UILabel *rulesLabel;

//@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *desc2Label;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *followLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *rule2Label;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *chanceLabel;
@end

@implementation KKFindDetailInfoView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       [self addSubViews];
    } return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code、
    [super drawRect:rect];
   // [self addSubViews];
}



-(void)addSubViews {
    
    

    [self addSubview:self.projectLabel];
    [self.projectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
    }];



    [self addSubview:self.rulesLabel];
    [self.rulesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.projectLabel);
    }];



    [self addSubview:self.desc2Label];
   
    [self.desc2Label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.projectLabel);
       // make.top.mas_equalTo(self.rulesLabel.mas_bottom).offset(15);
         make.top.mas_equalTo(self.projectLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(self.rulesLabel);


    }];
    
    
    [self addSubview:self.chanceLabel];
    [self.chanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.projectLabel);
         make.top.mas_equalTo(self.desc2Label.mas_bottom).offset(12);
    }];

    
    
    [self addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.projectLabel);

        make.top.mas_equalTo(self.chanceLabel.mas_bottom).offset(5);
    }];


    [self addSubview:self.followLabel];
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);

        make.top.mas_equalTo(self.chanceLabel.mas_bottom).offset(5);
    }];

    
    //预计回报
    [self addSubview:self.rule2Label];
    [self.rule2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.followLabel);
        make.top.mas_equalTo(self.chanceLabel);
    }];
    
    
    [self addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rulesLabel);

        make.top.mas_equalTo(self.chanceLabel.mas_bottom).offset(5);
    }];


    [self addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyLabel);

        make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(8);
        make.bottom.mas_equalTo(-8);
    }];

    [self addSubview:self.createTimeLabel];
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.totalLabel);

        make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(8);
        make.bottom.mas_equalTo(-8);
    }];

    
    

    

    
}


-(void)buildWithData:(KKGDInfoModel *)model {
    self.projectLabel.text = [NSString stringWithFormat:@"%@ %@",model.lottery_name,model.wf_name];
    
    
    NSMutableAttributedString *chanceStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"佣金:%.2f%%",model.commission]];
    [chanceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(0,3)];
    NSInteger chanceStrLength = [NSString stringWithFormat:@"%.2f",model.commission].length;
    [chanceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,chanceStrLength+1)];
    [self.chanceLabel setAttributedText:chanceStr];
    
    
    NSString *stopStr = @"";
    if (model.zhuih_win_stop == YES) {
        stopStr = @" 中奖即停";
    }
    
    
    
    
   // 追号10期 剩4期 中奖即停
    
   // self.rulesLabel.text = [NSString stringWithFormat:@"追号%d期 剩%d期%@",model.zhuih_count_qs,model.left_qh_count,stopStr];
    
    NSMutableAttributedString *ruleStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"追号%d期 剩%d期%@",model.zhuih_count_qs,model.left_qh_count,stopStr]];

    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x999999) range:NSMakeRange(0,2)];

    NSInteger zhuih_count_qsLenght =  [NSString stringWithFormat:@"%d",model.zhuih_count_qs].length;

    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,zhuih_count_qsLenght)];
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x999999) range:NSMakeRange(2+zhuih_count_qsLenght,3)];

    NSInteger left_qh_countLenght =  [NSString stringWithFormat:@"%d",model.left_qh_count].length;
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2+zhuih_count_qsLenght+3,left_qh_countLenght)];
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x999999) range:NSMakeRange(2+zhuih_count_qsLenght+3+left_qh_countLenght,1+stopStr.length)];

    self.rulesLabel.text = [ruleStr string];
  //  [self.rulesLabel setAttributedText:ruleStr];
    
  
    NSMutableAttributedString *back_rateStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"预计回报:%d倍",model.back_rate]];
     //self.rule2Label.text = [NSString stringWithFormat:@"%d元起投",model.bet_min_money];

     [back_rateStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(0,5)];
    
    NSInteger back_rateLength = [NSString stringWithFormat:@"%d",model.back_rate].length;
    [back_rateStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(5,back_rateLength+1)];
    
    [self.rule2Label setAttributedText:back_rateStr];
    
    
     self.desc2Label.text = model.content;
    
    
    
    
    NSMutableAttributedString *user_payStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"自购%.2f元",model.user_pay_money]];
    
    [user_payStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(0,2)];
    
    NSInteger user_payLength = [NSString stringWithFormat:@"%.2f",model.user_pay_money].length;
    
    
    [user_payStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,user_payLength)];
    
    [user_payStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(2+user_payLength,1)];

    [self.moneyLabel setAttributedText:user_payStr];
   
    
    
    NSMutableAttributedString *gd_peopleStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"跟单金额%.2f元",model.gd_total_money]];
    
    [gd_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(0,4)];
    
    NSInteger gd_peopleLength = [NSString stringWithFormat:@"%.2f",model.gd_total_money].length;
    
    
    [gd_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(4,gd_peopleLength)];
    
   [gd_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(4+gd_peopleLength,1)];
    [self.followLabel setAttributedText:gd_peopleStr];
    
    
    
    
    NSMutableAttributedString *total_moneyStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@元起投",model.bet_min_money]];
 
    NSInteger betminiLength = [NSString stringWithFormat:@"%@",model.bet_min_money].length;
    [total_moneyStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(0,betminiLength)];
    


    
    [total_moneyStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x282623) range:NSMakeRange(betminiLength,3)];
    
    [self.totalLabel setAttributedText:total_moneyStr];
    
    
   // self.totalLabel.text =  [NSString stringWithFormat:@"当前跟单金额%.2f元",model.gd_total_money];
    
    self.numberLabel.text = [NSString stringWithFormat:@"单号:%@",model.gd_number];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
     NSString *create_timeStr = [model.create_time substringWithRange:NSMakeRange(0, 10)];
     NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[create_timeStr integerValue]];
    
    
    NSString *day = [dateFormatter stringFromDate:theday];
    self.createTimeLabel.text = [NSString stringWithFormat:@"发布时间:%@",day];
    
}


-(UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bgView;
}

-(UILabel *)projectLabel {
    if (_projectLabel == nil) {
        _projectLabel = [[UILabel alloc] init];
        _projectLabel.text = @"超级比一比";
        _projectLabel.font = MCFont(14);
        _projectLabel.textColor = MCUIColorFromRGB(0x282623);
    }
    
    return _projectLabel;
}


-(UILabel *)rulesLabel {
    if (_rulesLabel == nil) {
        _rulesLabel = [[UILabel alloc] init];
        _rulesLabel.text = @"追号10期 剩4期 中奖即停";
        _rulesLabel.font = MCFont(12);
        _rulesLabel.textColor = MCUIColorFromRGB(0x282623);
    }
    
    return _rulesLabel;
}

-(UILabel *)chanceLabel {
    if (_chanceLabel == nil) {
        _chanceLabel = [[UILabel alloc] init];
        _chanceLabel.text = @"回报率:85倍";
        _chanceLabel.font = MCFont(12);
        _chanceLabel.textColor = MCUIColorFromRGB(0xB3B3B3);
    }
    
    return _chanceLabel;
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
        _desc2Label.text = @"连红模式开启此单必中！大家准备收米就来夫…米就来夫…米就来夫…米就来夫";
        _desc2Label.font = MCFont(12);
        _desc2Label.textColor = MCUIColorFromRGB(0x6A6767);
        _desc2Label.numberOfLines = 0;
    }
    
    return _desc2Label;
}

-(UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"自购22,33333元";
        _moneyLabel.font = MCFont(12);
        _moneyLabel.textColor = MCUIColorFromRGB(0x5D5D5D);
    }
    
    return _moneyLabel;
}





-(UILabel *)followLabel {
    if (_followLabel == nil) {
        _followLabel = [[UILabel alloc] init];
        _followLabel.text = @"跟单64人";
        _followLabel.font = MCFont(12);
        _followLabel.textColor = MCUIColorFromRGB(0x5D5D5D);
    }
    
    return _followLabel;
}

-(UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"单号:gd20180101982938";
        _numberLabel.font = MCFont(11);
        _numberLabel.textColor = MCUIColorFromRGB(0x8E8682);
    }
    
    return _numberLabel;
}


-(UILabel *)createTimeLabel {
    if (_createTimeLabel == nil) {
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.text = @"发布时间:01-01 13:55";
        _createTimeLabel.font = MCFont(11);
        _createTimeLabel.textColor = MCUIColorFromRGB(0x8E8682);
    }
    
    return _createTimeLabel;
}



-(UILabel *)totalLabel {
    if (_totalLabel == nil) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = @"当前跟单金额5555,333元";
        _totalLabel.font = MCFont(12);
        _totalLabel.textColor = MCUIColorFromRGB(0x5D5D5D);
    }
    
    return _totalLabel;
}

@end
