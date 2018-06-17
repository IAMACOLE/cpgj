//
//  KKTrend_round_colectionViewCell.m
//  Kingkong_ios
//
//  Created by goulela on 2017/6/24.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKTrend_round_colectionViewCell.h"
#import "KKTrend_round_colectionViewModel.h"

@interface KKTrend_round_colectionViewCell ()

@property (nonatomic, strong)  UIImageView *trendRoundCellBgView ;
@property (nonatomic, strong) UILabel * label;

@end

@implementation KKTrend_round_colectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}


- (void)addSubviews {
    
    UIImageView *trendRoundCellBgView = [UIImageView new];
    [self addSubview:trendRoundCellBgView];
    _trendRoundCellBgView = trendRoundCellBgView;
    [trendRoundCellBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    trendRoundCellBgView.image = [UIImage imageNamed:@"cell-trend-round-bg"];
    
    [self addSubview:self.label];
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - setter & getter 

- (void)setModel:(KKTrend_round_colectionViewModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.label.text = self.model.code;

}

- (UILabel *)label {
    if (_label == nil) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont boldSystemFontOfSize:kAdapterFontSize(15)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = MCUIColorWhite;
    } return _label;
}

@end
