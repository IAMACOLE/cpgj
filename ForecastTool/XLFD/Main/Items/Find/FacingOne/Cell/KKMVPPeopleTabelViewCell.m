//
//  KKFindMVPPeopleTabelViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMVPPeopleTabelViewCell.h"
@interface KKMVPPeopleTabelViewCell ()
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UIImageView * avatarBgImgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIView* rankView;
//@property (nonatomic, strong) UILabel* rankLabel;
//@property (nonatomic, strong) UILabel* rateNumLabel;
//@property (nonatomic, strong) UILabel* rateLabel;
@property (nonatomic, strong) UIImageView* rankingView;
@property (nonatomic, strong) UILabel * valueLabel;
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UILabel * fansLabel;
@end

@implementation KKMVPPeopleTabelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}

-(void)addSubViews {
    [self addSubview:self.rankView];
    
    [self addSubview:self.avatarBgImgView];
    [self.avatarBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.rankView.mas_right).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.avatarBgImgView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(8);
        make.top.mas_equalTo(self.avatarView);
    }];
    
    
    [self addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(8);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(4);
    }];
    
//    [self addSubview:self.rankingView];
//    [self.rankingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(4);
//        make.centerY.mas_equalTo(self.nameLabel);
//    }];
    
    [self addSubview:self.attentionButton];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-10);
        make.right.mas_equalTo(-15);
    }];
    
    
    [self addSubview:self.fansLabel];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.attentionButton.mas_bottom).with.offset(4);
        make.right.mas_equalTo(-15);
    }];
    
}

-(void)buildWithData:(KKMVPPeopleModel *)model {
    
    NSURL *url = [[NSURL alloc] initWithString:model.image_url];
    [self.avatarView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Reuse_placeholder_50*50"]];
    
    self.nameLabel.text = model.nick_name;
    
    NSMutableAttributedString *valueStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"创造价值:%.2f%@",model.create_value,@"元"]];
    [valueStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x4D4D4D) range:NSMakeRange(0,5)];
    NSInteger valueLength = [NSString stringWithFormat:@"%.2f",model.create_value].length;
    [valueStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(5,valueLength)];
    [valueStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x4D4D4D) range:NSMakeRange(5+valueLength,1)];
    
    self.valueLabel.attributedText = valueStr;

//    self.rateNumLabel.text = [NSString stringWithFormat:@"%d%%",model.win_rate];
    
    NSMutableAttributedString *fansStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"粉丝数:%d",model.count_fans]];
    [fansStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x4D4D4D) range:NSMakeRange(0,4)];
    NSInteger fansLength = [NSString stringWithFormat:@"%d",model.count_fans].length;
    [fansStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(4,fansLength)];
    self.fansLabel.attributedText = fansStr;
    
    //(0未关注2已关注3隐藏关注按钮)
    if (model.has_gz.integerValue == 3) {
        [self.attentionButton setHidden:YES];
      
    }else if (model.has_gz.integerValue == 0) {
        [self.attentionButton setHidden:NO];
        [self.attentionButton setSelected:NO];
    }
    else{
       [self.attentionButton setHidden:NO];
        [self.attentionButton setSelected:YES];
    }
    

//    [self.rankLabel setHidden:YES];
    
    
    if (model.ds_ranking == 1) {
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-jin"];
    }else if(model.ds_ranking == 2) {
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-yin"];
    }else if(model.ds_ranking == 3) {
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-tong"];
    }else{
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-normal"];
    }
}

-(void)setIsShowRanking:(BOOL)isShowRanking{
    _isShowRanking = isShowRanking;
    if(isShowRanking){
        _rankView.hidden = NO;
        _rankView.frame = CGRectMake(2, 16, 33, 33);
    }else{
        _rankView.hidden = YES;
        _rankView.frame = CGRectMake(2, 16, 0, 33);
    }
}

-(UIImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.image = [UIImage imageNamed:@"Reuse_placeholder_50*50"];
        _avatarView.layer.cornerRadius = 38 / 2;
        
    }
    return _avatarView;
}

