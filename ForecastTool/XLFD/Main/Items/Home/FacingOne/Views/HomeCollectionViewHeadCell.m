//
//  HomeCollectionViewHeadCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/4.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "HomeCollectionViewHeadCell.h"
#import "UserRankModel.h"
#import <SDWebImage/UIImage+GIF.h>

@interface HomeCollectionViewHeadCell()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *streamTitleLabel;
@property (nonatomic, strong) UILabel *gainAndLossTitleLabel;
@property (nonatomic, strong) UILabel *rankingTitleLabel;
@property (nonatomic, strong) UIView *grantsView;

@end

@implementation HomeCollectionViewHeadCell
UIColor * basicTextColor;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configUI];
    }
    return self;
}

- (void)loadData:(id)data {
    if ([data isMemberOfClass:[UserRankModel class]]) {
        UserRankModel *model = (UserRankModel *)data;
        self.streamContentLabel.text = model.today_flow_money;
        self.gainAndLossContentLabel.text = model.today_profit_loss;
        self.rankingContentLabel.text = model.user_ranking;
    } else {
        self.streamContentLabel.text = @"0";
        self.gainAndLossContentLabel.text = @"0";
        self.rankingContentLabel.text = @"0";
    }
}

- (void)configUI {
	basicTextColor = MCUIColorFromRGB(0x9E5B3F);
	[self addSubview:self.bgImageView];
	[self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
    [self configureLabel];;

    [self addSubview:self.grantsView];
    [self.grantsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.bounds.size.height * 1/12);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height, self.bounds.size.height * 2/3));
    }];
    [self configureGrantsView];
    [self addSubview:self.grantsButton];
    [self.grantsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.grantsView);
    }];
}

- (UIImageView *)bgImageView {
	if (_bgImageView == nil) {
		_bgImageView = [[UIImageView alloc] init];
		_bgImageView.image = [UIImage imageNamed:@"图层"];
		_bgImageView.alpha = 0.5f;
		_bgImageView.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _bgImageView;
}

- (UIButton *)grantsButton {
    if (_grantsButton == nil) {
        
        _grantsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_grantsButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _grantsButton;
}

- (void)configureLabel {
    
    [self addSubview:self.streamTitleLabel];
    [self.streamTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(self.bounds.size.height * 1/4);
        make.left.mas_equalTo(self).offset(self.bounds.size.height * 1/12);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height * 6/5, self.bounds.size.height * 1/6));
    }];
    
    [self addSubview:self.streamContentLabel];
    [self.streamContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.streamTitleLabel.mas_bottom).offset(self.bounds.size.height * 1/6);
        make.left.mas_equalTo(self).offset(self.bounds.size.height * 1/12);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height * 6/5, self.bounds.size.height * 1/6));
    }];

    [self addSubview:self.gainAndLossTitleLabel];
    [self.gainAndLossTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(self.bounds.size.height * 1/4);
		make.left.mas_equalTo(self.streamTitleLabel.mas_right).offset(self.bounds.size.height * 1/12);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height * 5/6, self.bounds.size.height * 1/6));
    }];

    [self addSubview:self.gainAndLossContentLabel];
    [self.gainAndLossContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gainAndLossTitleLabel.mas_bottom).offset(self.bounds.size.height * 1/6);
        make.left.mas_equalTo(self.streamContentLabel.mas_right).offset(self.bounds.size.height * 1/12);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height * 5/6, self.bounds.size.height * 1/6));
    }];

    [self addSubview:self.rankingTitleLabel];
    [self.rankingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(self.bounds.size.height * 1/4);
        make.left.mas_equalTo(self.gainAndLossTitleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height, self.bounds.size.height * 1/6));
    }];

    [self addSubview:self.rankingContentLabel];
    [self.rankingContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gainAndLossTitleLabel.mas_bottom).offset(self.bounds.size.height * 1/6);
        make.left.mas_equalTo(self.gainAndLossContentLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height, self.bounds.size.height * 1/6));
    }];
}

- (void)configureGrantsView {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.grantsView addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"补助金"];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grantsView);
        make.centerX.equalTo(self.grantsView);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height * 2/3 * 2/3, self.bounds.size.height * 2/3 * 2/3));
    }];

    UILabel *label = [[UILabel alloc] init];
    label.text = @"补助金领取";
    label.textColor = basicTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = MCFont(kAdapterFontSize(14));
    [self.grantsView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom);
        make.left.equalTo(self.grantsView);
        make.right.equalTo(self.grantsView);
        make.bottom.equalTo(self.grantsView);
    }];
}

- (void)buttonClick {
    [self.delegate grantsButtonClick];
}


- (UILabel *)streamTitleLabel {
    if (_streamTitleLabel == nil) {
        _streamTitleLabel = [[UILabel alloc] init];
        _streamTitleLabel.text = @"您的今日流水";
        _streamTitleLabel.textColor = basicTextColor;
        _streamTitleLabel.textAlignment = NSTextAlignmentCenter;
        _streamTitleLabel.font = MCFont(kAdapterFontSize(14));
    }
    return _streamTitleLabel;
}

- (UILabel *)streamContentLabel {
    if (_streamContentLabel == nil) {
        _streamContentLabel = [[UILabel alloc] init];
        _streamContentLabel.textColor = basicTextColor;
        _streamContentLabel.textAlignment = NSTextAlignmentCenter;
        _streamContentLabel.font = MCFont(kAdapterFontSize(14));
    }
    return _streamContentLabel;
}

- (UILabel *)gainAndLossTitleLabel {
    if (_gainAndLossTitleLabel == nil) {
        _gainAndLossTitleLabel = [[UILabel alloc] init];
        _gainAndLossTitleLabel.text = @"今日盈亏";
        _gainAndLossTitleLabel.textColor = basicTextColor;
        _gainAndLossTitleLabel.textAlignment = NSTextAlignmentCenter;
        _gainAndLossTitleLabel.font = MCFont(kAdapterFontSize(14));
    }
    return _gainAndLossTitleLabel;
}

- (UILabel *)gainAndLossContentLabel {
    if (_gainAndLossContentLabel == nil) {
        _gainAndLossContentLabel = [[UILabel alloc] init];
        _gainAndLossContentLabel.textColor = basicTextColor;
        _gainAndLossContentLabel.textAlignment = NSTextAlignmentCenter;
        _gainAndLossContentLabel.font = MCFont(kAdapterFontSize(14));
    }
    return _gainAndLossContentLabel;
}

- (UILabel *)rankingTitleLabel {
    if (_rankingTitleLabel == nil) {
        _rankingTitleLabel = [[UILabel alloc] init];
        _rankingTitleLabel.text = @"您的排名";
        _rankingTitleLabel.textColor = basicTextColor;
        _rankingTitleLabel.textAlignment = NSTextAlignmentCenter;
        _rankingTitleLabel.font = MCFont(kAdapterFontSize(14));
    }
    return _rankingTitleLabel;
}

- (UILabel *)rankingContentLabel {
    if (_rankingContentLabel == nil) {
        _rankingContentLabel = [[UILabel alloc] init];
        _rankingContentLabel.textColor = basicTextColor;
        _rankingContentLabel.textAlignment = NSTextAlignmentCenter;
        _rankingContentLabel.font = MCFont(kAdapterFontSize(14));
    }
    return _rankingContentLabel;
}

- (UIView *)grantsView {
    if (_grantsView == nil) {
        _grantsView = [[UIView alloc] init];
    }
    return _grantsView;
}
@end
