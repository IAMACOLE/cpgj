//
//  KKFindDetailWinPopView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/25.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindDetailWinPopView.h"
@interface KKFindDetailWinPopView ()

@property (nonatomic, strong) UITextView *numbersLabel;

@end
@implementation KKFindDetailWinPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self addSubViews];
    
}

-(void)addSubViews {
    
    UIView *popView = [[UIView alloc] init];
    popView.backgroundColor = [UIColor whiteColor];
    popView.layer.masksToBounds = YES;
    popView.layer.cornerRadius = 4;
    [self addSubview:popView];
    
    
    
    
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
         make.centerY.mas_equalTo(0);
         make.size.mas_equalTo(CGSizeMake(kAdapterWith(284), kAdapterheight(200)));
    }];
    
    
    [popView addSubview:self.numbersLabel];
    [self.numbersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"icon-find-lotterysort-close"] forState:UIControlStateNormal];
    [self addSubview:closeButton];
    
    [closeButton addTarget:self action:@selector(hidenView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(popView.mas_bottom).with.offset(20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
}
-(void)hidenView {
    [self removeFromSuperview];
}
-(UITextView *)numbersLabel {
    if (_numbersLabel == nil) {
        _numbersLabel = [[UITextView alloc] init];
        //_numbersLabel.numberOfLines = 0;
        _numbersLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _numbersLabel.editable = NO;
        //[_numbersLabel setContentInset:[UIEdgeInsetsMake(0, 0, 0, 0)];
        _numbersLabel.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
         _numbersLabel.font = MCFont(14);
    }
    return _numbersLabel;
}
+(KKFindDetailWinPopView *)show:(NSString *)numbersStr {
    
    KKFindDetailWinPopView *view = [[KKFindDetailWinPopView alloc]initWithFrame:CGRectMake(0,0, MCScreenWidth, MCScreenHeight)];

    view.numbersLabel.text = numbersStr;
    view.backgroundColor = MCUIColorWithRGB(0, 0, 0, 0.63);
    //获取当前UIWindow 并添加一个视图
    UIApplication *ap = [UIApplication sharedApplication];
    
    [ap.keyWindow addSubview:view];
    
    return view;
    
    
}


@end
