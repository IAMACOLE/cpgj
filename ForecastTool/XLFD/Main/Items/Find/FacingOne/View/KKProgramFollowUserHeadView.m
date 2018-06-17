//
//  KKProgramFollowUserHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramFollowUserHeadView.h"
@interface KKProgramFollowUserHeadView ()
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation KKProgramFollowUserHeadView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    [self addSubview:self.userLabel];
    [self addSubview:self.numberLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.timeLabel];
    
    
    NSMutableArray *masonryViewArray = [NSMutableArray array];
    [masonryViewArray addObject:self.userLabel];
    [masonryViewArray addObject:self.numberLabel];
    [masonryViewArray addObject:self.moneyLabel];
    [masonryViewArray addObject:self.timeLabel];
    
    
    //  @param axisType     横排还是竖排
    //  @param fixedSpacing 两个控件间隔
    //  @param leadSpacing  第一个控件与边缘的间隔
    //  @param tailSpacing  最后一个控件与边缘的间隔
    // 实现masonry水平固定间隔方法
    [masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(24);
    }];
    
    
    UIView *userLineView =  [[UIView alloc] init];
    userLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self.userLabel addSubview:userLineView];
    [userLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    UIView *numberLineView =  [[UIView alloc] init];
    numberLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self.numberLabel addSubview:numberLineView];
    [numberLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView *moneyLineView =  [[UIView alloc] init];
    moneyLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self.moneyLabel addSubview:moneyLineView];
    [moneyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView *leftView = [[UIView alloc] init];
    [self addSubview:leftView];
    leftView.backgroundColor = MCUIColorFromRGB(0x979797);
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] init];
    [self addSubview:rightView];
    rightView.backgroundColor = MCUIColorFromRGB(0x979797);
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self addSubview:rightView];
    
    
    
    
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    topView.backgroundColor = MCUIColorFromRGB(0x979797);
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [self addSubview:topView];
    
    UIView *boomView = [[UIView alloc] init];
    [self addSubview:boomView];
    boomView.backgroundColor = MCUIColorFromRGB(0x979797);
    [boomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    [self addSubview:boomView];
    
    
    
}



-(UILabel *)userLabel {
    if (_userLabel == nil) {
        _userLabel = [[UILabel alloc]init];
        _userLabel.text = @"用户";
        
        _userLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _userLabel.font = MCFont(12);
        _userLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userLabel;
}

-(UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.text = @"跟单期数";
        
        _numberLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _numberLabel.font = MCFont(12);
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}


-(UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.text = @"金额";
        
        _moneyLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _moneyLabel.font = MCFont(12);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

-(UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"跟单时间";
        
        _timeLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _timeLabel.font = MCFont(12);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

@end
