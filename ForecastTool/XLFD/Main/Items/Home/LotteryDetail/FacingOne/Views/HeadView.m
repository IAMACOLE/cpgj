//
//  HeadView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "HeadView.h"

@interface HeadView()
@property(nonatomic,strong)UIButton *historyButton;
@property(nonatomic,strong)UIButton *followButton;

@end
@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{
    
    self.backgroundColor = MCMineTableCellBgColor;
    
    [self addSubview:self.currentPlayLabel];
    [self.currentPlayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        
    }];
    
    UIImageView *yaoyiyaoImageView = [[UIImageView alloc] init];
    yaoyiyaoImageView.image = [UIImage imageNamed: @"icon-lotterydetail-yaoyiyao"];
    [self addSubview:yaoyiyaoImageView];
    yaoyiyaoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickShakeActionImageView)];
    [yaoyiyaoImageView addGestureRecognizer:tap];
    
    [yaoyiyaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self.currentPlayLabel);
    }];
    
    [self addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(36);
        make.centerY.mas_equalTo(self.currentPlayLabel);
        make.width.mas_equalTo(100);
    }];
    
}


//从新刷新数据
-(void)endTimeReloadData{

    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeReloadData)]) {
        [self.delegate endTimeReloadData];
    }
}
//本期已封顶
-(void)endTimeResponder{
    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeResponder)]) {
        [self.delegate endTimeResponder];
    }
}

-(void)didClickShakeActionImageView{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(shakeActionClick)]) {
        [self.delegate shakeActionClick];
    }
}

-(void)didClickFollowBtn:(UIButton *)sender{
    if(self.delegate){
        UIViewController *vc = (UIViewController *)self.delegate;
        [vc.tabBarController setSelectedIndex:2];
        [vc.navigationController popToRootViewControllerAnimated:NO];
    }
}

-(UIButton *)followButton{
    if (!_followButton) {
        self.followButton = [[UIButton alloc]init];
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"follow-btn-bg"] forState:UIControlStateNormal];
        self.followButton.titleLabel.font = MCFont(16);
        [self.followButton setTitle:@"大神跟单" forState:UIControlStateNormal];
        [self.followButton addTarget:self action:@selector(didClickFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
     return _followButton;
    
}

-(UILabel *)currentPlayLabel{
    if (!_currentPlayLabel) {
        _currentPlayLabel = [[UILabel alloc]init];
        _currentPlayLabel.font = MCFont(kAdapterFontSize(13));
        _currentPlayLabel.textColor = [UIColor blackColor];
        _currentPlayLabel.text = @"正在加载";
    }
    return _currentPlayLabel;
}
//-(LotteryTimeView *)timeView{
//    if (!_timeView) {
//        self.timeView = [[LotteryTimeView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, 30)];
//        self.timeView.backgroundColor = [UIColor clearColor];
//        self.timeView.delegate = self;
//    }
//    return _timeView;
//}

@end
