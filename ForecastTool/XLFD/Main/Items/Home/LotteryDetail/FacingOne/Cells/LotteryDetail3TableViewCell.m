//
//  LotteryDetail3TableViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryDetail3TableViewCell.h"

@interface LotteryDetail3TableViewCell ()

@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIView *bottonView;

@end
@implementation LotteryDetail3TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}
-(void)addSubViews{
    
    self.backgroundColor = MCMineTableCellBgColor;
    [self addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(5);
        make.top.mas_equalTo(self).with.offset((MCScreenWidth-62-40)/6/2);
        make.size.mas_equalTo(CGSizeMake(45, 18));
    }];
    CGFloat btnWidth = (MCScreenWidth-55)/6-5;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 30+btnWidth*2-1, MCScreenWidth, 1)];
    lineView.backgroundColor = MCUIColorLighttingBrown;
    [self addSubview:lineView];
    
    UIImageView *line2View = [[UIImageView alloc]init];
    line2View.backgroundColor = MCUIColorLighttingBrown;
    [self addSubview:line2View];
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    NSArray *selectArray = @[@"全",@"大",@"小",@"单",@"双",@"清"];
    for (int i=0; i<selectArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*MCScreenWidth/selectArray.count, 30+btnWidth*2, MCScreenWidth/selectArray.count, 30)];
        btn.titleLabel.font = MCFont(14);
        UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width-1, 0, 1, 27)];
        linView.backgroundColor = MCUIColorLighttingBrown;
        [btn addSubview:linView];
        [btn setTitle:selectArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [btn setTitleColor:MCUIColorWhite forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-class-select"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectStatusClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 200+i;
        [self addSubview:btn];
    }
    [self addSubview:self.bottonView];
    self.bottonView.frame = CGRectMake(0, 30+btnWidth*2+30, MCScreenWidth, 5);
}

-(void)setDataModel:(KKLotteryDataModel *)dataModel{
    _dataModel = dataModel;
    _dataArray = dataModel.dataSource;
    CGFloat btnWidth = (MCScreenWidth-55)/3-5;
    CGFloat btnHeight = (MCScreenWidth-55)/6-5;
    for (UIView *view in self.subviews) {
        if (view.tag>=500) {
            UIButton *btn = (UIButton *)view;
            [btn removeFromSuperview];
        }
    }
    
    for (UIView *view in self.subviews){
        if(view.tag < 500 && view.tag >= 200){
            UIButton *btn = (UIButton *)view;
            btn.selected = dataModel.selectedBtnIndex == btn.tag ? YES : NO;
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j =0; j<3; j++) {
            
            if (i*3+j<_dataArray.count) {
                LotteryDetailModel *model = _dataArray[i*3+j];
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((MCScreenWidth-55)/3*j+55, 10+((MCScreenWidth-55)/6+5)*i, btnWidth, btnHeight)];
                
                [btn setTitle:[NSString stringWithFormat:@"%@",model.number] forState:UIControlStateNormal];
                btn.titleLabel.font = MCFont(16);
                btn.tag = 500+i*3+j;
                [btn setTitleColor:MCUIColorMain forState:UIControlStateNormal];
//                [btn setTitleColor:MCUIColorWhite forState:UIControlStateSelected];
//                [btn setBackgroundImage:[UIImage imageNamed:@"LotteryLongCell_nor"] forState:UIControlStateNormal];//[MCTool
//                [btn setBackgroundImage:[UIImage imageNamed:@"LotteryLongCell_sel"] forState:UIControlStateSelected];//[MCTool
                [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                btn.selected = model.isSelect;
            }
        }
    }
    
}

