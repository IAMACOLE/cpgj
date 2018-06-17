//
//  AnotherVersionHomeCollectionViewCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/2/13.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "AnotherVersionHomeCollectionViewCell.h"
#import "HomeButtonModel.h"

@interface AnotherVersionHomeCollectionViewCell()

@property (nonatomic, retain) UIView *markView;
@property (nonatomic, weak) id info_data;
@property (nonatomic, weak) NSIndexPath *info_indexPath;
@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat imgX;

@end

@implementation AnotherVersionHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	self.imgWidth = self.bounds.size.width * 2/5;
	self.cellHeight = self.bounds.size.height;
	self.imgX = (self.cellHeight - self.imgWidth) / 2;
	if (self) {
		[self registerNSNotificationCenter];
		[self configureUI];
	}
	return self;
}

- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath {
	if ([data isMemberOfClass:[HomeButtonModel class]]) {
		[self storeWeakValueWithData:data indexPath:indexPath];
		HomeButtonModel *model = (HomeButtonModel *)data;
		self.lottery_id = model.lottery_type;
		self.title.text = model.lottery_label.length > 0 ? model.lottery_label : model.lottery_name;
		self.content.text = model.countNum > 0 ? [model currentTimeString] : model.remarks ;
		NSURL *imgUrl = [NSURL URLWithString:model.lottery_image];
		[self.imgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"myinfo-10"]];
	} else {
		self.lottery_id = nil;
		self.title.text = nil;
		self.content.text = nil;
		[self.imgView setImage:[self createImageWithColor:MCUIColorWhite]];
	}
}

- (UIImage*) createImageWithColor: (UIColor*) color {
	CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (void)storeWeakValueWithData:(id)data indexPath:(NSIndexPath *)indexPath {
	self.info_data = data;
	self.info_indexPath = indexPath;
}

- (void)registerNSNotificationCenter {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterEvent:) name:NOTIFICATION_TIME object:nil];
}

- (void)configureUI {
	[self addSubview:self.imgView];
	[self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self).offset(self.imgX / 2);
		make.centerX.equalTo(self);
		make.width.height.mas_equalTo(self.imgWidth);
	}];
	[self addSubview:self.title];
	[self.title mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.imgView.mas_bottom).offset(kAdapterFontSize(5));
		make.centerX.equalTo(self);
		make.width.equalTo(self);
	}];
	[self addSubview:self.content];
	[self.content mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.title.mas_bottom).offset(kAdapterFontSize(2));
		make.centerX.equalTo(self);
		make.width.mas_offset(self.imgX * 2);
	}];
	
	[self addSubview:self.rightVerticalLine];
	[self.rightVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(self);
		make.width.mas_equalTo(0.5);
		make.top.equalTo(self).offset(12);
		make.bottom.equalTo(self).offset(-12);
	}];
	[self addSubview:self.bottomHorizontalLine];
	[self.bottomHorizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.bottom.left.equalTo(self);
		make.height.mas_equalTo(0.5);
	}];
}

- (void)notificationCenterEvent:(id)sender {
	[self loadData:self.info_data indexPath:self.info_indexPath];
}

- (void)dealloc {
	[self removeNSNotificationCenter];
}

- (void)removeNSNotificationCenter {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TIME object:nil];
}

- (UIImageView *)imgView {
	if (_imgView == nil) {
		self.imgView = [[UIImageView alloc] init];
		self.imgView.layer.cornerRadius = self.imgWidth / 2;
		self.imgView.layer.masksToBounds = YES;
		self.imgView.userInteractionEnabled = NO;
	}
	return _imgView;
}

- (UILabel *)title {
	if (_title == nil) {
		_title = [[UILabel alloc] init];
		_title.textAlignment = NSTextAlignmentCenter;
		_title.font =  MCFont(kAdapterFontSize(16));
		[_title sizeToFit];
	}
	return _title;
}

- (UILabel *)content {
	if (_content == nil) {
		_content = [[UILabel alloc] init];
		_content.textAlignment = NSTextAlignmentCenter;
		_content.font = MCFont(kAdapterFontSize(12));
		_content.textColor = MCUIColorWithRGB(148, 148, 148, 1);
		[_content sizeToFit];
	}
	return _content;
}

- (UIView *)markView {
	if (_markView == nil) {
		_markView = [[UIView alloc] init];
		
		_markView.transform = CGAffineTransformMakeRotation(M_PI_4);
		_markView.backgroundColor = MCUIColorFromRGB(0xE6D9D2);
		_markView.layer.borderWidth = 0.5;
		_markView.layer.borderColor = [UIColor colorWithRed:235/255.0 green:233/255.0 blue:216/255.0 alpha:1.0f].CGColor;
	}
	return _markView;
}

- (void)setIsHiddened:(BOOL)isHiddened {
	_isHiddened = isHiddened;
	if (_isHiddened) {
		[self.markView removeFromSuperview];
	} else {
		[self addSubview:self.markView];
		[self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.mas_bottom).offset(- self.cellHeight / 16);
			make.centerX.equalTo(self.imgView);
			make.size.mas_equalTo(CGSizeMake(self.cellHeight / 8, self.cellHeight / 8));
		}];
	}
}

- (UIView *)rightVerticalLine {
	if (_rightVerticalLine == nil) {
		_rightVerticalLine = [[UIView alloc] init];
		_rightVerticalLine.backgroundColor = MCUIColorFromRGB(0xE6D9D2);
	}
	return _rightVerticalLine;
}

- (UIView *)bottomHorizontalLine {
	if (_bottomHorizontalLine == nil) {
		_bottomHorizontalLine = [[UIView alloc] init];
		_bottomHorizontalLine.backgroundColor = MCUIColorFromRGB(0xE6D9D2);
	}
	return _bottomHorizontalLine;
}


@end
