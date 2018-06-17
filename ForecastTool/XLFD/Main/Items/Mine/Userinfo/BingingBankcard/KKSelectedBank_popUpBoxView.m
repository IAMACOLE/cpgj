//
//  KKSelectedBank_popUpBoxView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKSelectedBank_popUpBoxView.h"

@interface KKSelectedBank_popUpBoxView ()
<
UIPickerViewDelegate,UIPickerViewDataSource
>

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation KKSelectedBank_popUpBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)setPickerViewDataWith:(NSArray *)array {
    self.dataArray = array;
}


- (void)addSubviews {
    
    [self.pickerView selectRow:1 inComponent:0 animated:YES];

    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView).with.offset(0);
        make.right.mas_equalTo(self.bgView).with.offset(0);
        make.bottom.mas_equalTo(self.bgView).with.offset(0);
        make.height.mas_equalTo(266);
    }];
    
    [self.whiteView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(0);
        make.right.mas_equalTo(self.whiteView).with.offset(0);
        make.bottom.mas_equalTo(self.whiteView).with.offset(0);
        make.height.mas_equalTo(216);
    }];
    
    [self.whiteView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.whiteView).with.offset(-15);
        make.top.mas_equalTo(self.whiteView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

#pragma mark - 点击事件
- (void)bgViewClicked {
    [self removeFromSuperview];
}
- (void)whiteViewClicked {

}

#pragma mark - Delegate & DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return MCScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
        
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(KKSelectedPickerViewRowShowIndex:)]) {
        [self.customDelegate KKSelectedPickerViewRowShowIndex:row];
    }
}



#pragma mark - setter & getter
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClicked)];
        [self.bgView addGestureRecognizer:tap];
    } return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        self.whiteView = [[UIView alloc] init];
        self.whiteView.backgroundColor = MCUIColorWhite;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whiteViewClicked)];
        [self.whiteView addGestureRecognizer:tap];
    } return _whiteView;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.layer.masksToBounds = YES;
        self.confirmButton.layer.cornerRadius = 5;
        self.confirmButton.backgroundColor = MCUIColorMain;
        self.confirmButton.titleLabel.font = MCFont(14);
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
    } return _confirmButton;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;

    } return _pickerView;
}



@end
