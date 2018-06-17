//
//  XXHomeViewController.m
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXHomeViewController.h"
#import "XXHomeCollectionViewCell.h"
#import "XXLuckyViewController.h"
#import "XXTrendViewController.h"

@interface XXHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *titleArr;

@end

@implementation XXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能列表";
    [self.view addSubview:self.collectionView];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.item == 0){
        XXLuckyViewController *luckyVC = [XXLuckyViewController new];
        [self.navigationController pushViewController:luckyVC animated:YES];
    }else if (indexPath.item == 1){
        XXTrendViewController *trendVC = [XXTrendViewController new];
        [self.navigationController pushViewController:trendVC animated:YES];
    }
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XXHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.iconView.image = [UIImage imageNamed:self.titleArr[indexPath.item]];
    cell.title.text = self.titleArr[indexPath.item];
    return cell;
}


-(UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemW = MCScreenWidth/2-0.5;
        layout.itemSize = CGSizeMake(itemW, itemW + 25);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, MCScreenHeight - 64) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _collectionView = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[XXHomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    }
    return _collectionView;
}


-(NSMutableArray *)titleArr{
    if(_titleArr == nil){
        _titleArr = [NSMutableArray arrayWithObjects:@"开奖公告",@"走势图",@"历史同期",@"统计",@"相似走势",@"号码组合",@"号码契合度",@"关于我们",nil];
    }
    return _titleArr;
}

@end
