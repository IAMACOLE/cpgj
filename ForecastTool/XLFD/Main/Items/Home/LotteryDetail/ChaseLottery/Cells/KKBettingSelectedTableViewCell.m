//
//  KKBettingSelectedTableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/16.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKBettingSelectedTableViewCell.h"

@interface KKBettingSelectedTableViewCell()



@end

@implementation KKBettingSelectedTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    
    self.selectedNumLabel = [UILabel new];
    [self addSubview:self.selectedNumLabel];
    [self.selectedNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    self.selectedNumLabel.font = [UIFont systemFontOfSize:kAdapterFontSize(13)];
    self.selectedNumLabel.textColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    lineView.backgroundColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
