//
//  LHCCollectionReusableView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/24.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LHCCollectionReusableView.h"

@implementation LHCCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
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
    
    self.backgroundColor = MCMineTableCellBgColor;
    
    
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(2);
    }];
    lineView.backgroundColor = MCUIColorLighttingBrown;
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        make.bottom.mas_equalTo(self).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-15);
        make.bottom.mas_equalTo(self).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView1 = [UIView new];
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    lineView1.backgroundColor = MCUIColorLighttingBrown;
    
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = MCFont(15);
        _timeLabel.text = @"赔率";
        _timeLabel.textColor = MCUIColorMain;
        
    }
    return _timeLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = MCFont(17);
        _titleLabel.text = @"合肖";
        _titleLabel.textColor = MCUIColorMain;
        
    }
    return _titleLabel;
}
@end
