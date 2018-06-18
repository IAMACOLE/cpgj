//
//  XXSelectionPeriodView.m
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXSelectionPeriodView.h"

@interface XXSelectionPeriodView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *switchNumberArray;

@end

@implementation XXSelectionPeriodView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

#pragma mark 界面初始化
-(void)addSubviews{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-250,MCScreenWidth, 250)];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickerView];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-300, MCScreenWidth, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, MCScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0  blue:245/255.0  alpha:1];
    [titleView addSubview:line];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, MCScreenWidth-100, 50)];
    titleLabel.text = @"期数选择";
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
    
    UIButton *Lbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [Lbutton setTitle:@"取消" forState:UIControlStateNormal];
    [Lbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Lbutton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [Lbutton addTarget:self action:@selector(clidkLButton) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:Lbutton];
    
    UIButton *Rbutton = [[UIButton alloc]initWithFrame:CGRectMake(MCScreenWidth - 50, 0, 50, 50)];
    [Rbutton setTitle:@"确定" forState:UIControlStateNormal];
    [Rbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Rbutton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [Rbutton addTarget:self action:@selector(clidkRbutton) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:Rbutton];
}

-(void)clidkLButton{
    [self removeSuperView];
}

-(void)clidkRbutton{
    self.retutnselectionPeriodID(_selectionPeriodID);
    [self removeSuperView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self){
        [self removeSuperView];
    }
}



-(void)removeSuperView{
    [UIView animateWithDuration:1.0 animations:^{
        [self removeFromSuperview];
    }];
}

#pragma mark -PickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return self.switchNumberArray.count;
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.switchNumberArray objectAtIndex:row];
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectionPeriodID = [NSString stringWithFormat:@"%ld",(long)row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return MCScreenWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}



//  第component列第row行显示怎样的view(内容)
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor lightGrayColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
        pickerLabel.text = [self.switchNumberArray objectAtIndex:row];
    }
    return pickerLabel;
}




-(NSMutableArray *)switchNumberArray{
    if (_switchNumberArray == nil) {
        NSMutableArray *switchNumberArray = [NSMutableArray array];
        for (int i = 1; i < 21; i++) {
            [switchNumberArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _switchNumberArray = switchNumberArray;
    }
    return _switchNumberArray;
}

-(void)layoutSubviews{
    [self switchNumberArray];
    [_pickerView selectRow:[_selectionPeriodID integerValue] inComponent:0 animated:YES];
}

@end
