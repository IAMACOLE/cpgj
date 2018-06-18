//
//  XXSamePeriodViewController.m
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXSamePeriodViewController.h"
#import "XXSamePeriodHeadView.h"
#import "XXSamePeriodTableViewCell.h"
#import "XXSelectionPeriodView.h"

@interface XXSamePeriodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)XXSamePeriodHeadView *samePeriodHeadView;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation XXSamePeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];//设置UI
    // Do any additional setup after loading the view.
}

-(void)initView{
    [self customBackBtn];
    self.title = @"历史同期";
    [self samePeriodHeadView];
    [self tableView];
}

-(XXSamePeriodHeadView *)samePeriodHeadView{
    if (_samePeriodHeadView == nil) {
        XXSamePeriodHeadView *samePeriodHeadView = [[XXSamePeriodHeadView alloc]init];
        [self.view addSubview:samePeriodHeadView];
        [samePeriodHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.equalTo(@170);
        }];
        samePeriodHeadView.clickSelectBtn = ^{
            XXSelectionPeriodView *spv = [[XXSelectionPeriodView alloc]init];
            spv.selectionPeriodID = @"2";
            spv.retutnselectionPeriodID = ^(NSString *selectionPeriodID) {
                
            };
            [self.view.window addSubview:spv];
            [spv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.view);
                make.height.equalTo(@(MCScreenHeight));
            }];
        };
        _samePeriodHeadView = samePeriodHeadView;
    }
    return _samePeriodHeadView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.samePeriodHeadView.mas_bottom);
        }];
        
        _tableView = tableView;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXSamePeriodTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[XXSamePeriodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.userInteractionEnabled = NO;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerInSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerInSectionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    UILabel *headerInSectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-30, headerInSectionView.frame.size.height)];
    headerInSectionLabel.font = [UIFont systemFontOfSize:16];
    headerInSectionLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    headerInSectionLabel.text = @"同期开奖";
    [headerInSectionView addSubview:headerInSectionLabel];
    return headerInSectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
