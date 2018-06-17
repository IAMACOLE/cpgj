//
//  KKLotteryDetailHeaderView.m
//  lotteryViewDemo
//
//  Created by hello on 2018/3/15.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "KKLotteryDetailHeaderView.h"
#import "HistoryOfTheLotteryTableViewCell.h"

@interface KKLotteryDetailHeaderView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *periodLabel;
@property(nonatomic,strong)UILabel *countLabel;

@end

@implementation KKLotteryDetailHeaderView

-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    [_tableView reloadData];
}

-(void)drawRect:(CGRect)rect{
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, MCScreenWidth, 25);
    
    UITableView *tableView = [UITableView new];
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(275);
    }];
    tableView.backgroundColor = MCUIColorFromRGB(0xE9DDD7);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    [tableView registerClass:[HistoryOfTheLotteryTableViewCell class] forCellReuseIdentifier:@"historyCell"];
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = headerView;
    
    
    [headerView addSubview:self.periodLabel];
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    
    [headerView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_periodLabel.mas_right).with.offset(20);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = MCUIColorLighttingBrown;
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.height.mas_equalTo(2);
        make.left.right.mas_equalTo(0);
    }];
    
    UILabel *tipLabel = [UILabel new];
    [self addSubview:tipLabel];
    tipLabel.text = @"点击以上开奖区域可查看更多";
    tipLabel.backgroundColor = MCUIColorFromRGB(0xE9DDD7);
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.font = MCFont(13);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(tableView.mas_bottom);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryOfTheLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel *)periodLabel{
    if (!_periodLabel) {
        self.periodLabel = [[UILabel alloc]init];
        self.periodLabel.textColor = [UIColor lightGrayColor];
        self.periodLabel.font = MCFont(14);
        self.periodLabel.textAlignment = NSTextAlignmentCenter;
        self.periodLabel.text = @"期次";
    }
    return _periodLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.textColor =  [UIColor lightGrayColor];
        self.countLabel.font = MCFont(14);
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.text = @"开奖号码";
    }
    return _countLabel;
}

@end