- (UIImageView *)avatarBgImgView{
    
    if(_avatarBgImgView == nil){
        _avatarBgImgView = [UIImageView new];
        _avatarBgImgView.image = [UIImage imageNamed:@"avatarBg"];
    }
    return _avatarBgImgView;
}

-(UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = MCFont(12);
        _nameLabel.textColor = MCUIColorFromRGB(0x4D4D4D);
        _nameLabel.text = @"而特尔特人";
        
    }
    return _nameLabel;
}
-(UILabel *)valueLabel {
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = MCFont(10);
        _valueLabel.textColor = MCUIColorFromRGB(0x44D4D4D);
        _valueLabel.text = @"创造价值:5558889.88元";
        
    }
    return _valueLabel;
}



-(UIButton *)attentionButton {
    if (_attentionButton == nil) {
        _attentionButton = [[UIButton alloc] init];
        
        [_attentionButton setImage:[UIImage imageNamed:@"icon-mvp-attention"] forState:UIControlStateNormal];
        
        [_attentionButton setImage:[UIImage imageNamed:@"icon-mvp-unattention"] forState:UIControlStateSelected];

        [_attentionButton addTarget:self action:@selector(attentionClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionButton;
}



-(UILabel *)fansLabel {
    if (_fansLabel == nil) {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.font = MCFont(10);
        _fansLabel.textColor = MCUIColorFromRGB(0x4D4D4D);
        _fansLabel.text = @"粉丝数:19999";
        
    }
    return _fansLabel;
}

-(UIView *)rankView {
    if (_rankView == nil) {
        _rankView = [[UIView alloc] init];
        _rankView.frame = CGRectMake(2, 16, 33, 33);
        _rankView.backgroundColor = [UIColor clearColor];
        
        _rankingView = [[UIImageView alloc] init];
        _rankingView.image = [UIImage imageNamed:@"icon-mvp-jin"];
        _rankingView.frame = CGRectMake(0, 0, 33, 33);
//        _rankingView.contentMode = UIViewContentModeRight;
        [_rankView addSubview:_rankingView];
        
//        _rateNumLabel = [[UILabel alloc] init];
//        _rateNumLabel.frame = CGRectMake(CGRectGetMaxX(_rankingView.frame), 12, 52, 15);
//        _rateNumLabel.textColor = MCUIColorMain;
//        _rateNumLabel.textAlignment = NSTextAlignmentCenter;
//        _rateNumLabel.font = MCFont(17);
//        _rateNumLabel.text = @"85%";
//        [_rankView addSubview:_rateNumLabel];

//        _rateLabel = [[UILabel alloc] init];
//        _rateLabel.frame = CGRectMake(CGRectGetMaxX(_rankingView.frame), CGRectGetMaxY(_rateNumLabel.frame), 52, 15);
//        _rateLabel.textColor = MCUIColorFromRGB(0x4D4D4D);
//        _rateLabel.textAlignment = NSTextAlignmentCenter;
//        _rateLabel.font = MCFont(10);
//        _rateLabel.text = @"胜率";
//        [_rankView addSubview:_rateLabel];
//
//
//        _rankLabel = [[UILabel alloc] init];
//        _rankLabel.frame = CGRectMake(15, 13, 26, 26);
//        _rankLabel.backgroundColor = [UIColor whiteColor];
//        _rankLabel.textColor = MCUIColorFromRGB(0x4D4D4D);
//        _rankLabel.font = MCFont(12);
//        _rankLabel.textAlignment = NSTextAlignmentCenter;
//        _rankLabel.layer.masksToBounds = YES;
//        _rankLabel.layer.cornerRadius = 13;
//        [_rankView addSubview:_rankLabel];
    }
    return _rankView;
}




-(void)attentionClick {
    if ([self.delegate respondsToSelector:@selector(didClickAttention:row:)] && self.delegate) {
        [self.delegate didClickAttention:self row:self.row];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
