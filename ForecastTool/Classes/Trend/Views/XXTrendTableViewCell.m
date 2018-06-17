//
//  XXTrendTableViewCell.m
//  ForecastTool
//
//  Created by hello on 2018/6/7.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXTrendTableViewCell.h"
#import "XXLLuckyCollectionViewCell.h"

@interface XXTrendTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *periodLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation XXTrendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *periodLabel = [UILabel new];
        [self addSubview:periodLabel];
        _periodLabel = periodLabel;
        [periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
        periodLabel.font = [UIFont systemFontOfSize:13];
        periodLabel.textColor = [UIColor grayColor];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(120);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

-(void)setDataModel:(XXLuckyDataModel *)dataModel
{
    _dataModel = dataModel;
    _periodLabel.text = [NSString stringWithFormat:@"第%@期",dataModel.lottery_qh];
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataModel.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXLLuckyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"luckyCell" forIndexPath:indexPath];
    cell.ranking = self.dataModel.rankingArr[indexPath.item];
    return cell;
}
-(UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(60, 30);
        layout.minimumLineSpacing =0;
        layout.minimumInteritemSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, MCScreenWidth, 30) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
        collectionView.scrollEnabled = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[XXLLuckyCollectionViewCell class] forCellWithReuseIdentifier:@"luckyCell"];
    }
    return _collectionView;
}

-(NSMutableArray *)dataArr{
    if(_dataArr == nil){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
