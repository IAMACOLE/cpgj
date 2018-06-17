//
//  KKFindTableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindTableViewCell.h"


@interface KKFindTableViewCell ()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UILabel *projectLabel;
@property (nonatomic, strong) UILabel *chanceLabel;
@property (nonatomic, strong) UILabel *brokerageLabel;
@property (nonatomic, strong) UILabel *returnLabel;
@property (nonatomic, strong) UILabel *ruleLabel;
@property (nonatomic, strong) UILabel *rule2Label;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *desc2Label;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *followLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *followButton;

@end

@implementation KKFindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}


-(void)addSubViews {

    self.backgroundColor = MCUIColorLighttingBrown;
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.backgroundColor = MCMineTableCellBgColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.5);
        make.bottom.mas_equalTo(-0.5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self addSubview: self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
//    UIView *headlineView = [[UIView alloc] init];
//    [self addSubview: headlineView];
//    headlineView.backgroundColor = MCUIColorFromRGB(0xA2635F);
//    [headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(20);
//        make.right.mas_equalTo(-20);
//        make.height.mas_equalTo(1);
//        make.top.mas_equalTo(self.avatarView.mas_bottom).with.offset(6);
//    }];

    [self addSubview: self.projectLabel];
    [self.projectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(8);
        make.centerY.mas_equalTo(self.avatarView).with.offset(-7);
        //make.size.mas_equalTo(CGSizeMake(53, 53));
    }];
    
    [self addSubview: self.rankLabel];
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.projectLabel);
        make.top.mas_equalTo(self.projectLabel.mas_bottom).with.offset(1);
        
    }];
    
    [self addSubview: self.returnLabel];
    [self.returnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.avatarView);
    }];
    UIView *returnlineView = [[UIView alloc] init];
    [self addSubview: returnlineView];
    returnlineView.backgroundColor = MCUIColorLighttingBrown;
    [returnlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(self.returnLabel.mas_left).with.offset(-11);
    }];
    
    
    [self addSubview: self.chanceLabel];
    [self.chanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.returnLabel.mas_left).with.offset(-30);
        make.centerY.mas_equalTo(self.avatarView);
    }];
    UIView *chancelineView = [[UIView alloc] init];
    [self addSubview: chancelineView];
    chancelineView.backgroundColor = MCUIColorLighttingBrown;
    [chancelineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(self.chanceLabel.mas_left).with.offset(-17);
    }];

    [self addSubview: self.brokerageLabel];
    [self.brokerageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.chanceLabel.mas_left).with.offset(-30);
        make.centerY.mas_equalTo(self.avatarView);
    }];
    
    UIView *brokeragelineView = [[UIView alloc] init];
    [self addSubview: brokeragelineView];
    brokeragelineView.backgroundColor = MCUIColorLighttingBrown;
    [brokeragelineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(self.brokerageLabel.mas_left).with.offset(-17);
    }];
    
    [self addSubview: self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView);
        make.top.mas_equalTo(self.avatarView.mas_bottom).mas_offset(5);
    }];
    
    [self addSubview: self.ruleLabel];
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView);
        make.top.mas_equalTo(self.descLabel.mas_bottom).with.offset(5);
    }];
    
    [self addSubview: self.rule2Label];
    [self.rule2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.ruleLabel);
    }];
    
    [self addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.ruleLabel.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 26));
    }];
    
    [self addSubview: self.desc2Label];
    [self.desc2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView);
        make.centerY.mas_equalTo(self.followButton);
        make.right.mas_equalTo(self.followButton.mas_left).mas_offset(-5);
    }];
    
    [self addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.desc2Label);
        make.top.mas_equalTo(self.followButton.mas_bottom).with.offset(5);
    }];
    
    [self addSubview:self.followLabel];
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.moneyLabel);
    }];
    
    [self addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.moneyLabel);
    }];
    
}

-(UIImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.image = [UIImage imageNamed:@"Reuse_placeholder_50*50"];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 36/2;
    }
    return _avatarView;
}

