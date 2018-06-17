//
//  ChaseLotteryViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "ChaseLotteryViewController.h"
#import "SameChaseViewController.h"
#import "DoubleChaseViewController.h"
@interface ChaseLotteryViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UINavigationControllerDelegate>
@property(nonatomic,strong)UIPageViewController *pageView;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)NSMutableArray *VcArray;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation ChaseLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPageViewController];
    [self initUI];
}
-(void)initUI{
    self.titleString = @"追号";
    NSArray *array = @[@"同倍追号",@"翻倍追号"];
    for (int i=0; i<array.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*MCScreenWidth/array.count, 0, MCScreenWidth/array.count, 50)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:MCUIColorMiddleGray forState:UIControlStateNormal];
        [btn setTitleColor:MCUIColorMain forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=200+i;
        if (i==0) {
            [self btnClick:btn];
        }
        [_pageView.view addSubview:btn];
    }
    [self.pageView.view addSubview:self.lineView];
    
}
-(void)btnClick:(UIButton *)btn{
    _selectBtn.selected =NO;
    btn.selected = YES;
    _selectBtn = btn;
    NSInteger index = btn.tag-200;
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.frame = CGRectMake(MCScreenWidth/2*index, 48, MCScreenWidth/2, 2);
    }];
    SameChaseViewController *sameVc = (SameChaseViewController*)_VcArray[0];
    DoubleChaseViewController *doubleVc = (DoubleChaseViewController*) _VcArray[1];
    switch (index) {
            
        case 0:
            
            [_pageView setViewControllers:@[sameVc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            break;
        case 1:
            [_pageView setViewControllers:@[doubleVc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            break;
            
        default:
            break;
    }
    
    
}
-(void)createPageViewController{
    _VcArray = [[NSMutableArray alloc]init];
    _pageView = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.automaticallyAdjustsScrollViewInsets= NO;
    SameChaseViewController *sameVc = [[SameChaseViewController alloc]init];
    DoubleChaseViewController *doubleVc = [[DoubleChaseViewController alloc]init];
    sameVc.bet_number = self.bet_number;
    sameVc.lottery_modes = self.lottery_modes;
    sameVc.lottery_id = self.lottery_id;
    sameVc.wf_flag = self.wf_flag;
    sameVc.selectAllCount = self.selectAllCount;
    sameVc.bet_times = self.bet_times;
    
    doubleVc.bet_number = self.bet_number;
    doubleVc.lottery_modes = self.lottery_modes;
    doubleVc.lottery_id = self.lottery_id;
    doubleVc.wf_flag = self.wf_flag;
    doubleVc.selectAllCount = self.selectAllCount;
    doubleVc.bet_times = self.bet_times;
    //    brandVc.delegate = self;
    [_VcArray addObject:sameVc];
    [_VcArray addObject:doubleVc];
    
    self.view.frame = CGRectMake(0, 0, MCScreenWidth, MCScreenHeight);
    [_pageView setViewControllers:@[sameVc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageView.view.frame = CGRectMake(0, 0, MCScreenWidth, MCScreenHeight);
    [self.view addSubview:_pageView.view];
    _pageView.delegate = self;
    _pageView.dataSource = self;
}
#pragma mark -- pageViewController的协议方法
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = 0;
    for (UIViewController *VC in _VcArray) {
        index++;
        if ([VC isEqual:viewController]) {
            _currentPage = index;
        }
    }
    if (_currentPage >= _VcArray.count) {
        _currentPage = 0;
        return nil;
    }
    return _VcArray[_currentPage];
}
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = 0;
    for (UIViewController *VC in _VcArray) {
        
        if ([VC isEqual:viewController]) {
            _currentPage = index;
        }
        index++;
    }
    _currentPage--;
    if (_currentPage < 0) {
        _currentPage = _VcArray.count-1;
        return nil;
    }
    return _VcArray[_currentPage];
}
//翻页成功后执行的协议方法
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //获取当前实现的视图控制器对象
    UIViewController *sub = pageViewController.viewControllers[0];
    NSInteger index = 0;
    for (UIViewController *VC in _VcArray) {
        
        if ([VC isEqual:sub]) {
            _currentPage = index;
        }
        index++;
    }
    
    [self btnClick:(UIButton *)[self.view viewWithTag:_currentPage+200]];
}
-(UIView *)lineView{
    if (!_lineView) {
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, MCScreenWidth/2, 2)];
        self.lineView.backgroundColor = MCUIColorMain;
        
    }
    return _lineView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
