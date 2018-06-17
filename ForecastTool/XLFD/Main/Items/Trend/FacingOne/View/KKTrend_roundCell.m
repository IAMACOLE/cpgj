//
//  KKTrend_roundCell.m
//  Kingkong_ios
//
//  Created by goulela on 2017/6/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKTrend_roundCell.h"

#import "KKTrendModel.h"

#import "KKTrend_round_colectionViewCell.h"
#import "KKTrend_round_colectionViewModel.h"

@interface KKTrend_roundCell ()
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

@implementation KKTrend_roundCell

#define kReuseCollectionCell @"cell"

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    } return self;
}

- (void)coverButtonClicked {

    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(KKTrend_roundCell_jumpWithIndex:)]) {
        [self.customDelegate KKTrend_roundCell_jumpWithIndex:self.index];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    KKTrend_round_colectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCollectionCell forIndexPath:indexPath];
    
    for (UIView * subView in cell.superview.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.model = self.collectionDataArrayM[indexPath.row];
    
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
    
//    [self.bgView addSubview:self.lineView];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(self.bgView).with.offset(0);
//        make.right.mas_equalTo(self.bgView).with.offset(0);
//        make.bottom.mas_equalTo(self.bgView).with.offset(0);
//        make.height.mas_equalTo(1);
//    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView).with.offset(15);
        make.left.mas_equalTo(self.bgView).with.offset(15);
        make.height.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.periodicalLabel];
    [self.periodicalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(10);
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
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(15);
        make.bottom.mas_equalTo(self.bgView).with.offset(-1);
    }];
    
    [self addSubview:self.coverButton];
    [self.coverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - setter & getter

- (void)setModel:(KKTrendModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    
    [self.collectionDataArrayM removeAllObjects];
    
    self.nameLabel.text = self.model.lottery_name;
    self.periodicalLabel.text = [NSString stringWithFormat:@"%@期",self.model.lottery_qh];
    self.timeLabel.text = [MCTool BSNSString_cutOutFromZeroPositionWithLength:16 andText:self.model.real_kj_time];
    
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];
    NSArray * codeArray = @[];
    if (self.model.kj_code.length > 0) {
        

        codeArray = [self.model.kj_code componentsSeparatedByString:@","];
        for (NSString * str in codeArray) {
            
            NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithCapacity:0];
            [dictM setObject:str forKey:@"code"];
            [dictM setObject:@(0) forKey:@"sign"];
            [arrayM addObject:dictM];
        }
    }
    
    
    NSString * show_type = model.show_type;
    
    if ([show_type isEqualToString:@"1"]) {
        
    } else if ([show_type isEqualToString:@"2"]) {
       
        if (arrayM.count > 1) {
            NSDictionary * dict = arrayM[arrayM.count -1];
            NSMutableDictionary * subDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
            [subDictM setObject:@(1) forKey:@"sign"];
            [arrayM replaceObjectAtIndex:arrayM.count -1 withObject:subDictM];

        }
        
    } else if ([show_type isEqualToString:@"3"]) {
        
        if (arrayM.count > 2) {
            NSDictionary * dict = arrayM[arrayM.count -1];
            NSMutableDictionary * subDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
            [subDictM setObject:@(1) forKey:@"sign"];
            [arrayM replaceObjectAtIndex:arrayM.count -1 withObject:subDictM];
            
            NSDictionary * dict2 = arrayM[arrayM.count -2];
            NSMutableDictionary * subDictM2 = [NSMutableDictionary dictionaryWithDictionary:dict2];
            [subDictM2 setObject:@(1) forKey:@"sign"];
            [arrayM replaceObjectAtIndex:arrayM.count -2 withObject:subDictM2];
        }
    }


    for (NSDictionary * dict in arrayM) {
        KKTrend_round_colectionViewModel * model = [[KKTrend_round_colectionViewModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.collectionDataArrayM addObject:model];
    }
    [self.collectionView reloadData];
    
}

-(void)setIsHideArrowView:(BOOL)isHideArrowView{
    _isHideArrowView = isHideArrowView;
    _arrowImageView.hidden = isHideArrowView;
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
        self.nameLabel.font = [UIFont boldSystemFontOfSize: kAdapterFontSize(15)];
        self.nameLabel.textColor = MCUIColorWhite;
    } return _nameLabel;
}

- (UILabel *)periodicalLabel {
    if (_periodicalLabel == nil) {
        self.periodicalLabel = [[UILabel alloc] init];
        self.periodicalLabel.font = MCFont(kAdapterFontSize(12));
        self.periodicalLabel.textColor = MCUIColorWhite;
    } return _periodicalLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = MCFont(kAdapterFontSize(12));
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
    }
    return _arrowImageView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {

        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kAdapterWith(36), kAdapterWith(36));
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
        layout.minimumLineSpacing = kAdapterWith(11);
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[KKTrend_round_colectionViewCell class] forCellWithReuseIdentifier:kReuseCollectionCell];
        
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
