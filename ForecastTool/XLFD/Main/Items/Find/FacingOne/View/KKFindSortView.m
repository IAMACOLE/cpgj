//
//  KKFindSortView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindSortView.h"


@interface KKFindSortView()

@property (nonatomic, strong) UIButton *brokerageButton;
@end


@implementation KKFindSortView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
  
    
    UIImageView *titleview = [[UIImageView alloc] init];
    titleview.image = [UIImage imageNamed:@"icon-find-titleview"];
    [self addSubview:titleview];
    [titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(120);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = MCFont(13);
    titleLabel.text = @"全部跟单";
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.centerY.mas_equalTo(titleview);
    }];
    
    
    [self addSubview:self.brokerageButton];
    [self.brokerageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(73, 19));
    }];
    
    
    [self addSubview:self.allButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.brokerageButton.mas_left).with.offset(-8);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(73, 19));
    }];
    
}
-(UIButton *)allButton {
    if (_allButton == nil) {
        _allButton = [[UIButton alloc] init];
        [_allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [_allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _allButton.titleLabel.font = MCFont(11);
       
        [_allButton setTitle:@"全部彩种" forState:UIControlStateNormal];
        _allButton.backgroundColor = MCUIColorFromRGB(0xB4B4B4);
        _allButton.layer.masksToBounds = YES;
        _allButton.layer.cornerRadius = 4;
        [_allButton addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

-(UIButton *)brokerageButton {
    if (_brokerageButton == nil) {
        _brokerageButton = [[UIButton alloc] init];
         [_brokerageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_brokerageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
//        [_brokerageButton setBackgroundImage:[UIImage imageNamed:@"icon-find-sort-up"] forState:UIControlStateNormal];
//        
       // [_brokerageButton setBackgroundImage:[UIImage imageNamed:@"icon-find-sort-down"] forState:UIControlStateNormal];
        
        
        _brokerageButton.titleLabel.font = MCFont(11);
        _brokerageButton.backgroundColor = MCUIColorFromRGB(0xB4B4B4);
        [_brokerageButton setTitle:@"按佣金排序" forState:UIControlStateNormal];
        [_brokerageButton addTarget:self action:@selector(brokerageClick) forControlEvents:UIControlEventTouchUpInside];
        _brokerageButton.layer.masksToBounds = YES;
        _brokerageButton.layer.cornerRadius = 4;
    }
    return _brokerageButton;
}

-(void)allClick {
    
    [self.brokerageButton setSelected:NO];
    [self.allButton setSelected:YES];
    
    if ([self.delegate respondsToSelector:@selector(didClickSortAll:)] && self.delegate) {
        [self.delegate didClickSortAll:self];
    }
}

-(void)brokerageClick{
    
    
    [self.brokerageButton setSelected:YES];
    [self.allButton setSelected:NO];
    
    
    
    if ([self.delegate respondsToSelector:@selector(didClickSortBrokerage:)] && self.delegate) {
        [self.delegate didClickSortBrokerage:self];
    }
}



@end
