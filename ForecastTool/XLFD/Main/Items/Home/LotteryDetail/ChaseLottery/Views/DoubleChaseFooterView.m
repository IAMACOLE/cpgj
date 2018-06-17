//
//  DoubleChaseFooterView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "DoubleChaseFooterView.h"
@interface DoubleChaseFooterView()

@property(nonatomic,strong)UIButton *immediatelyChaseButton;
@property(nonatomic,strong)UIButton *cancelButton;

@end
@implementation DoubleChaseFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [self addSubview:self.stopChaseButton];
    [self.stopChaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self).with.offset(12.5);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(120), 20));
    }];
    [self addSubview:self.immediatelyChaseButton];
    [self.immediatelyChaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(75), 25));
    }];
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.immediatelyChaseButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(75), 25));
    }];
    
}
-(void)cancelClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(cancelClick)]) {
        [self.delegate cancelClick];
    }
}
-(void)immediatelyClick{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(immediateClick)]) {
        [self.delegate immediateClick];
    }
}
-(void)stopChaseClick:(UIButton *)sender{
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}
-(UIButton *)stopChaseButton{
    if (!_stopChaseButton) {
        self.stopChaseButton = [[UIButton alloc]init];
        [self.stopChaseButton setImage:[UIImage imageNamed:@"Reuse_notSelectd"] forState:UIControlStateNormal];
        [self.stopChaseButton setImage:[UIImage imageNamed:@"Reuse_selected"] forState:UIControlStateSelected];
        [self.stopChaseButton setTitle:@" 中奖后停止追号" forState:UIControlStateNormal];
        self.stopChaseButton.titleLabel.font = MCFont(kAdapterFontSize(13));
        [self.stopChaseButton setTitleColor:MCUIColorGray forState:UIControlStateNormal];
        self.stopChaseButton.selected = YES;
        [self.stopChaseButton addTarget:self action:@selector(stopChaseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopChaseButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]init];
        self.cancelButton.layer.borderColor = MCUIColorMain.CGColor;
        self.cancelButton.layer.borderWidth = 1;
        self.cancelButton.layer.cornerRadius = 5;
        self.cancelButton.clipsToBounds = YES;
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
        [self.cancelButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
-(UIButton *)immediatelyChaseButton{
    if (!_immediatelyChaseButton) {
        self.immediatelyChaseButton = [[UIButton alloc]init];
        self.immediatelyChaseButton.layer.borderColor = MCUIColorMain.CGColor;
        self.immediatelyChaseButton.layer.borderWidth = 1;
        self.immediatelyChaseButton.layer.cornerRadius = 5;
        self.immediatelyChaseButton.clipsToBounds = YES;
        [self.immediatelyChaseButton setTitle:@"立即投注" forState:UIControlStateNormal];
        self.immediatelyChaseButton.titleLabel.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
        [self.immediatelyChaseButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.immediatelyChaseButton addTarget:self action:@selector(immediatelyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _immediatelyChaseButton;
}

@end
