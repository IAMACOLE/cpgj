//
//  KKSSCBaseCollectionViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/2/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKSSCBaseCollectionViewCell.h"

@implementation KKSSCBaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        UIButton *btn = [UIButton new];
        _btn = btn;
        btn.frame = CGRectMake(0, 0, kAdapterWith(42), kAdapterWith(42));
        [self addSubview:btn];
        [btn setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = MCFont(16);
        btn.clipsToBounds = YES;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-round-normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-round-select"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)selectBtn:(UIButton *)sender{
    if(self.didSelectedCellBlock){
        self.didSelectedCellBlock();
    }
}

@end
