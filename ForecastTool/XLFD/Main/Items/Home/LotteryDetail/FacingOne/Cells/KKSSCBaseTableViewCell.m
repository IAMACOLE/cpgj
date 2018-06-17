//
//  KKSSCBaseTableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/2/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKSSCBaseTableViewCell.h"
#import "KKSSCBaseCollectionViewCell.h"
#import "LotteryDetailModel.h"

@interface KKSSCBaseTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIButton *titleBtn;
@property(nonatomic,strong)UICollectionView *dataCollectionView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *selectBtn;

@end

@implementation KKSSCBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat cellWidth = kAdapterWith(42);
    
    UIButton *titleBtn = [UIButton new];
    [self addSubview:titleBtn];
    self.titleBtn = titleBtn;
    titleBtn.titleLabel.font = MCFont(12);
    titleBtn.clipsToBounds = YES;
    [titleBtn setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-digit"] forState:UIControlStateNormal];
    titleBtn.titleLabel.textColor = [UIColor whiteColor];
    titleBtn.titleLabel.numberOfLines = 0;
    self.titleBtn.frame = CGRectMake(12, 16, 50, 20);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(cellWidth, cellWidth);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = (MCScreenWidth - 84 - 6*cellWidth)/5;
    UICollectionView *dataCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(72, 8, MCScreenWidth - 84, cellWidth * 2 + 5) collectionViewLayout:layout];
    [self addSubview:dataCollectionView];
    dataCollectionView.delegate =self;
    dataCollectionView.dataSource = self;
    dataCollectionView.scrollEnabled = NO;
    dataCollectionView.backgroundColor = [UIColor clearColor];
    _dataCollectionView = dataCollectionView;
    [dataCollectionView registerClass:[KKSSCBaseCollectionViewCell class] forCellWithReuseIdentifier:@"sscBaseCell"];
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    _bottomView = bottomView;
    
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.backgroundColor = MCUIColorLighttingBrown;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *line2View = [[UIImageView alloc]init];
    line2View.backgroundColor = MCUIColorLighttingBrown;
    [self addSubview:line2View];
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];

    NSArray *selectArray = @[@"全",@"大",@"小",@"单",@"双",@"清"];
    CGFloat btnWidth = MCScreenWidth / selectArray.count;
    for(int i = 0;i < selectArray.count;i++){
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * btnWidth, CGRectGetMinY(bottomView.frame), btnWidth, 30)];
        [bottomView addSubview:btn];
        btn.titleLabel.font = MCFont(14);
        UIImageView *linView1 = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width-1, 0, 1, 30)];
        linView1.backgroundColor = MCUIColorLighttingBrown;
        [btn addSubview:linView1];
        [btn setTitle:selectArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:MCUIColorMain forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-class-select"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectStatusClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 200+i;
    }
    
   
}

-(void)setDataModel:(KKLotteryDataModel *)dataModel{
    _dataModel = dataModel;
    for(UIView *subView in self.bottomView.subviews){
        if(subView.tag >= 200){
            UIButton *btn = (UIButton *)subView;
            btn.enabled = dataModel.isAlreadyGetData;
            btn.selected = (_dataModel.selectedBtnIndex == btn.tag);
        }
    }
    NSInteger row = dataModel.dataSource.count % 6 ? dataModel.dataSource.count /6 + 1 : dataModel.dataSource.count /6;
    _dataCollectionView.frame = CGRectMake(72, 8, MCScreenWidth - 84, kAdapterWith(42) * row + (row - 1) * 5);
    NSArray *comArr = [self.wf_flag componentsSeparatedByString:@"_"];
    if ([self.wf_flag  isEqual: @"ssc_lhd"] || [comArr[1] isEqual:@"dxds"]) {
        _bottomView.hidden = YES;
    }else{
        _bottomView.hidden = NO;
    }
    [self.dataCollectionView reloadData];
}

-(void)selectStatusClick:(UIButton *)sender{
    if(sender.tag == self.selectBtn.tag){
        if (sender.isSelected) {
            return;
        }
    }
    sender.selected = YES;
    NSInteger index = sender.tag-200;
    
    switch (index) {
        case 0:
            for(LotteryDetailModel *model in _dataModel.dataSource){
                model.isSelect = YES;
            }
            break;
        case 1:
            for(int index = 0;index < _dataModel.dataSource.count ;index++){
                LotteryDetailModel *model = _dataModel.dataSource[index];
                model.isSelect = index+1 > _dataModel.dataSource.count/2;
            }
          
            break;
        case 2:
            for(int index = 0;index < _dataModel.dataSource.count ;index++){
                LotteryDetailModel *model = _dataModel.dataSource[index];
                model.isSelect = index+1 <= _dataModel.dataSource.count/2;
            }
            break;
        case 3:
            for(LotteryDetailModel *model in _dataModel.dataSource){
                model.isSelect = [model.number integerValue] % 2 != 0;
            }
            break;
        case 4:
            for(LotteryDetailModel *model in _dataModel.dataSource){
                model.isSelect = [model.number integerValue] % 2 == 0;
            }
            break;
        case 5:
            for(LotteryDetailModel *model in _dataModel.dataSource){
                model.isSelect = NO;
            }
            break;
        default:
            break;
    }
    self.selectBtn.selected = NO;
    _dataModel.selectedBtnIndex = sender.tag;
    self.selectBtn = sender;
    [self.dataCollectionView reloadData];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectNumber)]) {
        [self.delegate selectNumber];
    }
}

-(void)setCellTitle:(NSString *)cellTitle{
    _cellTitle  = cellTitle;
    CGFloat height = 0;
    NSString *imageStr = @"";
    [_titleBtn setTitle:cellTitle forState:UIControlStateNormal];
    if(_cellTitle.length < 4){
        height = 20;
        imageStr = @"icon-lotterydetail-digit";
        [_titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,5)];
    }else if(_cellTitle.length < 7){
        height = 40;
        imageStr = @"icon-lotterydetail-digit2";
        [_titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0,10)];
    }else{
        height = 60;
        imageStr = @"icon-lotterydetail-digit3";
        [_titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0,10)];
    }
    
    self.titleBtn.frame = CGRectMake(12, 16, 50, height);
    [_titleBtn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LotteryDetailModel *model = self.dataModel.dataSource[indexPath.item];
    model.isSelect = !model.isSelect;
    [self.dataCollectionView reloadData];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectNumber)]) {
        [self.delegate selectNumber];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataModel.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KKSSCBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sscBaseCell" forIndexPath:indexPath];
    LotteryDetailModel *model = self.dataModel.dataSource[indexPath.item];
    [cell.btn setTitle:model.number forState:UIControlStateNormal];
    cell.btn.selected = model.isSelect;
    cell.userInteractionEnabled = self.dataModel.isAlreadyGetData;
    cell.didSelectedCellBlock = ^{
        [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    };
    return cell;
}

@end
