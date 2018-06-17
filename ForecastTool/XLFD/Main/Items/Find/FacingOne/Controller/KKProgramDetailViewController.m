//
//  KKProgramDetailViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/18.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramDetailViewController.h"
#import "KKProgramDetailTabelViewCell.h"
#import "KKGDDetailModel.h"
@interface KKProgramDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)  KKProgramDetailHaedView *headView;

@end

@implementation KKProgramDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

-(void)initUI {
    

    
    
    
//    [self.view addSubview:self.headView];
//    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(24);
//        make.top.mas_equalTo(0);
//    }];
//
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKProgramDetailTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKProgramDetailTabelViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
       // cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.row = indexPath.row;
    KKGDDetailModel *model = [self.gdDetailModelArray objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gdDetailModelArray.count;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
       // _tableView.tableHeaderView = self.headView;
        _tableView.rowHeight = 22;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(KKProgramDetailHaedView *)headView {
    if(_headView == nil) {
        _headView = [[KKProgramDetailHaedView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.frame = CGRectMake(15, 0, MCScreenWidth-30, 24);
    }
    
    return _headView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