-(UILabel *)projectLabel {
    if (_projectLabel == nil) {
        _projectLabel = [[UILabel alloc] init];
        _projectLabel.text = @"超级比一比";
        _projectLabel.font = MCFont(12);
        _projectLabel.textColor = MCUIColorFromRGB(0x454545);
    }
    return _projectLabel;
}
-(UILabel *)brokerageLabel {
    if (_brokerageLabel == nil) {
        _brokerageLabel = [[UILabel alloc] init];
        _brokerageLabel.text = @"胜率:80%";
        _brokerageLabel.font = MCFont(12);
        _brokerageLabel.textColor = MCUIColorFromRGB(0x454545);
        _brokerageLabel.numberOfLines = 2;
        _brokerageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _brokerageLabel;
}
-(UILabel *)chanceLabel {
    if (_chanceLabel == nil) {
        _chanceLabel = [[UILabel alloc] init];
        _chanceLabel.text = @"佣金:0.1%";
        _chanceLabel.font = MCFont(12);
        _chanceLabel.numberOfLines = 2;
        _chanceLabel.textColor = MCUIColorFromRGB(0x454545);
        _chanceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _chanceLabel;
}
-(UILabel *)returnLabel {
    if (_returnLabel == nil) {
        _returnLabel = [[UILabel alloc] init];
        _returnLabel.text = @"回报率:85倍";
        _returnLabel.font = MCFont(12);
         _returnLabel.numberOfLines = 2;
        _returnLabel.textColor = MCUIColorFromRGB(0x454545);
        _returnLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _returnLabel;
}

-(UILabel *)ruleLabel {
    if (_ruleLabel == nil) {
        _ruleLabel = [[UILabel alloc] init];
        _ruleLabel.text = @"追号10期 剩4期 中奖即停";
        _ruleLabel.font = MCFont(12);
        _ruleLabel.textColor = MCUIColorFromRGB(0x6A6767);
    }
    return _ruleLabel;
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


-(UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"重庆时时彩  五星定位胆  下一期开奖12-23 22:50";
        _descLabel.font = MCFont(10);
        _descLabel.textColor = MCUIColorFromRGB(0x6A6767);
    }
    return _descLabel;
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

-(UILabel *)rankLabel {
    if (_rankLabel == nil) {
        _rankLabel = [[UILabel alloc] init];
        _rankLabel.text = @"江湖排名:110";
        _rankLabel.font = MCFont(10);
        _rankLabel.numberOfLines = 1;
        _rankLabel.textColor = MCUIColorFromRGB(0x343434);
    }
    
    return _rankLabel;
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


-(UIButton *)followButton {
    if (_followButton == nil) {
        _followButton = [[UIButton alloc] init];

        
       // [_followButton setTitle:@"立即查看" forState: UIControlStateNormal];
        //_followButton.titleLabel.font = MCFont(12);

        [_followButton setBackgroundImage:[UIImage imageNamed:@"icon-follow-button"] forState:UIControlStateNormal];
        //_followButton.layer.masksToBounds = YES;
        //_followButton.layer.cornerRadius = 4;
        _followButton.userInteractionEnabled = NO;
        [_followButton addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _followButton;
}

-(void)buildWithData:(KKFindModel *)model {
    NSURL *url = [[NSURL alloc] initWithString:model.image_url];
    [self.avatarView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Reuse_placeholder_50*50"]];
    self.projectLabel.text = model.nick_name;
    
    if ([model.ds_ranking isEqualToString:@"0"]) {
        self.rankLabel.text = @"暂无排名";
    }else{
        self.rankLabel.text = [NSString stringWithFormat:@"江湖排名%@",model.ds_ranking];
    }
    
    
    NSMutableAttributedString *brokerageStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"胜率:\n%d%%",model.win_rate]];
    
    [brokerageStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x454545) range:NSMakeRange(0,3)];
    NSInteger brokerageStrLength = [NSString stringWithFormat:@"%d",model.win_rate].length;
    [brokerageStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,brokerageStrLength+2)];
    [self.brokerageLabel setAttributedText:brokerageStr];
    
    NSMutableAttributedString *chanceStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"佣金:\n%.2f%%",model.commission]];
    [chanceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x454545) range:NSMakeRange(0,3)];
    NSInteger chanceStrLength = [NSString stringWithFormat:@"%.2f",model.commission].length;
    [chanceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,chanceStrLength+2)];
    [self.chanceLabel setAttributedText:chanceStr];

    
    NSMutableAttributedString *returnStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"回报率:\n%d倍",model.back_rate]];
    [returnStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x454545) range:NSMakeRange(0,4)];
    NSInteger returnStrLength = [NSString stringWithFormat:@"%d",model.back_rate].length;
    [returnStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(4,returnStrLength+2)];
    [self.returnLabel setAttributedText:returnStr];
   
    NSString *bet_min_money = [NSString stringWithFormat:@"%.2f",[model.bet_min_money floatValue]];
    
    NSMutableAttributedString *total_moneyStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@元起投",bet_min_money]];
    
    NSInteger betminiLength = [NSString stringWithFormat:@"%@",bet_min_money].length;
    [total_moneyStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(0,betminiLength+1)];
    
    [total_moneyStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(betminiLength+1,2)];
    
    [self.rule2Label setAttributedText:total_moneyStr];
    
    self.descLabel.text = [NSString stringWithFormat:@"%@  %@  下一期开奖%@",model.lottery_name,model.wf_name,model.plan_kj_time];
    
    if ([model.content isEqualToString:@""]) {
        model.content = @" ";
    }
    
    self.desc2Label.text = model.content;
    NSString *stopStr = @"";
    
    if (model.zhuih_win_stop == YES) {
        stopStr = @" 中奖即停";
    }
    
    //追号10期 剩4期 中奖即停
    
    NSMutableAttributedString *ruleStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"追号%d期 剩%d期%@",model.zhuih_count_qs,model.left_qh_count,stopStr]];

   [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x999999) range:NSMakeRange(0,2)];
    
    NSInteger zhuih_count_qsLenght =  [NSString stringWithFormat:@"%d",model.zhuih_count_qs].length;
    
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,zhuih_count_qsLenght)];
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x999999) range:NSMakeRange(2+zhuih_count_qsLenght,3)];
    
    NSInteger left_qh_countLenght =  [NSString stringWithFormat:@"%d",model.left_qh_count].length;
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2+zhuih_count_qsLenght+3,left_qh_countLenght)];
    [ruleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x999999) range:NSMakeRange(2+zhuih_count_qsLenght+3+left_qh_countLenght,1+stopStr.length)];
    
    self.ruleLabel.text =  [ruleStr string];
    
    NSMutableAttributedString *user_payStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"自购%.2f元",model.user_pay_money]];
    
    [user_payStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(0,2)];
    
    NSInteger user_payLength = [NSString stringWithFormat:@"%.2f",model.user_pay_money].length;
    
    
    [user_payStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,user_payLength)];
    
    [user_payStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(2+user_payLength,1)];
    
    [self.moneyLabel setAttributedText:user_payStr];
    
    NSMutableAttributedString *follow_peopleStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"跟单%d人",model.gd_total_people]];
    //self.followLabel.text = [NSString stringWithFormat:@"跟单%d人",model.gd_total_people];
    [follow_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(0,2)];
    
    NSInteger follow_peopleLength = [NSString stringWithFormat:@"%d",model.gd_total_people].length;
     [follow_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(2,follow_peopleLength)];
    
     [follow_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(2+follow_peopleLength,1)];
    
    [self.followLabel setAttributedText:follow_peopleStr];
    
    NSMutableAttributedString *gd_peopleStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"当前跟单金额%.2f元",model.gd_total_money]];
    
    [gd_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(0,6)];
    
    NSInteger gd_peopleLength = [NSString stringWithFormat:@"%.2f",model.gd_total_money].length;
    
    
    [gd_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(6,gd_peopleLength)];
    
    [gd_peopleStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x272522) range:NSMakeRange(6+gd_peopleLength,1)];
    [self.totalLabel setAttributedText:gd_peopleStr];
}

-(void)followButtonClick{
    
    if ([self.delegate respondsToSelector:@selector(didSelectFollowAtIndex:atIndex:)] && self.delegate) {
        [self.delegate didSelectFollowAtIndex:self atIndex:self.row];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
