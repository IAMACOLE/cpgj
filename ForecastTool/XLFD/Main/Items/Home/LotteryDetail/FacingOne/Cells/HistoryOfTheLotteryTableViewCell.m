//
//  TableViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/11.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "HistoryOfTheLotteryTableViewCell.h"
@interface HistoryOfTheLotteryTableViewCell()
@property(nonatomic,strong)UILabel *periodLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *blueCountLabel;
@property(nonatomic, strong)UIView *bottomLine;

@end
@implementation HistoryOfTheLotteryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        
    }
    return self;
}
-(void)setModel:(HistpryOfTheLotteryModel *)model{
    /*
     show_type
     1：圆圈全红色
     2：圆圈，最后一个是蓝色、其他都是红色
     3：圆圈，最后两个是蓝色、其他都是红色
     4：绿色矩形展示*/
    NSArray *lottery_qhArr = [model.kj_code componentsSeparatedByString:@","];
    self.periodLabel.text = [NSString stringWithFormat:@"%@期",model.lottery_qh];
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    for (NSString *str1 in lottery_qhArr) {
        if (str1.length == 1) {
            NSString * resultStr = [NSString stringWithFormat:@"0%@", str1];
            [mutableStr appendString:resultStr];
        } else {
            [mutableStr appendString:str1];
        }
        [mutableStr appendString:@"    "];
    }
     NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:mutableStr];
    
    switch ([model.show_type integerValue]) {
        case 1:
            self.countLabel.text = mutableStr;
            break;
        case 2:
//            [str addAttribute:NSForegroundColorAttributeName value:MCUIColorWithRGB(240, 202, 48, 1) range:NSMakeRange(mutableStr.length-10,10)];
            self.countLabel.attributedText = str;
            break;
        case 3:
            [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(mutableStr.length-6,6)];
            self.countLabel.attributedText = str;
            break;
        case 4:
            [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(mutableStr.length-6,6)];
            self.countLabel.text = mutableStr;
            //            self.countLabel.textColor = [UIColor greenColor];
            break;
        case 5:
            [str addAttribute:NSForegroundColorAttributeName value:MCUIColorMain range:NSMakeRange(mutableStr.length-10,10)];
            self.countLabel.attributedText = str;
            break;
        default:
            break;
    }
}
-(void)addSubViews{
//    [self addSubview:self.bottomLine];
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(15);
//        make.right.equalTo(self);
//        make.bottom.equalTo(self);
//        make.height.mas_equalTo(1);
//    }];
    self.backgroundColor = MCUIColorFromRGB(0xE9DDD7);
    [self addSubview:self.periodLabel];
    
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    
    
    UIImageView *lineView = [UIImageView new];
    lineView.image = [UIImage imageNamed:@"lottery-his-cell-line"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.periodLabel.mas_right);
        make.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(6);
    }];
   
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).with.offset(15);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    
}
-(UILabel *)periodLabel{
    if (!_periodLabel) {
        self.periodLabel = [[UILabel alloc]init];
        self.periodLabel.textColor = [UIColor lightGrayColor];
        self.periodLabel.font = MCFont(14);
        self.periodLabel.textAlignment = NSTextAlignmentCenter;
        self.periodLabel.text = @"2017031231期";
        self.periodLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _periodLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.textColor =  [UIColor lightGrayColor];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.font = MCFont(14);
        self.countLabel.text = @"01 02 03 04 05   06 07";
    }
    return _countLabel;
}
-(UILabel *)blueCountLabel{
    if (!_blueCountLabel) {
        self.blueCountLabel = [[UILabel alloc]init];
        self.blueCountLabel.textColor = [UIColor lightGrayColor];
        self.blueCountLabel.font = MCFont(14);
        self.blueCountLabel.text = @" 07 08";
    }
    return _blueCountLabel;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
