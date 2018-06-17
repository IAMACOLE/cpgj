//
//  KKPayTypeTabelViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/8.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKPayTypeTabelViewCell.h"
@interface KKPayTypeTabelViewCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *payLabel;
@property(nonatomic,strong)UIImageView *payImageView;
@property(nonatomic,strong)UIImageView *payTypeSelectView;
@end
@implementation KKPayTypeTabelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}

-(void)buildWithData: (KKPayChannelModel *) model {
    self.payLabel.text = model.label;
    
    NSURL *url = [[NSURL alloc] initWithString:model.image_url];
    [self.payImageView sd_setImageWithURL:url];
}

-(void)addSubViews {
    
    UIImageView *bgImage = [UIImageView new];
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
    }];
    bgImage.image = [UIImage imageNamed:@"payTypeCellBg"];
    
    [self addSubview:self.payImageView];
    [self.payImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    [self addSubview:self.payLabel];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.payImageView.mas_right).with.offset(30);
        make.centerY.mas_equalTo(0);
    }];

    [self addSubview:self.payTypeSelectView];
    [self.payTypeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-24);
        make.centerY.mas_equalTo(0);
    }];
    
}


-(UIImageView *)payImageView {
    if (!_payImageView) {
        _payImageView = [[UIImageView alloc] init];
    }
    return _payImageView;
}


-(UIImageView *)payTypeSelectView {
    if (!_payTypeSelectView) {
        _payTypeSelectView = [[UIImageView alloc] init];
        
    }
    return _payTypeSelectView;
}

-(UILabel *)payLabel {
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] init];
        _payLabel.text = @"内购支付";
        _payLabel.font = MCFont(14);
        _payLabel.textColor = MCUIColorFromRGB(0x484848);
    }
    
    return _payLabel;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }

    return _bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected == YES) {
        self.payTypeSelectView.image = [UIImage imageNamed:@"icon-paytype-select"];
    }else{
        self.payTypeSelectView.image = [UIImage imageNamed:@"icon-paytype-noselect"];
    }
    
}

@end
