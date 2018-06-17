//
//  HomeCollectionViewCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/3.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "HomeButtonModel.h"

@interface HomeCollectionViewCell ()

@property (nonatomic, retain) UIView *markView;
@property (nonatomic, weak) id info_data;
@property (nonatomic, weak) NSIndexPath *info_indexPath;
@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat imgX;

@end

@implementation HomeCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.imgWidth = self.bounds.size.width / 3;
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
    }
}

- (void)storeWeakValueWithData:(id)data indexPath:(NSIndexPath *)indexPath {
    self.info_data = data;
    self.info_indexPath = indexPath;
}

- (void)registerNSNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterEvent:) name:NOTIFICATION_TIME object:nil];
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

- (void)configureUI {
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.imgX);
        make.left.equalTo(self).offset(self.imgX);
        make.bottom.equalTo(self).offset(-self.imgX);
        make.width.mas_equalTo(self.imgWidth);
    }];
    [self addSubview:self.title];
    [self addSubview:self.content];
    
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
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.imgWidth + self.imgX*2 , self.imgX, self.imgWidth * 1.5, self.cellHeight / 2)];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font =  MCFont(kAdapterFontSize(16));
    }
    return _title;
}

- (UILabel *)content {
    if (_content == nil) {
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(self.imgWidth + self.imgX*2, self.cellHeight / 2 - self.imgX, self.imgWidth * 1.9, self.cellHeight / 2)];
        self.content.textAlignment = NSTextAlignmentLeft;
        self.content.font = MCFont(kAdapterFontSize(14));
        self.content.textColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:1/1.0];
    }
    return _content;
}

- (UIView *)markView {
    if (_markView == nil) {
        _markView = [[UIView alloc] init];
        
        _markView.transform = CGAffineTransformMakeRotation(M_PI_4);
        _markView.backgroundColor = [UIColor colorWithRed:246/255.0 green:244/255.0 blue:230/255.0 alpha:1.0];
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
        _rightVerticalLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:233/255.0 blue:216/255.0 alpha:1.0f];
    }
    return _rightVerticalLine;
}

- (UIView *)bottomHorizontalLine {
    if (_bottomHorizontalLine == nil) {
        _bottomHorizontalLine = [[UIView alloc] init];
        _bottomHorizontalLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:233/255.0 blue:216/255.0 alpha:1.0f];
    }
    return _bottomHorizontalLine;
}

@end

