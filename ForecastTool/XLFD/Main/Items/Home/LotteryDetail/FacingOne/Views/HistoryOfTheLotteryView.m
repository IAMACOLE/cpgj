//
//  HistoryOfTheLotteryView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "HistoryOfTheLotteryView.h"
#import "HistoryOfTheLotteryTableViewCell.h"
@interface HistoryOfTheLotteryView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic, strong)UIView *bottomLine;
@end
@implementation HistoryOfTheLotteryView

- (void)drawRect:(CGRect)rect {
    UIButton *hideBackButton = [[UIButton alloc]initWithFrame:self.frame];
    [hideBackButton addTarget:self action:@selector(hideSelfView) forControlEvents:UIControlEventTouchUpInside];
    hideBackButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:hideBackButton];
    
    
    UIView *backView = [[UIView alloc] init];

    backView.backgroundColor = MCUIColorLightGray;
    [self addSubview:backView];
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(MCScreenHeight/1.5);
    }];
    
    
    UIImageView *historyImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 21, 21)];
    historyImage.image = [UIImage imageNamed:@"Home_history"];
    [self.headView addSubview:historyImage];
    UILabel *historyLabel = [[UILabel alloc]init];
    historyLabel.text = @"历史开奖";
    historyLabel.textColor = [UIColor colorWithRed:240/255.0 green:202/255.0 blue:48/255.0 alpha:1/1.0];
    [self.headView addSubview:historyLabel];
    [historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(historyImage.mas_right).with.offset(15);
        make.top.mas_equalTo(self.headView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(120, 21));
    }];
    historyLabel.font = [UIFont boldSystemFontOfSize:16];

    UIButton *hideButton = [[UIButton alloc]initWithFrame:CGRectMake(MCScreenWidth-50, 10, 30, 30)];
    [hideButton setImage:[UIImage imageNamed:@"Home_HideView"] forState:UIControlStateNormal];
    [hideButton addTarget:self action:@selector(hideSelfView) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:hideButton];

    [backView addSubview:self.headView];
    [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.left.right.top.mas_equalTo(backView);
        make.height.mas_equalTo(50);
    }];
    
    [self.headView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.headView);
        make.height.mas_equalTo(1);
    }];

    [backView addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.left.right.mas_equalTo(backView);
        make.bottom.mas_equalTo(backView).mas_offset(-64);
        make.top.mas_equalTo(self.headView.mas_bottom);
    }];
}
-(void)hideSelfView{
    [UIView animateWithDuration:1.0 animations:^{
       [self removeFromSuperview]; 
    }];
    
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.rowHeight = 36;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(UIView *)headView{
    if (!_headView) {
        self.headView = [[UIView alloc] init];
        self.headView.backgroundColor =  [UIColor colorWithRed:19/255.0 green:67/255.0 blue:42/255.0 alpha:1/1.0];
    }
    return _headView;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:25/255.0 green:71/255.0 blue:47/255.0 alpha:1/1.0];
    }
    return _bottomLine;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDcell = @"cell";
    HistoryOfTheLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[HistoryOfTheLotteryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDcell];
        
    }
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:19/255.0 green:67/255.0 blue:42/255.0 alpha:1/1.0];
    return cell;
}

@end
