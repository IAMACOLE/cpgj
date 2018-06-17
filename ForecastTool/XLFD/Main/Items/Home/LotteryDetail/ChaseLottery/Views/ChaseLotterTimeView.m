//
//  ChaseLotterTimeView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/6.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "ChaseLotterTimeView.h"

@implementation ChaseLotterTimeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect: rect];
    
    [self.distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(kAdapterWith(-35));//-25
        make.bottom.mas_equalTo(0);
    }];
  
    self.distanceLabel.font = MCFont(13);
    self.timeLabel.font = MCFont(13);
    self.timeEndLabel.font = MCFont(13);
    
    self.distanceLabel.textColor = self.textColor;
    self.timeLabel.textColor = self.textColor;
    self.timeEndLabel.textColor = self.textColor;
}


@end
