//
//  KKExcelTableView.m
//  tableTestDemo
//
//  Created by hello on 2018/5/3.
//  Copyright © 2018年 XP. All rights reserved.
//

#import "KKExcelTableView.h"

@interface KKExcelTableView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIColor *borderColor;
@property(nonatomic,assign)CGFloat borderWidth;
@property(nonatomic,strong)NSArray *cellWidthArray;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIFont  *titleFont;
@property(nonatomic,strong)UIColor *dataColor;
@property(nonatomic,strong)UIFont  *dataFont;
@property(nonatomic,assign)CGFloat cellH;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)CGFloat titleH;

@end

@implementation KKExcelTableView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleHeight:(CGFloat)titleH titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor dataArray:(NSArray *)dataArray dataFont:(UIFont *)dataFont dataColor:(UIColor *)dataColor dataCellWidthArray:(NSArray *)cellWArr dataCellHeight:(CGFloat)cellH borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
        self.borderColor = borderColor;
        self.borderWidth = borderWidth;
        self.dataFont = dataFont;
        self.dataColor = dataColor;
        self.cellH = cellH;
        self.titleH = titleH;
        self.dataArray = dataArray;
        self.cellWidthArray = cellWArr;
        [self setupTitleViewWithTitleArray:titleArray titleHeight:titleH titleFont:titleFont titleColor:titleColor dataCellWidthArray:cellWArr];
        [self setupTableView];
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKExcelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exccelCell" forIndexPath:indexPath];
    cell.borderWidth = self.borderWidth;
    cell.borderColor = self.borderColor;
    cell.dataFont = self.dataFont;
    cell.dataColor = self.dataColor;
    cell.cellWidthArray = self.cellWidthArray;
    cell.cellH = self.cellH;
    cell.cellW = self.frame.size.width;
    cell.dataArr = self.dataArray[indexPath.row];
    return cell;
}

-(void)setupTableView{
    
    UITableView *tableView = [UITableView new];
    [self addSubview:tableView];
    tableView.frame = CGRectMake(0, _titleH, self.frame.size.width, self.dataArray.count * _cellH);
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[KKExcelTableViewCell class] forCellReuseIdentifier:@"exccelCell"];
    _tableView = tableView;
    tableView.rowHeight = self.cellH;
    tableView.userInteractionEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];

}

-(void)setupTitleViewWithTitleArray:(NSArray *)titleArray titleHeight:(CGFloat)titleH titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor dataCellWidthArray:(NSArray *)cellWArr{
    
    UIView *titleView = [UIView new];
    titleView.frame = CGRectMake(0, 0, self.frame.size.width, titleH);
    [self addSubview:titleView];
    for(int i = 0;i < titleArray.count;i++){
        UILabel *titleLabel = [UILabel new];
        CGFloat titleX = [self addupWithCellWidthArray:cellWArr index:i];
        titleLabel.frame = CGRectMake(titleX, 0, [cellWArr[i] integerValue], titleH);
        titleLabel.font = titleFont;
        titleLabel.textColor = titleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleArray[i];
        [titleView addSubview:titleLabel];
        
        if(i < titleArray.count && i > 0){
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(titleX, 0, self.borderWidth, titleH);
            [titleView addSubview:lineView];
            lineView.backgroundColor = self.borderColor;
        }
    }
    UIView *horiView = [UIView new];
    horiView.frame = CGRectMake(0, titleH - 0.5, self.frame.size.width, self.borderWidth);
    [titleView addSubview:horiView];
    horiView.backgroundColor = self.borderColor;
}

-(CGFloat)addupWithCellWidthArray:(NSArray *)cellWArr index:(NSInteger)index{
    CGFloat sum = 0.0;
    for(int i = 0;i < index;i++){
        sum += [cellWArr[i] integerValue];
    }
    return sum;
}


@end

@interface KKExcelTableViewCell()

@property(nonatomic,strong)NSMutableArray <UILabel *>*valueLabelArr;

@end

@implementation KKExcelTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    for(UILabel *titleLabel in self.valueLabelArr){
        [titleLabel removeFromSuperview];
    }
    [self.valueLabelArr removeAllObjects];
    [self addSubViews];
}

-(void)addSubViews{
    
    for(int i = 0;i < self.dataArr.count;i++){
        UILabel *titleLabel = [UILabel new];
        CGFloat titleX = [self addupWithCellWidthArray:self.cellWidthArray index:i];
        titleLabel.frame = CGRectMake(titleX, 0, [self.cellWidthArray[i] integerValue], self.cellH);
        titleLabel.font = self.dataFont;
        titleLabel.textColor = self.dataColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.dataArr[i];
        [self addSubview:titleLabel];
        [self.valueLabelArr addObject:titleLabel];
        if(i < self.dataArr.count && i > 0){
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(titleX, 0, self.borderWidth, self.cellH);
            [self addSubview:lineView];
            lineView.backgroundColor = self.borderColor;
        }
    }
    UIView *horiView = [UIView new];
    horiView.frame = CGRectMake(0, self.cellH, self.cellW, self.borderWidth);
    [self addSubview:horiView];
    horiView.backgroundColor = self.borderColor;
    
}

-(CGFloat)addupWithCellWidthArray:(NSArray *)cellWArr index:(NSInteger)index{
    CGFloat sum = 0.0;
    for(int i = 0;i < index;i++){
        sum += [cellWArr[i] integerValue];
    }
    return sum;
}

-(NSMutableArray <UILabel *> *)valueLabelArr{
    
    if(_valueLabelArr == nil){
        _valueLabelArr = [NSMutableArray array];
    }
    return _valueLabelArr;
}

@end
