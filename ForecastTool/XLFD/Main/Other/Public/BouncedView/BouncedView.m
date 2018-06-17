//
//  BouncedView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/6.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "BouncedView.h"
@interface BouncedView ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) UILabel * type_topLabel;
@property (nonatomic, strong) UILabel * changeMoney_topLabel;
@property (nonatomic, strong) UILabel * totalMoney_topLabel;
@property (nonatomic, strong) UILabel * remark_topLabel;
@property (nonatomic, strong) UILabel * remark_bottomLabel;
@property (nonatomic, strong) UIButton *  cancelButton;
@property (nonatomic, strong) UILabel *playLabel;

@end

@implementation BouncedView

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
        make.size.mas_equalTo(CGSizeMake(305, 400));
    }];

    
    [self.whiteView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView).with.offset(0);
        make.bottom.mas_equalTo(self.whiteView).with.offset(-10);
    }];
    
    [self.whiteView addSubview:self.playLabel];
    [self.playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(28);
        make.height.mas_equalTo(25);
    }];
    
    [self.whiteView addSubview:self.type_topLabel];
    [self.type_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.playLabel.mas_bottom).with.offset(25);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.type_bottomLabel];
    [self.type_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.type_topLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.whiteView addSubview:self.changeMoney_topLabel];
    [self.changeMoney_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.type_bottomLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.changeMoney_bottomLabel];
    [self.changeMoney_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.changeMoney_topLabel.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self.whiteView).with.offset(-10);
    }];
    
    [self.whiteView addSubview:self.totalMoney_topLabel];
    [self.totalMoney_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.top.mas_equalTo(self.changeMoney_bottomLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(16);
    }];
    
    [self.whiteView addSubview:self.totalMoney_bottomLabel];
    [self.totalMoney_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.whiteView).with.offset(10);
        make.right.mas_equalTo(self.whiteView).with.offset(-10);
        make.top.mas_equalTo(self.totalMoney_topLabel.mas_bottom).with.offset(10);
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.bgView){
        [self removeSuperView];
    }
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
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.image = [UIImage imageNamed:@"follow-alert1-bg"];
        [self.whiteView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
    } return _whiteView;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmButton setImage:[UIImage imageNamed:@"icon-lotterydetail-play-ok"] forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _confirmButton;
}

- (UILabel *)type_topLabel {
    if (_type_topLabel == nil) {
        self.type_topLabel = [[UILabel alloc] init];
        self.type_topLabel.font = MCFont(16);
        self.type_topLabel.textColor = [UIColor blackColor];
        self.type_topLabel.text = @"当前玩法";
    } return _type_topLabel;
}

- (UILabel *)type_bottomLabel {
    if (_type_bottomLabel == nil) {
        self.type_bottomLabel = [[UILabel alloc] init];
        self.type_bottomLabel.font = MCFont(15);
        self.type_bottomLabel.textColor = MCUIColorMain;
        
    } return _type_bottomLabel;
}

- (UILabel *)changeMoney_topLabel {
    if (_changeMoney_topLabel == nil) {
        self.changeMoney_topLabel = [[UILabel alloc] init];
        self.changeMoney_topLabel.font = MCFont(16);
        self.changeMoney_topLabel.textColor = [UIColor blackColor];
        self.changeMoney_topLabel.text = @"选号规则";
    } return _changeMoney_topLabel;
}

- (UILabel *)changeMoney_bottomLabel {
    if (_changeMoney_bottomLabel == nil) {
        self.changeMoney_bottomLabel = [[UILabel alloc] init];
        self.changeMoney_bottomLabel.font = MCFont(15);
        self.changeMoney_bottomLabel.numberOfLines = 0;
        self.changeMoney_bottomLabel.textColor = MCUIColorMain;
        
    } return _changeMoney_bottomLabel;
}

- (UILabel *)totalMoney_topLabel {
    if (_totalMoney_topLabel == nil) {
        self.totalMoney_topLabel = [[UILabel alloc] init];
        self.totalMoney_topLabel.font = MCFont(16);
        self.totalMoney_topLabel.textColor = [UIColor blackColor];
        self.totalMoney_topLabel.text = @"中奖说明";
    } return _totalMoney_topLabel;
}

- (UILabel *)totalMoney_bottomLabel {
    if (_totalMoney_bottomLabel == nil) {
        self.totalMoney_bottomLabel = [[UILabel alloc] init];
        self.totalMoney_bottomLabel.numberOfLines = 0;
        self.totalMoney_bottomLabel.font = MCFont(15);
        self.totalMoney_bottomLabel.textColor = MCUIColorMain;
        
    } return _totalMoney_bottomLabel;
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
        _playLabel.textColor = [UIColor whiteColor];
        _playLabel.text = @"玩法提示";
        _playLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _playLabel;
}

-(void)removeSuperView{
    [UIView animateWithDuration:1.0 animations:^{
       [self removeFromSuperview];
    }];
    
}
-(void)sureClick{
    [self removeFromSuperview];
}
@end
