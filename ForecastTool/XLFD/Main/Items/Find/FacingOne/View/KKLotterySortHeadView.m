//
//  KKLotterySortHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKLotterySortHeadView.h"

@implementation KKLotterySortHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
      [self addSubViews];
}
-(instancetype)init
{
    if (self = [super init])
    {
      
        
    }
    return self;
}

-(void)addSubViews{
    
    [self addSubview:self.clickButton];
    [self addSubview:self.clickButton];
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    [self addSubview:self.lotteryButton];
    [self.lotteryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(20);
    }];
    
    [self addSubview:self.lotteryLabel];
    [self.lotteryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lotteryButton.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.lotteryButton);
    }];
    

}

-(UILabel *)lotteryLabel {
    if (_lotteryLabel == nil) {
     
        _lotteryLabel = [[UILabel alloc] init];
        _lotteryLabel.text = @"全部彩种";
        _lotteryLabel.textColor = [UIColor blackColor];
        _lotteryLabel.font = MCFont(12);
    }
    return _lotteryLabel;
}

-(UIButton *)clickButton {
    if (_clickButton == nil) {
        _clickButton = [[UIButton alloc] init];
    }
    return _clickButton;
}
-(UIButton *)lotteryButton {
    if (_lotteryButton == nil) {
        _lotteryButton = [[UIButton alloc] init];
        [_lotteryButton setImage:[UIImage imageNamed:@"icon-find-lottery-all"] forState:UIControlStateNormal];
        _lotteryButton.userInteractionEnabled = NO;
    }
    return _lotteryButton;
}

@end
