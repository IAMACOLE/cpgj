//
//  KKBetRecordToolTipView.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKBetRecordToolTipView.h"


@interface KKBetRecordToolTipView ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;

@property (nonatomic, strong) NSMutableArray * buttonArrayM;

@end

@implementation KKBetRecordToolTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)setIndex:(NSInteger)index {

    UIButton * button = [self viewWithTag:index + 1000];
    button.layer.borderColor = MCUIColorMain.CGColor;

    button.selected = YES;
}

- (void)buttonClicked:(UIButton *)sender {

    [self removeFromSuperview];
    
    NSInteger tag = sender.tag;
    
    for (UIButton * button in self.buttonArrayM) {
        if (tag != button.tag) {
            button.selected = NO;
            [button setTitleColor:MCUIColorMain forState:UIControlStateSelected];
            button.layer.borderColor = MCUIColorFromRGB(0x969696).CGColor;
        } else {
            button.selected = YES;
            button.layer.borderColor = MCUIColorMain.CGColor;
        }
    }
    
    NSString * statusStr;
    
    if (tag-1000 == 0) {
        statusStr = @"";
    } else {
        statusStr = [NSString stringWithFormat:@"%ld",tag-1000 - 1];
    }
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(KKBetRecordToolTipViewMethod_selectedItem:andIndex:)]) {
        [self.customDelegate KKBetRecordToolTipViewMethod_selectedItem:statusStr andIndex:tag-1000];
    }
}

- (void)closeClicked {
    [self removeFromSuperview];
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(KKBetRecordToolTipViewMethod_closeView)]) {
        [self.customDelegate KKBetRecordToolTipViewMethod_closeView];
    }
}

- (void)whiteViewClicked {

}


- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth, 140));
    }];
    
    NSArray * array = @[@"全部订单",@"未开奖",@"未中奖",@"撤销",@"中奖",@"异常",@"追号"];
    
    CGFloat button_W = (MCScreenWidth - 20 - 80) / 3;
    CGFloat button_H = 30;
    CGFloat margin = 40;
    for (int i = 0; i < array.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor = MCUIColorFromRGB(0x969696).CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 15;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = MCFont(14);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:MCUIColorMain forState:UIControlStateSelected];
        [button setTitleColor:MCUIColorMiddleGray forState:UIControlStateNormal];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger line = i / 3;
        NSInteger row = i % 3;
        
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(button_W, button_H));
            make.top.mas_equalTo(self.whiteView).with.offset(20 + (button_H + 10) * line);
            make.left.mas_equalTo(self.whiteView).with.offset(10 + (button_W + margin) * row);
        }];
        [self.buttonArrayM addObject:button];
    }
}


#pragma mark - setter & getter
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeClicked)];
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

- (NSMutableArray *)buttonArrayM {
    if (_buttonArrayM == nil) {
        self.buttonArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _buttonArrayM;
}

@end
