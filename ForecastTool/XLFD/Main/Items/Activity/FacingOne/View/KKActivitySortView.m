//
//  KKActivitySortView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKActivitySortView.h"
@interface KKActivitySortView ()

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIButton *createSortButton;
@property (nonatomic, strong) UIButton *hotSortButton;
@end
@implementation KKActivitySortView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = MCUIColorFromRGB(0xE0E0DE);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(5);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(150);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [self addSubview:self.hotSortButton];
    [self.hotSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    
    [self addSubview:self.createSortButton];
    [self.createSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.hotSortButton.mas_left).with.offset(-18);
        make.width.mas_equalTo(74);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
}



-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.text = @"所有活动";
        _titleLabel.textColor = MCUIColorFromRGB(0x3C4046);
    }
    
    return _titleLabel;
}
-(UIView *)leftView {
    
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = MCUIColorMain;
    }
    return _leftView;
}

-(UIButton *)hotSortButton {
    
    if (_hotSortButton == nil) {
        _hotSortButton = [[UIButton alloc] init];
        
        [_hotSortButton setTitle:@"热度排序" forState:UIControlStateNormal];
        [_hotSortButton setTitleColor:MCUIColorFromRGB(0x3C4046) forState:UIControlStateNormal];
        [_hotSortButton setTitleColor:MCUIColorFromRGB(0x938008) forState:UIControlStateSelected];
        _hotSortButton.tag = 1;
        _hotSortButton.titleLabel.font = MCFont(12);
         [_hotSortButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _hotSortButton;
}

-(UIButton *)createSortButton {
    
    if (_createSortButton == nil) {
        _createSortButton = [[UIButton alloc] init];
        
        [_createSortButton setTitle:@"创建时间排序" forState:UIControlStateNormal];
        [_createSortButton setTitleColor:MCUIColorFromRGB(0x3C4046) forState:UIControlStateNormal];
        [_createSortButton setTitleColor:MCUIColorFromRGB(0x938008) forState:UIControlStateSelected];
        _createSortButton.tag = 0;
        _createSortButton.titleLabel.font = MCFont(12);
        [_createSortButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _createSortButton;
}
-(void)selectIndex:(NSInteger)index {
    if (index == 0) {
        self.createSortButton.selected = NO;
        [self btnClick:self.createSortButton];
    }else{
        self.hotSortButton.selected = NO;
        [self btnClick:self.hotSortButton];
    }
}
-(void)btnClick:(UIButton *) button {
    
    if (button.selected == NO) {
        _createSortButton.selected = NO;
        _hotSortButton.selected = NO;
        button.selected = YES;
        if ([self.delegate respondsToSelector:@selector(didSelectSortAtIndex:atIndex:)] && self.delegate) {
            [self.delegate didSelectSortAtIndex:self atIndex:button.tag];
        }
    }
    

}

@end
