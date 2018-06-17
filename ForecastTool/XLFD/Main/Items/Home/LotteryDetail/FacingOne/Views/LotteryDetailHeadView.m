//
//  LotteryDetailHeadView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/5/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryDetailHeadView.h"
#import "TabsBtn.h"
@implementation LotteryDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    CGFloat space = MCScreenWidth/5;
    
    NSArray *array = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
    for (int j=0; j<array.count; j++) {
        
        TabsBtn *btn = [[TabsBtn alloc]initWithFrame:CGRectMake(j*space, 0, space, 50)];
        [btn setTitle:array[j] forState:UIControlStateNormal];
        //       [btn setImage:[MCTool MCGetImageFromURL:model.imageStr] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Reuse_notSelectd"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Reuse_selected"] forState:UIControlStateSelected];
        btn.tag = 200 + j;
        [btn addTarget:self action:@selector(selctBannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }

}

-(void)selctBannerButtonClick:(UIButton *)sender{
    if (sender.selected) {
       sender.selected = NO;
    }else{
       sender.selected = YES;
    }
    
}
@end