-(void)selectBtn:(UIButton *)sender{
    NSInteger index = sender.tag-500;
    LotteryDetailModel *model = _dataArray[index];
    if (sender.selected) {
        model.isSelect = NO;
        sender.selected = NO;
    }else{
        model.isSelect = YES;
        sender.selected = YES;
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectNumber)]) {
        [self.delegate selectNumber];
    }
}
-(void)selectStatusClick:(UIButton *)sender{
    if(sender.tag == self.selectBtn.tag){
        if (sender.isSelected) {
            return;
        }
    }
    sender.selected = YES;
    NSInteger index = sender.tag-200;
    switch (index) {
        case 0:
            for (UIView *view in self.subviews) {
                if (view.tag>=500) {
                    UIButton *btn = (UIButton *)view;
                    LotteryDetailModel *model = _dataArray[view.tag-500];
                    model.isSelect = YES;
                    btn.selected = YES;
                }
            }
            break;
        case 1:
            for (UIView *view in self.subviews) {
                if (view.tag>=502) {
                    UIButton *btn = (UIButton *)view;
                    LotteryDetailModel *model = _dataArray[view.tag-500];
                    model.isSelect = YES;
                    btn.selected = YES;
                }
                if (view.tag>=500 &&view.tag<502) {
                    UIButton *btn = (UIButton *)view;
                    LotteryDetailModel *model = _dataArray[view.tag-500];
                    model.isSelect = NO;
                    btn.selected = NO;
                }
            }
            break;
        case 2:
            for (UIView *view in self.subviews) {
                if (view.tag>=502) {
                    LotteryDetailModel *model = _dataArray[view.tag-500];
                    model.isSelect = NO;
                    UIButton *btn = (UIButton *)view;
                    btn.selected = NO;
                }
                if (view.tag>=500 &&view.tag<502) {
                    LotteryDetailModel *model = _dataArray[view.tag-500];
                    model.isSelect = YES;
                    UIButton *btn = (UIButton *)view;
                    btn.selected = YES;
                }
            }
            break;
        case 3:
            for (UIView *view in self.subviews) {
                if (view.tag>=500) {
                    if (view.tag%2!=0) {
                        UIButton *btn = (UIButton *)view;
                        LotteryDetailModel *model = _dataArray[view.tag-500];
                        model.isSelect = YES;
                        btn.selected = YES;
                    }
                    else {
                        UIButton *btn = (UIButton *)view;
                        LotteryDetailModel *model = _dataArray[view.tag-500];
                        model.isSelect = NO;
                        btn.selected = NO;
                    }
                }
            }
            break;
        case 4:
            for (UIView *view in self.subviews) {
                if (view.tag>=500) {
                    if (view.tag%2!=0) {
                        LotteryDetailModel *model = _dataArray[view.tag-500];
                        model.isSelect = NO;
                        UIButton *btn = (UIButton *)view;
                        btn.selected = NO;
                    }
                    else {
                        UIButton *btn = (UIButton *)view;
                        LotteryDetailModel *model = _dataArray[view.tag-500];
                        model.isSelect = YES;
                        btn.selected = YES;
                    }
                    
                }
            }
            break;
        case 5:
            for (UIView *view in self.subviews) {
                if (view.tag>=500) {
                    LotteryDetailModel *model = _dataArray[view.tag-500];
                    model.isSelect = NO;
                    UIButton *btn = (UIButton *)view;
                    btn.selected = NO;
                }
            }
            break;
        default:
            break;
    }
    self.selectBtn.selected = NO;
    self.selectBtn.titleLabel.font = MCFont(16);
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.selectBtn = sender;
    _dataModel.selectedBtnIndex = sender.tag;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectNumber)]) {
        [self.delegate selectNumber];
    }
}
-(UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc]init];
        _firstLabel.backgroundColor = MCUIColorMain;
        _firstLabel.font = MCFont(14);
        _firstLabel.layer.cornerRadius = 2;
        _firstLabel.clipsToBounds = YES;
        
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.textColor = [UIColor whiteColor];
    }
    return _firstLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(UIView *)bottonView{
    if (!_bottonView) {
        _bottonView = [[UIView alloc]init];
      
        _bottonView.backgroundColor = MCMineTableCellBgColor;
    }
    return _bottonView;
}
@end
