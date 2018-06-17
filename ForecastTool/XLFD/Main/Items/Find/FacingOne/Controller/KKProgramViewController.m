//
//  KKProgramViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramViewController.h"
#import "KKMyInvolvedFollowViewController.h"
#import "KKMySettingFollowViewController.h"
#import "KKProgramDetailViewController.h"
#import "KKProgramFollowUserViewController.h"
#import "KKInfoSegmentView.h"
@interface KKProgramViewController ()<KKInfoSegmentViewDelegate>
@property (nonatomic, strong)  NSMutableArray *titleList;
@property (nonatomic, strong)  KKProgramDetailViewController *programDetailVC;
@property (nonatomic, strong)  KKProgramFollowUserViewController *followUserVC;
@property (nonatomic, strong)  UIScrollView *scrollView;
@end

@implementation KKProgramViewController


-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
   // self.magicView.frame = CGRectMake(self.magicView.frame.origin.x ,self.magicView.frame.origin.y, MCScreenWidth - 30, 24);
    
   
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)loadView {
    [super loadView];

   // [self.view addSubview:addmagic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    KKInfoSegmentView *segmentView = [[KKInfoSegmentView alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 30, 20)];
    [self.view addSubview:segmentView];
    segmentView.delegate = self;
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(segmentView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    

    UIView *containerView = self.programDetailVC.view;
    //3.添加到当前视图
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.scrollView.mas_width);
    }];


    UIView *container2View = self.followUserVC.view;
    //3.添加到当前视图
    [self.scrollView addSubview:container2View];
    [container2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(containerView.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(self.scrollView.mas_width);
    }];

    
    
}




-(void)didSelectFollowAtIndex:(KKInfoSegmentView *)view atIndex:(NSInteger)index {
    
    CGFloat offSetX = index * self.scrollView.frame.size.width;
    
    [UIView beginAnimations:nil context:nil];
    
    self.scrollView.contentOffset= CGPointMake(offSetX, 0);
    
    [UIView commitAnimations];
}




-(void)buildData:(NSMutableArray *)gdDetailModelArray gdUserModelArray:(NSMutableArray*)gdUserModelArray findModel:(KKFindModel *)findModel;{
    self.followUserVC.gdUserModelArray = gdUserModelArray;
    self.followUserVC.page = 1;
    self.followUserVC.findModel = findModel;
    [self.followUserVC.tableView reloadData];
    self.scrollView.contentSize = CGSizeMake(0,gdDetailModelArray.count *23.5);
    self.programDetailVC.gdDetailModelArray = gdDetailModelArray;
    [self.programDetailVC.tableView reloadData];
}



-(KKProgramDetailViewController *)programDetailVC {
    if (_programDetailVC == nil) {
        _programDetailVC = [[KKProgramDetailViewController alloc] init];
    }
    
    return _programDetailVC;
    
}

-(KKProgramFollowUserViewController *)followUserVC {
    if (_followUserVC == nil) {
        _followUserVC = [[KKProgramFollowUserViewController alloc] init];
    }
    
    return _followUserVC;
   
}



@end
