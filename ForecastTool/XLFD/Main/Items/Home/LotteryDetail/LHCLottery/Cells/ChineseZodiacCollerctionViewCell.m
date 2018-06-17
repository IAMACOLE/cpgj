//
//  ChineseZodiacCollerctionViewCell.m
//  Demo_色播赔率
//
//  Created by goulela on 2017/8/2.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "ChineseZodiacCollerctionViewCell.h"



@interface ChineseZodiacCollerctionViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UIView  * bgView;
@property (nonatomic, strong) UIView  * itemsView;
@property (nonatomic, strong) UILabel * bottomLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic ,strong)  UIButton *selectButton;
@property (nonatomic, strong) UIImageView *itemsBgView;
@property (nonatomic, strong) UIColor *textColor;

@end

@implementation ChineseZodiacCollerctionViewCell

#define margin 7
#define MCScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCellReuseId @"cell"

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}
-(void)setModel:(LHCLotteryModel *)model{
    _model = model;
    self.titleLabel.text = model.flag;
    self.bottomLabel.text = [NSString stringWithFormat:@"%.2f",[model.award_money floatValue]];
    if (self.isChineseHX) {
        self.bottomLabel.hidden = YES;
    }else{
        self.bottomLabel.hidden = NO;
    }
    self.selectButton.selected = YES;
    [self seleButtonClick:self.selectButton];
    self.dataArray = [model.value componentsSeparatedByString:@","];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.text = self.dataArray[indexPath.row];
    if (self.isChineseHX &&indexPath.row == 4) {
        label.text = @"";
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = _textColor;
   
    [cell addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(cell);
    }];
    
    return cell;
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
    self.itemsBgView.image = [UIImage imageNamed:@"shengXiaoCellBg-nor"];
    [self.itemsView addSubview:self.itemsBgView];
    [self.itemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    CGFloat cellWidth = (MCScreenWidth) / 3;
    CGFloat cellHeight = cellWidth*0.9 - 30;
    CGFloat wantDistance = cellHeight / 5;
    
    [self.itemsView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView).with.offset(wantDistance);
        make.height.mas_equalTo(30);
    }];
    
    [self.itemsView addSubview:self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.itemsView);
        make.height.mas_equalTo(wantDistance);
        make.bottom.mas_equalTo(self.itemsView.mas_bottom).with.offset(-wantDistance);
    }];
    
    [self addSubview:self.selectButton];
    [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
    
}
-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]init];
        [_selectButton addTarget:self action:@selector(seleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.backgroundColor = [UIColor clearColor];
    }
    return _selectButton;
}
-(void)seleButtonClick:(UIButton *)sender{
    
    _textColor =  sender.selected ?    MCUIColorMain : MCUIColorWhite;
    if (sender.selected) {
        sender.selected = NO;
        _model.isSelect = nil;
        self.itemsBgView.image = [UIImage imageNamed:@"shengXiaoCellBg-nor"];
    }else{
        _model.isSelect = @"1";
        self.itemsBgView.image = [UIImage imageNamed:@"shengXiaoCellBg-sel"];
        sender.selected = YES;
    }
    if (self.selectBlock) {
        self.selectBlock(self.isChineseHX);
    }
    [self.collectionView reloadData];
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
        _titleLabel.text = @"龙";
        _titleLabel.textColor = [UIColor blackColor];
    } return _titleLabel;
}

- (UILabel *)bottomLabel {
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.text = @"11.6";
        _bottomLabel.textColor = MCUIColorMain;
    } return _bottomLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        CGFloat cellWidth = (MCScreenWidth) / 3;
        
        CGFloat itemW = (cellWidth-10 - margin * 2) / 5;
        CGFloat itemH = itemW * 0.8;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        
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
