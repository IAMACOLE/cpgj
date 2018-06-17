//
//  XXLLuckyCollectionViewCell.m
//  XXLuckyProject
//
//  Created by hello on 2018/5/23.
//  Copyright © 2018年 XXL. All rights reserved.
//

#import "XXLLuckyCollectionViewCell.h"

@interface XXLLuckyCollectionViewCell()

@end

@implementation XXLLuckyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIButton *btn = [UIButton new];
        _btn = btn;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}

-(void)setRanking:(NSString *)ranking{
    _ranking = ranking;
    [_btn setTitle:ranking forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btn.layer.borderWidth = 0.5;
    _btn.layer.borderColor = [UIColor blackColor].CGColor;
}

-(void)setNumber:(NSString *)number{
    _number = number;
    [_btn setTitle:number forState:UIControlStateNormal];
}

@end
