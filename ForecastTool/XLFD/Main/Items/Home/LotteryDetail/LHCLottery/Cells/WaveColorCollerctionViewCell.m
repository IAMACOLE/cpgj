//
//  WaveColorCollerctionViewCell.m
//  Demo_色播赔率
//
//  Created by goulela on 2017/8/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "WaveColorCollerctionViewCell.h"
#import "Masonry.h"


@interface WaveColorCollerctionViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, strong) UIView  * bgView;
@property (nonatomic, strong) UIView  * itemsView;
@property (nonatomic, strong) UILabel * bottomLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * cellLabel;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong)  UIButton *selectButton;
@property (nonatomic, strong) UIImageView *itemsBgView;
@property (nonatomic, strong) UIColor *textColor;

@end

@implementation WaveColorCollerctionViewCell

#define margin 7
#define MCScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCellReuseId @"cell"

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.text = self.dataArray[indexPath.item];
    label.textColor = _textColor;
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(cell);
    }];
    
    return cell;
}


-(void)setModel:(LHCLotteryModel *)model{
    _model = model;
    self.titleLabel.text = model.pl_name;
    self.bottomLabel.text = [NSString stringWithFormat:@"%.2f",[model.award_money floatValue]];
    if(_model.isAlreadyGetData){
        self.selectButton.selected = YES;
        [self seleButtonClick:self.selectButton];
    }
    self.selectButton.enabled = _model.isAlreadyGetData;
    [self.collectionView reloadData];
}

- (void)addSubviews {

    self.textColor = MCUIColorMain;
    
    [self addSubview:self.bgView];
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.bgView addSubview:self.bottomLabel];
    [self.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView);
        make.height.mas_equalTo(30);
    }];
    
    [self.bgView addSubview:self.itemsView];
    [self.itemsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(margin);
        make.right.mas_equalTo(self.bgView).with.offset(-margin);
        make.top.mas_equalTo(self.bgView).with.offset(margin);
        make.bottom.mas_equalTo(self.bottomLabel.mas_top);
    }];
    
    self.itemsBgView = [UIImageView new];
    self.itemsBgView.image = [UIImage imageNamed:@"wuxingCellBg-nor"];
    [self.itemsView addSubview:self.itemsBgView];
    [self.itemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.itemsView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView).with.offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.itemsView addSubview:self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.mas_equalTo(self.itemsView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(0);
    }];
    
    [self addSubview:self.selectButton];
    [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
    
}
-(void)seleButtonClick:(UIButton *)sender{
    _textColor =  sender.selected ?    MCUIColorMain : MCUIColorWhite;
    
    if (sender.selected) {
        sender.selected = NO;
        _model.isSelect = NO;
        self.itemsBgView.image = [UIImage imageNamed:@"wuxingCellBg-nor"];
       
    
    }else{
        _model.isSelect = YES;
         self.itemsBgView.image = [UIImage imageNamed:@"wuxingCellBg-sel"];
        sender.selected = YES;
    }
    if (self.selectBlock) {
        self.selectBlock();
    }
    [self.collectionView reloadData];
}
-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]init];
        [_selectButton addTarget:self action:@selector(seleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.backgroundColor = [UIColor clearColor];
    }
    return _selectButton;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    } return _bgView;
}

- (UIView *)itemsView {
    if (_itemsView == nil) {
        _itemsView = [[UIView alloc] init];
        _itemsView.backgroundColor = [UIColor clearColor];
    } return _itemsView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
    } return _titleLabel;
}

- (UILabel *)bottomLabel {
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.textColor = MCUIColorMain;
    } return _bottomLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        CGFloat cellWidth = (MCScreenWidth) / 3;
        CGFloat itemW = cellWidth / 5;
        CGFloat itemH = itemW * 0.8;

        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.scrollEnabled = NO;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellReuseId];
    }
    return _collectionView;
}

@end
