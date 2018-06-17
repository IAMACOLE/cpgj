//
//  KKBettingResultView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/15.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKBettingResultView.h"

@interface KKBettingResultView ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *whiteBGView;
@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UILabel *playLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation KKBettingResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

-(void)setTitle:(NSString *)title tip:(NSString *)tipStr detail:(NSString *)detailStr confirmStr:(NSString *)confirm failureStr:(NSString *)failure{
        _tipLabel.text = tipStr;
    if(!kStringIsEmpty(detailStr)){
        _detailLabel.hidden = YES;
        _tipLabel.numberOfLines = 1;
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.whiteView.mas_bottom).with.offset(-25);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(94, 40));
        }];
        _cancelButton.hidden = YES;
    }else{
        _detailLabel.hidden = YES;
        _cancelButton.hidden = NO;
    }
    _playLabel.text = title;
    [_confirmButton setTitle:confirm forState:UIControlStateNormal];
    [_cancelButton setTitle:failure forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title tip:(NSString *)tipStr confirmStr:(NSString *)confirm failureStr:(NSString *)failure{
    _playLabel.text = title;
    _tipLabel.text = tipStr;
    [_confirmButton setTitle:confirm forState:UIControlStateNormal];
    [_cancelButton setTitle:failure forState:UIControlStateNormal];
}

- (void)addSubviews {
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickBgView)];
    [self.bgView addGestureRecognizer:tap];
    
    [self.bgView addSubview:self.whiteView];
    [self.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(305, 250));
    }];
    
    [self.whiteView addSubview:self.playLabel];
    [self.playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.whiteView).with.offset(22);
        make.height.mas_equalTo(25);
    }];
    
    [self.whiteView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(110);
    }];
    self.tipLabel.numberOfLines = 2;
    
    [self.whiteView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset(5);
    }];
    self.detailLabel.hidden = YES;
    
    [self.whiteView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.whiteView.mas_bottom).with.offset(-25);
        make.centerX.mas_equalTo(-(94 / 2) - 12);
        make.size.mas_equalTo(CGSizeMake(94, 40));
    }];
    
    [self.whiteView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.whiteView.mas_bottom).with.offset(-25);
        make.centerX.mas_equalTo((94 / 2) + 12);
        make.size.mas_equalTo(CGSizeMake(94, 40));
    }];

}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([touch view] == self.bgView){
//        [self removeSuperView];
//    }
//}

-(void)didClickBgView{
    [self removeSuperView];
    if(self.didClickBgViewBlock){
        self.didClickBgViewBlock();
    }
}

-(void)confirmButtonClick {
    [self removeSuperView];
    self.confirmBlock();
}

-(void)cancelButtonClick {
    [self removeSuperView];
    self.otherBlock();
}

-(void)removeSuperView{
    [UIView animateWithDuration:1.0 animations:^{
        [self removeFromSuperview];
    }];
    
}

- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        self.whiteView = [[UIView alloc] init];
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.image = [UIImage imageNamed:@"follow-resultAlert-bg"];
        [self.whiteView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
    } return _whiteView;
}

-(UILabel *)playLabel{
    if (!_playLabel) {
        _playLabel = [[UILabel alloc]init];
        _playLabel.font = MCFont(18);
        _playLabel.textColor = [UIColor whiteColor];
        _playLabel.text = @"投注成功";
        _playLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _playLabel;
}

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.font = MCFont(16);
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.text = @"好运即将到来!";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = MCFont(16);
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.text = @"您的跟单将在您成功投注后生效";
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitle:@"投注记录" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:MCUIColorFromRGB(0x848484) forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = MCFont(18);
        [self.cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"follow-alert-cancle"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    } return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmButton setTitle:@"继续投注" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:MCUIColorFromRGB(0x9A6424) forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = MCFont(18);
        [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"follow-alert-confirm"] forState:UIControlStateNormal];
        [self.confirmButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 3, 0)];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}

@end
