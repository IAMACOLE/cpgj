//
//  XXTrendViewController.m
//  ForecastTool
//
//  Created by hello on 2018/6/7.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXTrendViewController.h"
#import "XXLuckyDataModel.h"
#import "XXTrendTableViewCell.h"

@interface XXTrendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong)NSMutableArray <XXLuckyDataModel *>*dataArr;
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation XXTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBackBtn];
    self.title = @"开奖公告";
    _pageNum = 1;
    
    [self setupUI];
    [self getData];
}

-(void)setupUI{
    
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.scrollView addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, 60 * 13, 30 * 21);
    
}

-(void)getData{
    if (_pageNum == 1) {
        [MCView BSMBProgressHUD_bufferAndTextWithView:self.view andText:nil];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"cp/kj-trend-history"];
    NSDictionary * parameter = @{
                                 @"lottery_id" : @"pk10",
                                 @"page_no"    : [NSString stringWithFormat:@"%zd",_pageNum],
                                 @"page_size"  : @"20",
                                 
                                 };
    [[XXNetWorkTool shareTool] postDataWithUrl:urlStr parameters:parameter success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [MCView BSMBProgressHUD_hideWith:self.view];
        NSArray *dataSource =  [XXLuckyDataModel mj_objectArrayWithKeyValuesArray:responseObject];
        if(self->_pageNum == 1){
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:dataSource];
        }else{
            if(dataSource.count){
                [self.dataArr addObjectsFromArray:dataSource];
                [self.tableView.mj_footer endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.tableView reloadData];
        self.tableView.frame = CGRectMake(0, 0, 60 * 13, 30 * self.dataArr.count);
        if(self.dataArr.count){
            self.scrollView.contentSize = CGSizeMake(60 * 13, 30 * self.dataArr.count);
        }else{
            self.scrollView.contentSize = CGSizeMake(0, 0);
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error.description);
        [MCView BSMBProgressHUD_hideWith:self.view];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXTrendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trendCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XXLuckyDataModel *model = self.dataArr[indexPath.row];
    cell.dataModel = model;
    return cell;
}

-(UITableView *)tableView{
    
    if(_tableView == nil){
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 30;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        WeakObject(self);
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            weakObject.pageNum = 1;
//            [self getData];
//        }];
//
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            weakObject.pageNum ++;
//            [self getData];
//        }];
        [_tableView registerClass:[XXTrendTableViewCell class] forCellReuseIdentifier:@"trendCell"];
    }
    return _tableView;
}

-(NSMutableArray <XXLuckyDataModel *> *)dataArr{
    if(_dataArr == nil){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
