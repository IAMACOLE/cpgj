//
//  SlotMachineTableViewCell.m
//  KKSlotMachineView
//
//  Created by hello on 2018/3/13.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "SlotMachineTableViewCell.h"

@interface SlotMachineTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation SlotMachineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = titleString;
}

-(void)addSubViews{
    
    UIImageView *bgImageView = [UIImageView new];
    [self addSubview:bgImageView ];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    bgImageView.image = [UIImage imageNamed:@"lottery-trend-cellBg"];
    
    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = MCUIColorFromRGB(0xF9503F);
    titleLabel.text = @"1";
    titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
