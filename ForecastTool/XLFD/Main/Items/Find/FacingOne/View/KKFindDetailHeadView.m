//
//  KKFindDetailHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/17.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindDetailHeadView.h"


@interface KKFindDetailHeadView ()
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIButton *rankingLabel;
@property (nonatomic, strong) UIImageView* rankingView;
@property (nonatomic, strong) UILabel * valueLabel;
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UILabel * fansLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *rankImageView;
@end


@implementation KKFindDetailHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self addSubViews];
}
-(void)addSubViews {
    
    UIImageView *xianView = [[UIImageView alloc] init];
    xianView.image = [UIImage imageNamed:@"icon-find-xian"];
    [self addSubview:xianView];
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(53, 53));
    }];
    
    
    
    
    [self addSubview:self.rankingLabel];
    [self.rankingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(9);
    }];
    
    
    [self insertSubview:self.rankImageView atIndex:0];

    [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(3);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];

    
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(9);
        make.bottom.mas_equalTo(self.rankingLabel.mas_top).with.offset(-1);
    }];
    
    
    [self addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).with.offset(9);
        make.top.mas_equalTo(self.rankingLabel.mas_bottom).with.offset(3);
    }];
    
    
    
    [self addSubview:self.rankingView];
    [self.rankingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rankingLabel.mas_right).with.offset(4);
        make.centerY.mas_equalTo(self.rankingLabel);
    }];
    
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
    
    
    
    
    
    
    NSMutableAttributedString *fansStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"粉丝数:%d",model.count_fans]];
    [fansStr addAttribute:NSForegroundColorAttributeName value:MCUIColorFromRGB(0x4D4D4D) range:NSMakeRange(0,4)];
    NSInteger fansLength = [NSString stringWithFormat:@"%d",model.count_fans].length;
    [fansStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(4,fansLength)];
    self.fansLabel.attributedText = fansStr;
    
    
    
    
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"胜率:%d%% 江湖排名:%d",model.win_rate,model.ds_ranking]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]range:NSMakeRange(0,3)];
    NSString *win_rate = [NSString stringWithFormat:@"%d",model.win_rate];
    
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,win_rate.length + 1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(win_rate.length + 1 + 3,6)];
    
    
    NSString *ds_ranking = [NSString stringWithFormat:@"%d",model.ds_ranking];
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(win_rate.length + 1 + 3 + 6,ds_ranking.length)];
    
    //[self.rankingLabel setAttributedTitle:str forState:UIControlStateNormal];
    [self.rankingLabel setTitle:[str string] forState:UIControlStateNormal];
    //(0未关注2已关注3隐藏关注按钮)
    if (model.has_gz.integerValue == 3) {
        [self.attentionButton setHidden:YES];
        
    }else if (model.has_gz.integerValue == 0) {
        [self.attentionButton setHidden:NO];
        self.attentionButton.selected = NO;
    }
    else{
        [self.attentionButton setHidden:NO];
        self.attentionButton.selected = YES;
    }
    
    if (model.ds_ranking == 1) {
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-jin"];
    }else if(model.ds_ranking == 2) {
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-yin"];
    }else if(model.ds_ranking == 3) {
        self.rankingView.image = [UIImage imageNamed:@"icon-mvp-tong"];
    }else{
        self.rankingView.image = [[UIImage alloc] init];
    }
}

-(UIImageView *)rankingView {
    if (_rankingView == nil) {
        _rankingView = [[UIImageView alloc] init];
        _rankingView.image = [UIImage imageNamed:@"icon-mvp-jin"];
    }
    return _rankingView;
}


-(UIImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.image = [UIImage imageNamed:@"Reuse_placeholder_50*50"];
        _avatarView.layer.cornerRadius = 53 / 2;
        _avatarView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarViewClick)];
        [_avatarView addGestureRecognizer: tapGestureRecognizer];
    }
    return _avatarView;
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

-(UIImageView *)rankImageView {
    if (_rankImageView == nil) {
        _rankImageView = [[UIImageView alloc] init];
        _rankImageView.image = [UIImage imageNamed:@"icon-find-rank"];
    }
    return _rankImageView;
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


-(UIButton *)rankingLabel {
    if (_rankingLabel == nil) {
        _rankingLabel = [[UIButton alloc] init];
        //_rankingLabel.backgroundColor = MCUIColorFromRGB(0xFFC8C3);
        _rankingLabel.titleLabel.font = MCFont(10);
        _rankingLabel.layer.masksToBounds = YES;
        _rankingLabel.layer.cornerRadius = 4;
        [_rankingLabel setContentEdgeInsets:UIEdgeInsetsMake(3, 4, 3, 15)];
        [_rankingLabel setTitle:@"胜率:85% 江湖排名:2" forState: UIControlStateNormal];
        
        [_rankingLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _rankingLabel;
}

-(void)avatarViewClick {
    if ([self.delegate respondsToSelector:@selector(didClickAvatarView:)] && self.delegate) {
        [self.delegate didClickAvatarView:self];
    }
}
-(void)attentionClick {
    if ([self.delegate respondsToSelector:@selector(didClickAttention:)] && self.delegate) {
        [self.delegate didClickAttention:self];
    }
}


@end
