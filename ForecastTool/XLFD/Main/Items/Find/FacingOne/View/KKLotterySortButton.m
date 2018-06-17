//
//  KKLotterySortButton.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKLotterySortButton.h"

@interface KKLotterySortButton ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *rightView;
@end
@implementation KKLotterySortButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addSubViews];
}

-(void)addSubViews {
    
   
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAdapterWith(55), kAdapterWith(55)));
        make.centerY.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).with.offset(3);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

-(void)buildWithData:(HomeSubButtonModel *)model index:(NSInteger)index{
    NSURL *url = [[NSURL alloc] initWithString:model.lottery_image];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Reuse_placeholder_50*50"]];
    self.titleLabel.text = model.lottery_name;
    
    if ((index+1)%4 == 0) {
        [self.rightView setHidden:YES];
    }else{
        [self.rightView setHidden:NO];
    }
    
}

-(UIView *)rightView {
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = MCUIColorFromRGB(0xF2F2F2);
    }
    return _rightView;
}

-(UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = MCFont(15);
        _titleLabel.textColor = MCUIColorFromRGB(0x3A3634);
    }
    return _titleLabel;
}


@end
