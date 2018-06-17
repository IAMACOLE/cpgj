//
//  KKProgramDetailHaedView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramDetailHaedView.h"
@interface KKProgramDetailHaedView ()
@property (nonatomic, strong) UILabel *issueLabel;
@property (nonatomic, strong) UILabel *winNumberLabel;
@property (nonatomic, strong) UILabel *isWinLabel;
@end
@implementation KKProgramDetailHaedView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIView *topLineView = [[UIView alloc] init];
    [self addSubview:topLineView];
    
    topLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    
    lineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    
    [self addSubview:self.issueLabel];
    [self.issueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(24);
    }];
    
    
    UIView *lineIssueView = [[UIView alloc] init];
    [self addSubview:lineIssueView];
    lineIssueView.backgroundColor = MCUIColorFromRGB(0x979797);
    [lineIssueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(90);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    
    
    
    [self addSubview:self.winNumberLabel];
    //self.winNumberLabel.frame = CGRectMake(80, 0, MCScreenWidth - 80 - 50, 24);
    [self.winNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(24);
    }];
    
    
    
    [self addSubview:self.isWinLabel];

    [self.isWinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(24);
    }];
    
    UIView *lineIsWinView = [[UIView alloc] init];
    [self addSubview:lineIsWinView];
    lineIsWinView.backgroundColor = MCUIColorFromRGB(0x979797);
    [lineIsWinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-90);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    //self.isWinLabel.frame = CGRectMake(CGRectGetMaxX(self.winNumberLabel.frame), 0, 50, 24);
    
   
}
-(UILabel *)issueLabel {
    if (_issueLabel == nil) {
        _issueLabel = [[UILabel alloc]init];
        _issueLabel.text = @"期号";
       
        _issueLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _issueLabel.font = MCFont(12);
        _issueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _issueLabel;
}

-(UILabel *)winNumberLabel {
    if (_winNumberLabel == nil) {
        _winNumberLabel = [[UILabel alloc]init];
        _winNumberLabel.text = @"开奖号码";
        
        _winNumberLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _winNumberLabel.font = MCFont(12);
        _winNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _winNumberLabel;
}


-(UILabel *)isWinLabel {
    if (_isWinLabel == nil) {
        _isWinLabel = [[UILabel alloc]init];
        _isWinLabel.text = @"中奖";
        
        _isWinLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _isWinLabel.font = MCFont(12);
        _isWinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _isWinLabel;
}

@end
