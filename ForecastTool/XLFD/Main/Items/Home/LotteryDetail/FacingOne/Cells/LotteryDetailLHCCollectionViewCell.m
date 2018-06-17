//
//  LotteryDetail4CollectionViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryDetailLHCCollectionViewCell.h"

#import "CellButton.h"
@interface LotteryDetailLHCCollectionViewCell ()



@property(nonatomic,strong)  UIButton *button;


@end
@implementation LotteryDetailLHCCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(5, 5, 25, 5));
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(0);
        make.top.mas_equalTo(self.button.mas_bottom).with.offset(5);
        make.right.mas_equalTo(self).with.offset(0);
        make.height.mas_equalTo(15);
    }];
}

- (void)buttonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.model.isSelect = sender.selected;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(selectNumber)])
    {
        [self.delegate selectNumber];
    }
}

#pragma mark - setter & getter

- (void)setModel:(LHCLotteryModel *)model
{
    _model = model;
  
    if(self.isLongCell){
        [_button setBackgroundImage:[UIImage imageNamed:@"LotteryLongCell_nor"] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"LotteryLongCell_sel"] forState:UIControlStateSelected];
    }else{
        [_button setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-round-normal"] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-round-select"] forState:UIControlStateSelected];
    }
        
    [self.button setTitle:model.pl_name forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f",[model.award_money floatValue]];
    if ([model.award_money floatValue] == 0 ||[model.wf_flag isEqualToString:@"xglhc_lm_3z2"]||[model.wf_flag isEqualToString:@"xglhc_lm_2zt"]) {
        self.timeLabel.hidden = YES;
    }else{
        self.timeLabel.hidden = NO;
    }
    self.button.enabled = self.model.isAlreadyGetData;
    self.button.selected = self.model.isSelect;
}
-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc]init];
        if (MCScreenWidth <375) {
            _button.titleLabel.font = MCFont(14);
        }
        
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = MCFont(13);
        if (MCScreenWidth <375) {
            _timeLabel.font = MCFont(11);
        }
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = MCUIColorFromRGB(0x084023);
    }
    return _timeLabel;
}
@end
