//
//  MineCollectionViewCell.m
//  Kingkong_ios
//
//  Created by 222 on 2018/2/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "MineCollectionViewCell.h"
#import "KKMineModel.h"

@interface MineCollectionViewCell()

@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat imgX;

@end

@implementation MineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.imgWidth = self.bounds.size.width / 8;
    self.cellHeight = self.bounds.size.height;
    self.imgX = (self.cellHeight - self.imgWidth) / 2;
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)loadData:(id)data AndIndexPath:(NSIndexPath *)indexPath {
    if ([data isMemberOfClass:[KKMineModel class]]) {
        KKMineModel *model = (KKMineModel *)data;
        self.titleLabel.text = model.title;
        self.imgView.image = [UIImage imageNamed:model.image];
    }
}

- (void)configureUI {
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.imgX);
        make.left.equalTo(self).offset(self.imgX);
        make.bottom.equalTo(self).offset(-self.imgX);
        make.width.mas_equalTo(self.imgWidth);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(5);
        make.centerY.equalTo(self.imgView);
    }];
    
//    [self addSubview:self.rightVerticalLine];
//    [self.rightVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self);
//        make.width.mas_equalTo(0.5);
//        make.top.equalTo(self).offset(12);
//        make.bottom.equalTo(self).offset(-12);
//    }];
//    [self addSubview:self.bottomHorizontalLine];
//    [self.bottomHorizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.left.equalTo(self);
//        make.height.mas_equalTo(0.5);
//    }];
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        self.imgView = [[UIImageView alloc] init];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.userInteractionEnabled = NO;
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font =  MCFont(kAdapterFontSize(14));
        [self.titleLabel sizeToFit];
    }
    return _titleLabel;
}

//- (UIView *)rightVerticalLine {
//    if (_rightVerticalLine == nil) {
//        _rightVerticalLine = [[UIView alloc] init];
//        _rightVerticalLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:233/255.0 blue:216/255.0 alpha:1.0f];
//    }
//    return _rightVerticalLine;
//}
//
//- (UIView *)bottomHorizontalLine {
//    if (_bottomHorizontalLine == nil) {
//        _bottomHorizontalLine = [[UIView alloc] init];
//        _bottomHorizontalLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:233/255.0 blue:216/255.0 alpha:1.0f];
//    }
//    return _bottomHorizontalLine;
//}

@end
