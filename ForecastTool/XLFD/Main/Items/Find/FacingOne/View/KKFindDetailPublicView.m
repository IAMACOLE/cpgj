//
//  KKFindDetailPublicView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/25.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindDetailPublicView.h"

#import "KKFindDetailWinPopView.h"
@interface KKFindDetailPublicView ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *clickButton;
@property(nonatomic,strong)UIImageView *lockView;
@property(nonatomic,strong)KKGDInfoModel *model;
@property(nonatomic,strong)UIView *bgView;
@end


@implementation KKFindDetailPublicView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    } return self;
}

-(void)addSubViews {
    
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(24);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
    }];
    
    
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(6);
        make.bottom.mas_equalTo(-6);
        make.right.mas_equalTo(-12);
    }];
    
    
    [self addSubview:self.lockView];
    [self.lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.titleLabel.mas_left).with.offset(-7);
    }];
    
    
    [self addSubview: self.clickButton];
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    
    
    
}
-(UIButton *)clickButton {
    if (_clickButton == nil) {
        _clickButton = [[UIButton alloc] init];
        [_clickButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}
-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @" ";
        _titleLabel.font = MCFont(12);
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = MCUIColorFromRGB(0x883E3C);
    }
    
    return _titleLabel;
}

-(UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = MCUIColorFromRGB(0xDFCAC1);
    }
    return _bgView;
}


-(UIImageView *)lockView {
    if (_lockView == nil) {
        _lockView = [[UIImageView alloc] init];
        _lockView.image = [UIImage imageNamed:@"icon-find-lock"];
    }
    return _lockView;
}

-(void)buildWithData:(KKGDInfoModel *)model{
    self.model = model;
    //finish_status=1的时候bet_number是下注号码 =0的时候bet_number=跟单结束后可见
    if(model.show_hm.integerValue == 1) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(6);
            make.bottom.mas_equalTo(-6);
            make.right.mas_equalTo(-20);
        }];
        [self.lockView setHidden:YES];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(6);
            make.bottom.mas_equalTo(-6);
  
            make.centerX.mas_equalTo(0);
        }];
         [self.lockView setHidden:NO];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    _titleLabel.text = model.bet_number;
    
}




-(void)btnClick {
    if(self.model.show_hm.integerValue == 1) {
        
        [KKFindDetailWinPopView show: self.model.bet_number];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
