//
//  KKActivityTableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKActivityTableViewCell.h"



@interface KKActivityTableViewCell ()
@property (nonatomic, strong) UIImageView  * planView;
@property (nonatomic, strong) UILabel  * titleLabel;
@end

@implementation KKActivityTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}


-(void)buildWithData:(KKActivityModel *)model {
    NSURL *url = [[NSURL alloc] initWithString:model.image_url];
    
    [self.planView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Reuse_placeholder_50*50"]];
    self.titleLabel.text = model.title;
    
}

-(void)addSubViews{
    
    [self addSubview:self.planView];
    [self.planView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.planView.mas_right).with.offset(12);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
    
    UIImageView *dottedLine = [UIImageView new];
    [self addSubview:dottedLine];
    [dottedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.left.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.planView);
    }];
    dottedLine.image = [UIImage imageNamed:@"dotted_line"];
    
}


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MCUIColorFromRGB(0x3C4046);
        _titleLabel.font = MCFont(kAdapterFontSize(17));

        _titleLabel.text = @"扭亏为盈每日爱心补助，辉久助您满血复活，辉久助您满血复活。";
        _titleLabel.numberOfLines = 2;
    } return _titleLabel;
}
- (UIImageView *)planView {
    if (_planView == nil) {
        _planView = [[UIImageView alloc] init];
    } return _planView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
