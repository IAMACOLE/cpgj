//
//  KKInReViewRechargeTabelViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/9.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKInReViewRechargeTabelViewCell.h"
@interface KKInReViewRechargeTabelViewCell()
@property(nonatomic,strong)UIImageView *payImageView;
@property(nonatomic,strong)UILabel *integralLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@end
@implementation KKInReViewRechargeTabelViewCell

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

-(void)addSubViews {
    [self addSubview:self.payImageView];
    [self.payImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    
    [self addSubview:self.integralLabel];
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.payImageView.mas_right).with.offset(6);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
}

-(void)buildWithData: (KKInReViewModel *) model {
    self.integralLabel.text = [NSString stringWithFormat:@"%ld",model.price.integerValue * 10];

    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
}
-(UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        _integralLabel.font = [UIFont systemFontOfSize:13];
        _integralLabel.textColor = [UIColor blackColor];
    }
    return _integralLabel;
}

-(UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:11];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.backgroundColor = MCUIColorMain;
        _priceLabel.layer.masksToBounds = YES;
        _priceLabel.layer.cornerRadius = 4;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

-(UIImageView *)payImageView {
    if (!_payImageView) {
         _payImageView = [[UIImageView alloc] init];
         _payImageView.image = [UIImage imageNamed: @"icon-pay"];
    }
    return _payImageView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
