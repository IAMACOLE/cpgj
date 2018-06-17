//
//  KKTrendHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/10.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKTrendHeadView.h"
#import "SlotMachineView.h"

@interface KKTrendHeadView()
@property (nonatomic, strong) UIImageView  * bgView;
@property (nonatomic, strong) SlotMachineView *slotMachineView;
@end

@implementation KKTrendHeadView

-(void)stopRollingAnimation{
    [self.slotMachineView stopRollingAnimation];
}


- (void)drawRect:(CGRect)rect {
    
    self.slotMachineView = [[SlotMachineView alloc]initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30) initialNumbers:@"10000"];
    [self addSubview:self.slotMachineView];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.textColor = [UIColor grayColor];
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.slotMachineView.mas_bottom).mas_offset(10);
    }];
    tipLabel.text = @"辉久彩票累积中奖...";
    tipLabel.font = MCFont(12);
}

-(void)reloadDataWithNewNumberString:(NSString *)newNumberString{
    [self.slotMachineView reloadDataWithNumbersStr:newNumberString];
}

- (UIImageView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIImageView alloc] init];
        self.bgView.image = [UIImage imageNamed:@"icon-trend-head"];
    } return _bgView;
}

@end
