//
//  KKFindSortViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/7.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindSortViewController.h"

#import "HomeButtonModel.h"
#import "HomeButtonModel.h"
#import "HomeSubButtonModel.h"
#import "KKLotterySortSectionView.h"
#import "KKLotterySortButton.h"
#import "KKLotterySortHeadView.h"
@interface KKFindSortViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) KKLotterySortHeadView *headView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation KKFindSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self basicSetting];
    [self getCpTpyeNetWorking];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"全部彩种";
 
    self.navigationItem.rightBarButtonItem = self.noticeButtonItem;
    //[MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(23, 23) target:self selected:@selector(doubtClick) image:@"icon-buttonitem-wenhao" isLeft:NO];
    
}



-(void) initUI {
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_offset(0);
    }];
}



-(void)headClick{
    if ([self.delegate respondsToSelector:@selector(didClickAll:)] && self.delegate) {
        [self.delegate didClickAll:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return CGSizeMake(MCScreenWidth, 97);
    }
    
    
    return CGSizeMake(MCScreenWidth, 30);;
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count + 1;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return 0;
    }
    
    HomeButtonModel *model = [self.dataArray objectAtIndex:section - 1];
    return model.sub_lottery.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKLotterySortButton *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    HomeButtonModel *model = [self.dataArray objectAtIndex:indexPath.section - 1];
    
    
    
    
    NSMutableArray * subArray = [HomeSubButtonModel arrayOfModelsFromDictionaries:model.sub_lottery error:nil];
    
    cell.backgroundColor = [UIColor clearColor];

    [cell buildWithData:[subArray objectAtIndex:indexPath.row] index:indexPath.row];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
     view.layer.zPosition = 0.0;
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        NSString *CellIdentifier = @"header";
        //从缓存中获取 Headercell
        KKLotterySortHeadView *cell = (KKLotterySortHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        [cell.clickButton addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        NSString *CellIdentifier = @"header2";
        //从缓存中获取 Headercell
        KKLotterySortSectionView *cell = (KKLotterySortSectionView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor =  [UIColor clearColor];
        HomeButtonModel *model = [self.dataArray objectAtIndex:indexPath.section - 1];
        [cell buildWithData:model.lottery_label];
       
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeButtonModel *model = [self.dataArray objectAtIndex:indexPath.section - 1];
    
    
    
    
    NSMutableArray * subArray = [HomeSubButtonModel arrayOfModelsFromDictionaries:model.sub_lottery error:nil];
    
    HomeSubButtonModel *subModel = [subArray objectAtIndex:indexPath.row];
    
    
    if ([self.delegate respondsToSelector:@selector(didClickLottery:lottery_id:lottery_title:)] && self.delegate) {
        
        
        
        [self.delegate didClickLottery:self lottery_id:subModel.lottery_id lottery_title:subModel.lottery_name];
        [self.navigationController popViewControllerAnimated:YES];
     
    }
}

-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ceil(MCScreenWidth / 3.0)-1 , ceil(MCScreenWidth / 3.0)-1);
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:[KKLotterySortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        
        [_collectionView registerClass:[KKLotterySortSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
        
        [_collectionView registerClass:[KKLotterySortButton self] forCellWithReuseIdentifier:@"cell"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


-(KKLotterySortHeadView *)headView {
    if (_headView == nil) {
        _headView = [[KKLotterySortHeadView alloc] init];
        
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

#pragma mark 所有的彩票类型
- (void)getCpTpyeNetWorking {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/gc/get-cp-type"];
    NSDictionary *param = @{};
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
        
        
        NSMutableArray *dataArray =  [HomeButtonModel arrayOfModelsFromDictionaries:data error:nil];
        self.dataArray = dataArray;
        [self.collectionView reloadData];
     
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
