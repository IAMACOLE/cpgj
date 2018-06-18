//
//  XXSamePeriodHeadView.m
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXSamePeriodHeadView.h"
#import "XXSamePeriodCollectionViewCell.h"

@interface XXSamePeriodHeadView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UIView *bgView;//背景
@property(nonatomic,weak)UIView *titleView;
@property(nonatomic,weak)UILabel *titleLabel;//标题
@property(nonatomic,weak)UILabel *timeLalbe;//时间
@property(nonatomic,weak)UIButton *selectButton;
@property(nonatomic,weak)UIView *line;
@property(nonatomic,weak)UICollectionView *collectionView;
@end

@implementation XXSamePeriodHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

#pragma mark 界面初始化
-(void)addSubviews{
    [self bgView];
    [self titleView];
    [self titleLabel];
    [self timeLalbe];
    [self selectButton];
//    [self line];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
    }];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _bgView = bgView;
    }
    return _bgView;
}

-(UIView *)titleView{
    if (_titleView == nil) {
        UIView *titleView = [[UIView alloc]init];
        titleView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self addSubview:titleView];
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@60);
        }];
        
        _titleView = titleView;
    }
    return _titleView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = @"本期结果：2018089";
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(@10);
            make.right.equalTo(self.mas_right).offset(-60);
        }];
        
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)timeLalbe{
    if (_timeLalbe == nil) {
        UILabel *timeLalbe = [[UILabel alloc]init];
        timeLalbe.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
        timeLalbe.font = [UIFont systemFontOfSize:14];
        timeLalbe.text = @"开奖时间：2018-6-6 20:30:05";
        [self addSubview:timeLalbe];
        
        [timeLalbe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-60);
        }];
        
        _timeLalbe = timeLalbe;
    }
    return _timeLalbe;
}

-(UIButton *)selectButton{
    if (_selectButton == nil) {
        UIButton *selectButton = [[UIButton alloc]init];
        [selectButton setImage:[UIImage imageNamed:@"selectButton_image"] forState:UIControlStateNormal];
        [selectButton addTarget:self action:@selector(clickSelectButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectButton];
        
        [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.width.height.equalTo(@40);
            make.right.equalTo(self).offset(-10);
        }];
        
        _selectButton = selectButton;
    }
    return _selectButton;
}

-(UIView *)line{
    if (_line == nil) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.equalTo(@10);
            make.bottom.equalTo(self);
        }];
        
        _line = line;
    }
    return _line;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XXSamePeriodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SamePeriodCollectionViewCell" forIndexPath:indexPath];
    cell.number = @"08";
    cell.cellHight = 40;
    return cell;
}
-(UICollectionView *)collectionView{
    if(_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(40, 40);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = (MCScreenWidth - 40-40*5)/5;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 0, MCScreenWidth - 40, 100) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.scrollEnabled = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[XXSamePeriodCollectionViewCell class] forCellWithReuseIdentifier:@"SamePeriodCollectionViewCell"];
        
         _collectionView = collectionView;
    }
    return _collectionView;
}



-(void)clickSelectButton{
    self.clickSelectBtn();
}


@end
