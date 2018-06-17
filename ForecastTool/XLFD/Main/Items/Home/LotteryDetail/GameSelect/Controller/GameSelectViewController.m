//
//  GameSelectViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "GameSelectViewController.h"
#import "GameSelectCollectionViewCell.h"
#import "GameSelectCollectionReusableView.h"
#import "GameSelectModel.h"
#import "GameSelectDetailModel.h"

#define kReuseCollectionCell @"collectionCell"
//section头视图重用标志
#define kHeaderReuseId @"Header"

@interface GameSelectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation GameSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self basicSetting];
    
}
-(void)initUI{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).with.offset(0);
        make.width.mas_equalTo(MCScreenWidth);
        make.top.mas_equalTo(self.view).with.offset(0);
        make.bottom.mas_equalTo(self.view).with.offset(0);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}
- (void)basicSetting {
    self.titleString = @"玩法选择";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.rightBarButtonItem = self.customLeftItem;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MCScreenWidth/3, 46);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GameSelectCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCollectionCell forIndexPath:indexPath];
    
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    cell.model = self.dataArray[indexPath.section][indexPath.item];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GameSelectDetailModel *model = self.dataArray[indexPath.section][indexPath.item];
    model.title = self.titleArray[indexPath.section];
    //六合彩判断要选多少个号码才能算一注
    switch (indexPath.section) {
        case 13:
            model.selectRow = @"6";
            break;
         case 14:
            switch (indexPath.row) {
                case 0:
                   model.selectRow = @"2";
                    break;
                case 1:
                    model.selectRow = @"3";
                    break;
                case 2:
                    model.selectRow = @"4";
                    break;
                case 3:
                    model.selectRow = @"5";
                    break;
                case 4:
                    model.selectRow = @"2";
                    break;
                case 5:
                    model.selectRow = @"3";
                    break;
                case 6:
                    model.selectRow = @"4";
                    break;
                case 7:
                    model.selectRow = @"5";
                    break;
               
                default:
                    break;
            }
            break;
            case 15:
            switch (indexPath.row) {
                case 0:
                    model.selectRow = @"3";
                    break;
                case 1:
                    model.selectRow = @"3";
                    break;
                case 2:
                    model.selectRow = @"2";
                    break;
                case 3:
                    model.selectRow = @"2";
                    break;
                case 4:
                    model.selectRow = @"2";
                    break;
                case 5:
                    model.selectRow = @"4";
                    break;
                    
                default:
                    break;
            }

            break;
        default:
            break;
    }
    if(kStringIsEmpty(model.name) || kStringIsEmpty(model.title)){
       [[NSUserDefaults standardUserDefaults]setObject:@[model.wf_flag,model.wf_pl] forKey:self.lottery_id];
    }else{
        if(kStringIsEmpty(model.selectRow)){
            model.selectRow = @"0";
        }
       [[NSUserDefaults standardUserDefaults]setObject:@[model.wf_flag,model.wf_pl,model.name,model.title,model.selectRow] forKey:self.lottery_id];
    }
    
    self.selectItemClick(model);
    [self.navigationController popViewControllerAnimated:YES];
}

//设置section头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   
    return CGSizeMake(MCScreenWidth, 30);
}

// 返回 头部/尾部 视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //创建头视图
    GameSelectCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderReuseId forIndexPath:indexPath];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    header.titleLabel.text = self.titleArray[indexPath.section];
    return header;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //        layout.itemSize = CGSizeMake(60, 40);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 4;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = MCMineTableViewBgColor;
        [self.collectionView registerClass:[GameSelectCollectionViewCell class] forCellWithReuseIdentifier:kReuseCollectionCell];
        
        // 注册头部视图
        [self.collectionView registerClass:[GameSelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseId];
        self.collectionView.collectionViewLayout = layout;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
