//
//  BettingTimeView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "BettingTimeView.h"

@implementation BettingTimeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect: rect];
    
    [self.distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(-25);
        make.bottom.mas_equalTo(0);
    }];
    
    self.distanceLabel.font = MCFont(14);
    self.timeLabel.font = MCFont(14);
    self.timeEndLabel.font = MCFont(14);
    self.distanceLabel.textColor = self.textColor;
    self.timeLabel.textColor = self.textColor;
    self.timeEndLabel.textColor = self.textColor;
    
}



@end
