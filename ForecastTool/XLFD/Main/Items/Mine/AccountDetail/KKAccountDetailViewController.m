//
//  KKAccountDetailViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/3/31.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAccountDetailViewController.h"

#import "KKAccountDetailModel.h"
#import "KKAccountDetailCell.h"
#import "KKAccountDetailToolTipView.h"
#import "DDShareModelPopCoverController.h"
#import "KKAccountTypeViewController.h"

@interface KKAccountDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate , UIViewControllerAnimatedTransitioning>{
    NSInteger _pageNumber;
    NSInteger _data_type;   // 1:当天 2:最近三天 3:最近一周 4:最近一月 如果不传，默认为1
    
    NSString *type_value;
    NSString *detail_value;
}
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (nonatomic , assign) BOOL onAnimate;//记录是在弹出还是消失

@property (nonatomic, strong) KKAccountDetailToolTipView * toolTipView;

@end

@implementation KKAccountDetailViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    
    [self initUI];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    KKAccountDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KKAccountDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = MCMineTableCellBgColor;
    cell.model = self.dataArrayM[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.toolTipView removeFromSuperview];
    self.toolTipView = nil;
    self.toolTipView.model = self.dataArrayM[indexPath.row];
    [self.view.window addSubview:self.toolTipView];
    [self.toolTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view.window);
    }];
}
#pragma mark - 点击事件
- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self.dataArrayM removeAllObjects];
    [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
}



- (void)clickTimeButton{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *other_oneAction = [UIAlertAction actionWithTitle:@"今天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 1;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    UIAlertAction *other_twoAction = [UIAlertAction actionWithTitle:@"最近三天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 2;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    UIAlertAction *other_threeAction = [UIAlertAction actionWithTitle:@"最近一周" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 3;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    UIAlertAction *other_fourAction = [UIAlertAction actionWithTitle:@"最近一月" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _pageNumber = 1;
        _data_type = 4;
        [self.dataArrayM removeAllObjects];
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:other_oneAction];
    [alertController addAction:other_twoAction];
    [alertController addAction:other_threeAction];
    [alertController addAction:other_fourAction];

    [self presentViewController:alertController animated:YES completion:nil];}

#pragma mark - 网络请求
- (void)sendNetWorkingWithPageNumber:(NSInteger)pageNumber andData_type:(NSInteger)type {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/coin-info"];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@(_pageNumber) forKey:@"page_no"];
    [parameter setObject:@(10) forKey:@"page_size"];
    [parameter setObject:@(type) forKey:@"data_type"];
    if (type_value.length != 0 &&detail_value.length != 0) {
       [parameter setObject:type_value forKey:@"type_value"];
        [parameter setObject:detail_value forKey:@"detail_value"];
    }
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
        NSArray * dataArray = (NSArray *)data;
        
        if (pageNumber == 1) {
            [self.dataArrayM removeAllObjects];
        }
        if (dataArray.count == 0 && self.dataArrayM.count == 0) {
            [self setIsShowEmptyView:YES];
        } else {
            [self setIsShowEmptyView:NO];

            self.isShowEmptyView = NO;
            for (NSDictionary * dict in data) {
                KKAccountDetailModel * model = [[KKAccountDetailModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArrayM addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self setIsShow404View:YES];
    }];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"账户明细";
    _pageNumber = 1;
    _data_type = 4;
    
    [self addRightItem];
//    [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(21, 18) target:self selected:@selector(rightItemClicked) image:@"Mine_accountDetail_more" isLeft:NO];
}

-(void)addRightItem{
    UIView *noticeButtonItemView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    UIButton * timeButton = [[UIButton alloc]init];
    timeButton.frame = CGRectMake(0,0, 30, 44);
    [timeButton setImage:[UIImage imageNamed:@"KKAccountDetailViewController_time"] forState:UIControlStateNormal];
    [timeButton addTarget:self action:@selector(clickTimeButton) forControlEvents:UIControlEventTouchUpInside];
    [noticeButtonItemView addSubview:timeButton];
    
    UIButton * typeButton = [[UIButton alloc]init];
    typeButton.frame = CGRectMake(40, 0, 30, 44);
    [typeButton setImage:[UIImage imageNamed:@"KKAccountDetailViewController_type"] forState:UIControlStateNormal];
    [typeButton addTarget:self action:@selector(clickTypeButton) forControlEvents:UIControlEventTouchUpInside];
    [noticeButtonItemView addSubview:typeButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:noticeButtonItemView];
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - setter & getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.backgroundColor = MCMineTableViewBgColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNumber = 1;
            [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNumber ++;
            [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
        }];
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}

- (KKAccountDetailToolTipView *)toolTipView {
    if (_toolTipView == nil) {
        self.toolTipView = [[KKAccountDetailToolTipView alloc] init];
        self.toolTipView.backgroundColor = [UIColor clearColor];
    } return _toolTipView;
}


-(void)clickTypeButton{
    KKAccountTypeViewController *vc = [[KKAccountTypeViewController alloc] init];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.determineButtonClick = ^(NSString *type, NSString *sub_type) {
        type_value = type;
        detail_value = sub_type;
        _pageNumber = 1;
        [self sendNetWorkingWithPageNumber:_pageNumber andData_type:_data_type];
    };
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark  UIViewControllerTransitioningDelegate , UIViewControllerAnimatedTransitioning

//拿到负责自定义动画的控制器
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[DDShareModelPopCoverController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}
//谁负责弹出动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.onAnimate = NO;
    return self;
}
//谁负责消失动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.onAnimate = YES;
    return self;
}

//返回一个弹出和消失的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.01;
}

//实现代理方法.做自定义转场动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.onAnimate) {
        [self animateTransitionPresentedController:transitionContext];
    }else{
        [self animateTransitionDismissedController:transitionContext];
    }
    
}

//弹出时调用
-(void)animateTransitionPresentedController:(id <UIViewControllerContextTransitioning>)transitionContext{
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [[transitionContext containerView] addSubview:toView];
    toView.transform = CGAffineTransformMakeScale(1.0, 0);
    toView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
//消失时调用
-(void)animateTransitionDismissedController:(id <UIViewControllerContextTransitioning>)transitionContext{
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:duration animations:^{
        fromView.transform = CGAffineTransformMakeScale(1.0, 0.00001);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
