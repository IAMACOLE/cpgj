//
//  GameSelectCollectionViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/25.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "GameSelectCollectionViewCell.h"
@interface GameSelectCollectionViewCell ()


@property (nonatomic, strong) UIButton * button;

@end
@implementation GameSelectCollectionViewCell
-(void)setModel:(GameSelectDetailModel *)model{
    //self.button.text = model.name;
    [self.button setTitle:model.name forState:UIControlStateNormal];
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
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        if (MCScreenWidth<350) {
            make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(6, 6, 6, 6));
        }else{
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(6, 15, 6, 15));
        }
    }];
}



#pragma mark - setter & getter


- (UIButton *)button
{
    if (!_button)
    {
        self.button = [[UIButton alloc]init];
        self.button.titleLabel.font = MCFont(15.0f);
        [self.button setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-rectangle-normal"] forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
    }
    return _button;
}
-(void)select:(id)sender {
    
}

@end
