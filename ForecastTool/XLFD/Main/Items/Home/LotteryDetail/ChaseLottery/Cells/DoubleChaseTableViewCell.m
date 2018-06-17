//
//  DoubleChaseTableViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/13.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "DoubleChaseTableViewCell.h"
@interface DoubleChaseTableViewCell()
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *periodLabel;
@property(nonatomic, strong)UILabel *multipleLabel;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *endTimeLabel;
@end
@implementation DoubleChaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}
-(void)setModel:(LockTimeModel *)model{
    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.row+1];
    self.periodLabel.text = [NSString stringWithFormat:@"期号：%@",model.lottery_qh];
    self.endTimeLabel.text = [NSString stringWithFormat:@"截止日期：%@",model.lock_time];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"倍数：%@",model.timesStr]];
    
    [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,model.timesStr.length)];
    
    self.multipleLabel.attributedText = str;
    
   
    
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"金额：%.2f元",[model.moneyStr floatValue]]];
    
    [priceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,priceStr.length-4)];
    self.priceLabel.attributedText = priceStr;
    
}
-(void)addSubViews{
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.centerY.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(34, 17));
    }];
    [self addSubview:self.periodLabel];
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 10));
    }];
   
    [self addSubview: self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self addSubview:self.multipleLabel];
    [self.multipleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cancelButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 12));
    }];
    
    [self addSubview:self.endTimeLabel];
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(self.periodLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 10));
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cancelButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.multipleLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 10));
    }];
}
-(void)cancelClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(DoubleChaseTableViewCellDelete:)]) {
        [self.delegate DoubleChaseTableViewCellDelete:self.row];
    }
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.backgroundColor = MCUIColorMain;
        self.countLabel.font = MCFont(12);
        self.countLabel.textColor = MCUIColorWhite;
        self.countLabel.clipsToBounds = YES;
        self.countLabel.layer.cornerRadius = 3;
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.text = @"12";
    }
    return _countLabel;
}
-(UILabel *)periodLabel{
    if (!_periodLabel) {
        self.periodLabel = [[UILabel alloc]init];
        self.periodLabel.textColor = MCUIColorGray;
        self.periodLabel.font = MCFont(10);
        self.periodLabel.text = [NSString stringWithFormat:@"期号：%@",@"2017032234"];
       
    }
    return _periodLabel;
}
-(UILabel *)endTimeLabel{
    if (!_endTimeLabel) {
        self.endTimeLabel = [[UILabel alloc]init];
        self.endTimeLabel.textColor = MCUIColorGray;
        self.endTimeLabel.font = MCFont(10);
       
        
        self.endTimeLabel.text = [NSString stringWithFormat:@"截止日期：%@",@"20170322"];
    }
    return _endTimeLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.textColor = MCUIColorMiddleGray;
        self.priceLabel.font = MCFont(12);
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"金额：%.2f元",12.444]];
        
        [priceStr addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,priceStr.length-4)];
        self.priceLabel.attributedText = priceStr;
    }
    return _priceLabel;
}
-(UILabel *)multipleLabel{
    if (!_multipleLabel) {
        self.multipleLabel = [[UILabel alloc]init];
        self.multipleLabel.textAlignment = NSTextAlignmentRight;
        self.multipleLabel.textColor = MCUIColorMiddleGray;
        self.multipleLabel.font = MCFont(12);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"倍数：%@",@"5"]];
        
        [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(3,str.length-3)];
        
        self.multipleLabel.attributedText = str;
    }
    return _multipleLabel;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]init];
        [self.cancelButton setImage:[UIImage imageNamed:@"Home_cancel"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
