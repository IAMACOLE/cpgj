//
//  RodiaView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/6/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "RodiaView.h"
@interface RodiaView ()
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UIButton * confirmButton;

@property(nonatomic, strong)UIButton *  cancelButton;



@end
@implementation RodiaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

- (void)confirmButtonClicked {
    
    [self removeFromSuperview];
}
- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(305, 365));
    }];
    
    [self.whiteView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.whiteView).with.offset(0);
        make.bottom.mas_equalTo(self.whiteView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(285, 44));
    }];
    
    
    [self.whiteView addSubview:self.playLabel];
    [self.playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.whiteView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 25));
    }];
    
    //
    [self.whiteView addSubview:self.type_topLabel];
    [self.type_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.playLabel.mas_bottom).with.offset(25);
        make.right.mas_equalTo(self.whiteView.mas_right).with.offset(-10);
       
    }];
    
    
    
    [self.whiteView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.whiteView.mas_right).with.offset(-12);
        make.top.mas_equalTo(self.whiteView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

#pragma mark - setter & getter
- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        self.whiteView = [[UIView alloc] init];
        self.whiteView.backgroundColor = MCUIColorWhite;
        self.whiteView.layer.masksToBounds = YES;
        self.whiteView.layer.cornerRadius = 7;
    } return _whiteView;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.confirmButton.backgroundColor = MCUIColorMain;
        self.confirmButton.layer.masksToBounds = YES;
        self.confirmButton.layer.cornerRadius = 6;
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]init];
        [self.cancelButton setImage:[UIImage imageNamed:@"Reuse_delete"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(removeSuperView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelButton;
}

-(UILabel *)playLabel{
    if (!_playLabel) {
        _playLabel = [[UILabel alloc]init];
        _playLabel.font = MCFont(20);
        _playLabel.textColor = MCUIColorMain;
        _playLabel.text = @"公告详情";
    }
    return _playLabel;
}

-(UILabel *)type_topLabel{
    if (!_type_topLabel) {
        _type_topLabel = [[UILabel alloc]init];
        _type_topLabel.numberOfLines = 0;
        _type_topLabel.font = MCFont(14);
        _type_topLabel.textColor = MCUIColorGray;
    }
    return _type_topLabel;
}
-(void)removeSuperView{
    [UIView animateWithDuration:1.0 animations:^{
        [self removeFromSuperview];
    }];
    
}
-(void)sureClick{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.bgView){
        [self removeSuperView];
    }
}

@end
