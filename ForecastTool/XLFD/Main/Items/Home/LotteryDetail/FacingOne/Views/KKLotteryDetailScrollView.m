//
//  KKLotteryDetailScrollView.m
//  lotteryViewDemo
//
//  Created by hello on 2018/3/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "KKLotteryDetailScrollView.h"


@interface KKLotteryDetailScrollView()<UIScrollViewDelegate>

//@property(nonatomic,assign)CGFloat endStopOffsetY;
@property(nonatomic,assign)CGFloat firstStopOffsetY;
@property(nonatomic,assign)CGFloat startOffsetY;
@property(nonatomic,assign)BOOL isUp;
@property(nonatomic,assign)CGFloat headerHeight;
@property(nonatomic,strong)KKLotteryDetailHeaderView  *headerView;

@end

@implementation KKLotteryDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame HeaderView:(KKLotteryDetailHeaderView *)headerView  headerHeight:(CGFloat)headerHeight viewController:(UIViewController *)viewController subView:(UIScrollView *)subView{
    
    if(self = [super initWithFrame:frame]){
        [self setupUIWithFrame:frame HeaderView:headerView headerHeight:headerHeight viewController:viewController subView:subView];
        self.headerHeight = headerHeight;
        self.headerView = headerView;
    }
    return self;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    _headerView.dataSource = dataSource;
}

- (void)setupUIWithFrame:(CGRect)frame HeaderView:(UIView *)headerView  headerHeight:(CGFloat)headerHeight viewController:(UIViewController *)viewController subView:(UIScrollView *)subView{
    
    self.backgroundColor = MCUIColorFromRGB(0xE9DDD7);
    
    //设置headerView
    [self addSubview:headerView];
    headerView.frame = CGRectMake(0, 0, frame.size.width, headerHeight);
    
    //初始化两个特定的位置
//    self.endStopOffsetY = headerHeight;
    self.firstStopOffsetY = headerHeight / 2;
//    self.startOffsetY = headerHeight;
    
    //设置scrollView
    UIScrollView *scrollView = [UIScrollView new];
    [self addSubview:scrollView];
    scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    scrollView.delegate = self;
    scrollView.tag = 1000;
    scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height + headerHeight);
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView setContentOffset:CGPointMake(0, headerHeight)];
    _scrollView = scrollView;
    
    //设置点击事件
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, frame.size.width,headerHeight);
    [scrollView addSubview:btn];
//    [btn setTitle:@"dianyidian" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    subView.scrollEnabled = NO;
    subView.bounces = NO;
    
    [scrollView addSubview:subView];
    
}

-(void)scrollToChangeStatus{
    CGFloat offsetY = self.scrollView. contentOffset.y;
    if(offsetY != 0){
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, 300) animated:YES];
    }
}

-(void)didClickBtn{
    if(self.didClickShowMoreDataBtnBlock){
        self.didClickShowMoreDataBtnBlock();
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(scrollView.tag == 1000){
        self.startOffsetY = scrollView.contentOffset.y;
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(scrollView.tag == 1000){
        CGFloat targetContentOffsetY = targetContentOffset -> y;
        NSLog(@"%lf , %lf",self.startOffsetY, targetContentOffsetY);
        if(self.startOffsetY > (scrollView.contentSize.height - scrollView.frame.size.height)){
            targetContentOffset -> y = scrollView.contentSize.height - scrollView.frame.size.height;
            return;
        }
        if(self.startOffsetY > targetContentOffsetY){
            if(self.startOffsetY > 150 ){
                targetContentOffset -> y = self.firstStopOffsetY;
            }else if(self.startOffsetY <= self.firstStopOffsetY){
                targetContentOffset -> y = 0;
            }
        }else{
            if(self.startOffsetY >= 150 && self.startOffsetY < 300){
                targetContentOffset -> y = _headerHeight;
            }else if(self.startOffsetY < 150){
                targetContentOffset -> y = self.firstStopOffsetY;
            }
        }
    }

}

-(void)updateFrameWithDataCount:(NSInteger)dataCount andRowHeight:(CGFloat)rowHeight{
    
    if(rowHeight){
        UITableView *tableView = nil;
        for(UIView *view in _scrollView.subviews){
            if([view isKindOfClass:[UITableView class]]){
                tableView = (UITableView *)view;
            }
        }
        //根据数据返回的个数更新tableView的高度 当高度小于scrollView的高度时 做适应处理
        CGFloat tableViewHeight = 0;
        if(dataCount *rowHeight + 40 >= _scrollView.frame.size.height){
            tableViewHeight = dataCount *rowHeight + 40;
        }else{
            tableViewHeight = _scrollView.frame.size.height;
        }
        [_scrollView setContentOffset:CGPointMake(0, 300)];
        _scrollView.contentSize = CGSizeMake(self.frame.size.width, tableViewHeight + self.headerHeight);
        tableView.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, tableViewHeight);
    }else{
        
        UICollectionView *collectionView = nil;
        for(UIView *view in _scrollView.subviews){
            if([view isKindOfClass:[UICollectionView class]]){
                collectionView = (UICollectionView *)view;
            }
        }
         [_scrollView setContentOffset:CGPointMake(0, 300)];
        if(dataCount == 49 || dataCount == 20){
            _scrollView.contentSize = CGSizeMake(self.frame.size.width, 40 + self.frame.size.height+ self.headerHeight);
        }else{
            _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height+ self.headerHeight);
        }
    }
    
}

@end
