//
//  RechargeFooterView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/5.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKRechargeFooterView.h"
@interface KKRechargeFooterView()
@property(nonatomic,strong)UILabel *warningLabel;
@property(nonatomic,strong) UILabel *warningDetailLabel;
@property(nonatomic,strong) UIButton *rechargeButton;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation KKRechargeFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    } return self;
}

- (void)drawRect:(CGRect)rect {
   
  
}

-(void)addSubViews{
    [self addSubview:self.rechargeButton];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        make.right.mas_equalTo(self).with.offset(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(44);
        
    }];
    
}

-(UIButton *)rechargeButton{
    if (!_rechargeButton) {
        self.rechargeButton = [[UIButton alloc]init];
        self.rechargeButton.backgroundColor = MCUIColorMain;
        [self.rechargeButton setTitle:@"立即充值" forState:UIControlStateNormal];
        [self.rechargeButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
        [self.rechargeButton addTarget:self action:@selector(immediatelyREcjarge) forControlEvents:UIControlEventTouchUpInside];
        self.rechargeButton.layer.cornerRadius = 5;
        self.rechargeButton.clipsToBounds = YES;
    }
    return _rechargeButton;
}
-(void)immediatelyREcjarge{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(RechargeFooterViewImmediatlyClick)]) {
        [self.delegate RechargeFooterViewImmediatlyClick];
    }
}
-(UIView *)lineView{
    if (!_lineView) {
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.25];
        
    }
    return _lineView;
}
-(UILabel *)warningLabel{
    if (!_warningLabel) {
        self.warningLabel = [[UILabel alloc]init];
        self.warningLabel.text = @"温馨提示:";
        self.warningLabel.textColor = MCUIColorMain;
        self.warningLabel.font = [UIFont systemFontOfSize:12];
    }
    return _warningLabel;
}
-(UILabel *)warningDetailLabel{
    if (!_warningDetailLabel) {
        self.warningDetailLabel = [[UILabel alloc]init];
        self.warningDetailLabel.text = @"充值金额不可提现只能购彩，中奖后可以提现";
        self.warningDetailLabel.font = MCFont(12);
        self.warningDetailLabel.textColor = MCUIColorMiddleGray;
    }
    return _warningDetailLabel;
}

@end
