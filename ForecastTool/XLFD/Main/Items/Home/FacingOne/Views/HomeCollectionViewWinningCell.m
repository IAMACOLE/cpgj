//
//  HomeCollectionViewWinningCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/3/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "HomeCollectionViewWinningCell.h"

@interface HomeCollectionViewWinningCell()

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation HomeCollectionViewWinningCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self configureUI];
	}
	return self;
}

- (void)configureUI {
	[self addSubview:self.bgImageView];
	[self sendSubviewToBack:self.bgImageView];
	[self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
	[self addSubview:self.titleImageView];
	[self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(self.mas_height);
		make.left.centerY.equalTo(self);
	}];
	
//	[self addSubview:self.tipsView];
}

- (UIImageView *)titleImageView {
	if (_titleImageView == nil) {
		_titleImageView = [[UIImageView alloc] init];
		_titleImageView.image = [UIImage imageNamed:@"宝箱"];
		_titleImageView.contentMode = UIViewContentModeScaleAspectFit;
		
	}
	return _titleImageView;
}

- (UIImageView *)bgImageView {
	if (_bgImageView == nil) {
		_bgImageView = [[UIImageView alloc] init];
		_bgImageView.image = [UIImage imageNamed:@"奖金推送-bj"];
		_bgImageView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _bgImageView;
}

- (CMMessageTipsView *)tipsView {
	if (_tipsView == nil) {
		_tipsView = [[CMMessageTipsView alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
		_tipsView.backgroundColor = [UIColor clearColor];
		_tipsView.Delay = 2;
	}
	return _tipsView;
}

@end
