//
//  XXLuckyTableViewCell.m
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXLuckyTableViewCell.h"
#import "XXLLuckyCollectionViewCell.h"

@interface XXLuckyTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *periodLabel;
@property(nonatomic,strong)UILabel *dateLabel;

@end

@implementation XXLuckyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *periodLabel = [UILabel new];
        [self addSubview:periodLabel];
        _periodLabel = periodLabel;
        [periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
        }];
        periodLabel.font = [UIFont systemFontOfSize:13];
        periodLabel.textColor = [UIColor grayColor];
        
        UILabel *dateLabel = [UILabel new];
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(periodLabel.mas_right).mas_offset(5);
            make.top.mas_equalTo(10);
        }];
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textColor = [UIColor grayColor];
        UIView *lineView = [UIView new];
        [self addSubview:lineView];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.periodLabel.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(30);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
        lineView.backgroundColor = GlobalLightGreyColor;
        
    }
    return self;
}

-(void)setDataModel:(XXLuckyDataModel *)dataModel
{
    _dataModel = dataModel;
    _periodLabel.text = [NSString stringWithFormat:@"第%@期",dataModel.lottery_qh];
    _dateLabel.text = [NSString stringWithFormat:@"%@",dataModel.real_kj_time];
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataModel.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXLLuckyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"luckyCell" forIndexPath:indexPath];
    cell.number = [NSString stringWithFormat:@"%02ld",(long)[self.dataModel.dataArr[indexPath.item] integerValue]];
    cell.btn.layer.masksToBounds = YES;
    cell.btn.layer.cornerRadius = 5;
    cell.btn.backgroundColor = self.dataModel.colorArr[indexPath.item];
    return cell;
}
-(UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(30, 30);
        layout.minimumLineSpacing =0;
        layout.minimumInteritemSpacing = (MCScreenWidth - 20 - 30 * 10)/9;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, MCScreenWidth - 20, 30) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
        collectionView.scrollEnabled = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[XXLLuckyCollectionViewCell class] forCellWithReuseIdentifier:@"luckyCell"];
    }
    return _collectionView;
}



@end
