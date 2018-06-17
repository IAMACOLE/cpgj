//
//  KKTrend_rectangularCell.m
//  Kingkong_ios
//
//  Created by goulela on 2017/6/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKTrend_rectangularCell.h"

#import "KKTrendModel.h"


@interface KKTrend_rectangularCell ()
<
UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
>
@property (nonatomic, strong) UIView  * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * periodicalLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIView  * lineView;
@property (nonatomic, strong) UIImageView * arrowImageView;

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * collectionDataArrayM;

@property (nonatomic, strong) UIButton * coverButton;


@end

@implementation KKTrend_rectangularCell

#define kReuseCollectionCell @"cell"

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    } return self;
}

- (void)coverButtonClicked {
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(KKTrend_rectangularCell_jumpWithIndex:)]) {
        [self.customDelegate KKTrend_rectangularCell_jumpWithIndex:self.index];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCollectionCell forIndexPath:indexPath];
    
    for (UIView * subView in cell.superview.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat scale;
    if (MCScreenWidth < 350) {
        scale = 0.8;
    } else if (MCScreenWidth >= 350 && MCScreenWidth < 400) {
        scale = 0.95;
    } else {
        scale = 1;
    }
    
    UIImageView *imageView = [UIImageView new];
    [cell addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.mas_equalTo(cell);
    }];
    imageView.image = [UIImage imageNamed:@"cell-trend-square-bg"];

    UILabel * label = [[UILabel alloc] init];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = MCFont(13);
    label.textColor = MCUIColorWhite;
    label.text = [self.collectionDataArrayM objectAtIndex:indexPath.row];
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(cell);
    }];
    
    return cell;
}



- (void)addSubviews {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIImageView *bgImageView = [UIImageView new];
    [self.bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    bgImageView.image = [UIImage imageNamed:@"find-lottery-cell"];
    
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(0);
        make.right.mas_equalTo(self.bgView).with.offset(0);
        make.bottom.mas_equalTo(self.bgView).with.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView).with.offset(15);
        make.left.mas_equalTo(self.bgView).with.offset(15);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.periodicalLabel];
    [self.periodicalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
        make.centerY.mas_equalTo(self.nameLabel).with.offset(0);
        make.height.mas_equalTo(14);
    }];
    
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.nameLabel).with.offset(0);
        make.height.mas_equalTo(14);
    }];
    
    [self.bgView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).with.offset(-20);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(8, 14));
    }];
    
    
    [self.bgView addSubview:self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(0);
        make.right.mas_equalTo(self.bgView).with.offset(-25);
        make.top.mas_equalTo(self.periodicalLabel.mas_bottom).with.offset(15);
        make.bottom.mas_equalTo(self.bgView).with.offset(-1);
    }];
    
    [self addSubview:self.coverButton];
    [self.coverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - setter & getter

-(void)setIsHideArrowView:(BOOL)isHideArrowView{
    _isHideArrowView = isHideArrowView;
    _arrowImageView.hidden = isHideArrowView;
}

- (void)setModel:(KKTrendModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    
    [self.collectionDataArrayM removeAllObjects];

    
    self.nameLabel.text = self.model.lottery_name;
    self.periodicalLabel.text = [NSString stringWithFormat:@"%@期",self.model.lottery_qh];
    self.timeLabel.text = [MCTool BSNSString_cutOutFromZeroPositionWithLength:16 andText:self.model.real_kj_time];
    
    NSArray * codeArray = @[];
    if (self.model.kj_code.length > 0) {
        
        
        codeArray = [self.model.kj_code componentsSeparatedByString:@","];
    }
    
    self.collectionDataArrayM = [codeArray mutableCopy];
    [self.collectionView reloadData];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor clearColor];
    } return _bgView;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = MCUIColorLightGray;
    } return _lineView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = MCFont(16);
        self.nameLabel.textColor = MCUIColorWhite;
    } return _nameLabel;
}

- (UILabel *)periodicalLabel {
    if (_periodicalLabel == nil) {
        self.periodicalLabel = [[UILabel alloc] init];
        self.periodicalLabel.font = MCFont(12);
        self.periodicalLabel.textColor = MCUIColorWhite;
    } return _periodicalLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = MCUIColorFromRGB(0xE4BBBB);
        CGFloat font;
        
        if (MCScreenWidth < 350) {
            font = 12;
        } else {
            font = 14;
        }
        self.timeLabel.font = MCFont(font);

    } return _timeLabel;
}

- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        self.arrowImageView = [[UIImageView alloc] init];
        self.arrowImageView.image = [UIImage imageNamed:@"Reuse_arrow"];
    } return _arrowImageView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        
        CGFloat scale;
        if (MCScreenWidth < 350) {
            scale = 0.8;
        } else if (MCScreenWidth >= 350 && MCScreenWidth < 400) {
            scale = 0.95;
        } else {
            scale = 1;
        }
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(20*scale, 30*scale);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReuseCollectionCell];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
    }
    return _collectionView;
}

- (NSMutableArray *)collectionDataArrayM {
    if (_collectionDataArrayM == nil) {
        self.collectionDataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _collectionDataArrayM;
}

- (UIButton *)coverButton {
    if (_coverButton == nil) {
        self.coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.coverButton addTarget:self action:@selector(coverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _coverButton;
}

@end
