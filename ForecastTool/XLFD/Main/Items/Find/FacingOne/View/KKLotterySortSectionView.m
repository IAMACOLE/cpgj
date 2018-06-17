//
//  KKLotterySortSectionView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKLotterySortSectionView.h"
#import "HomeSubButtonModel.h"
#import "KKLotterySortButton.h"
@interface KKLotterySortSectionView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleView;
@end
@implementation KKLotterySortSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
     [self addSubViews];
     
}

-(instancetype)init
{
    if (self = [super init])
    {
       

    }
    return self;
}


-(void)addSubViews{
    

    
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-10);

        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(90);

        make.height.mas_equalTo(15);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = MCUIColorFromRGB(0xf4f4f4);
//    [self addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//    }];

}

-(void)buildWithData:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
 
}



-(UIImageView *)titleView {
    if (_titleView == nil) {
        _titleView = [[UIImageView alloc] init];
        _titleView.image = [UIImage imageNamed:@"icon-find-caizhong"];

    }
    return _titleView;
}

-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = MCFont(13);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
