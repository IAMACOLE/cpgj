//
//  XXSamePeriodCollectionViewCell.m
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXSamePeriodCollectionViewCell.h"

@implementation XXSamePeriodCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIButton *btn = [UIButton new];
        _btn = btn;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:20];
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}


-(void)setNumber:(NSString *)number{
    _number = number;
    [_btn setTitle:number forState:UIControlStateNormal];
}

-(void)setCellHight:(CGFloat)cellHight{
    _cellHight = cellHight;
    [_btn.layer setCornerRadius:cellHight/2];
}
@end
