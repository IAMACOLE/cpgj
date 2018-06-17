//
//  LotteryDetailTitleView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/2.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "LotteryDetailTitleView.h"


@interface LotteryDetailTitleView()
@property(nonatomic,strong)UIImageView *downView;
@end

@implementation LotteryDetailTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize buttonSize = [self.centerButton sizeThatFits:CGSizeMake(120, 40)];
    self.centerButton.frame = CGRectMake((self.frame.size.width - 120) / 2, (self.frame.size.height - buttonSize.height) / 2, 120, buttonSize.height);
    
    self.downView.frame = CGRectMake(CGRectGetMaxX(self.centerButton.frame) - 22 + 3, (self.frame.size.height - 10) / 2, 12, 10);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 200, 40);

        _centerButton = [[UIButton alloc] init];
        _centerButton.titleLabel.font = MCFont(18);
        _centerButton.backgroundColor = [UIColor whiteColor];
        _centerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _centerButton.backgroundColor = [UIColor clearColor];
        _centerButton.titleLabel.textColor = [UIColor whiteColor];
        _centerButton.layer.cornerRadius = 4;
        _centerButton.layer.borderColor = [[UIColor whiteColor] CGColor];
        _centerButton.layer.borderWidth = 0.5;

        [_centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_centerButton setContentEdgeInsets:UIEdgeInsetsMake(2, 4, 2, 22)];
        //[_centerButton setTitleEdgeInsets: UIEdgeInsetsMake(0, 4, 0, 4)];
        [self addSubview: _centerButton];

        _downView = [[UIImageView alloc] init];
        _downView.image = [UIImage imageNamed: @"icon-lotterydetail-class-down"];
        [self addSubview: _downView];
        
    }
    return self;
}

-(void)centerButtonClick:(UIButton *)sender {
    self.showFilterViewBlock();
}

- (void)setTitle:(NSString *)titleString {
    _titleString = titleString;
  
    [_centerButton setTitle:titleString forState:UIControlStateNormal];

  
}

@end
