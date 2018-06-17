//
//  KKFindMVPPeopleView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindMVPPeopleView.h"

@interface KKFindMVPPeopleView ()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *chanceLabel;

@end

@implementation KKFindMVPPeopleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    [self addSubview:self.bgButton];
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(53), kAdapterWith(53)));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.avatarView.mas_bottom).with.offset(6);
    }];
    
    [self addSubview:self.chanceLabel];
    [self.chanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(2);
    }];
    
    
    

    

    
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(-8);
    }];
    
}



-(UIButton *)bgButton {
    if (_bgButton == nil) {
        _bgButton = [[UIButton alloc] init];
    }
    return _bgButton;
}

-(UIImageView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIImageView alloc] init];
        _lineView.image = [UIImage imageNamed:@"icon-find-line"];
    }
    return _lineView;
}


-(UILabel *)chanceLabel {
    if (_chanceLabel == nil) {
        _chanceLabel = [[UILabel alloc] init];
        _chanceLabel.textColor = MCUIColorMain;
        _chanceLabel.font = MCFont(kAdapterFontSize(10));
        _chanceLabel.text = @"胜率:83%";
    }
    return _chanceLabel;
}

-(UILabel *)nameLabel {
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = MCUIColorFromRGB(0x343434);
        _nameLabel.font = MCFont(kAdapterFontSize(12));
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"油油的铁拳";
    }
    return _nameLabel;
}


-(UIImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = kAdapterWith(53) / 2;
        _avatarView.image = [UIImage imageNamed:@"Reuse_placeholder_50*50"];
    }
    
    return _avatarView;
}


-(void)buildWithData:(KKMVPPeopleModel *)model {
    self.nameLabel.text = model.nick_name;
    NSURL *url = [[NSURL alloc] initWithString:model.image_url];
    [self.avatarView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Reuse_placeholder_50*50"]];
    self.chanceLabel.text = [NSString stringWithFormat:@"胜率:%d%%",model.win_rate];
}


@end
