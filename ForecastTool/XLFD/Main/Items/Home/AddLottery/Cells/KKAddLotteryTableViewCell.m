//
//  KKAddLotteryTableViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/9.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAddLotteryTableViewCell.h"
@interface KKAddLotteryTableViewCell()
@property(nonatomic,strong)UIImageView *lotteryImageView;
@property(nonatomic,strong)UILabel *lotteryName;
@property(nonatomic ,strong) UIButton *isAddButton;
@end
@implementation KKAddLotteryTableViewCell

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
-(void)setModel:(BannerButtonModel *)model{
    _model = model;
    [self.lotteryImageView sd_setImageWithURL:[NSURL URLWithString:model.lottery_image] placeholderImage:[UIImage imageNamed:@"addLottery"]];
    self.lotteryName.text = model.lottery_name;
    NSLog(@"%@",model.lottery_flag);
    if ([model.lottery_flag  isEqual: @"1"]) {
        self.isAddButton.selected = NO;
    }
    else{
        self.isAddButton.selected = YES;
    }
}
-(void)addSubViews{
    [self addSubview:self.lotteryImageView];
    [self.lotteryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    [self addSubview:self.lotteryName];
    [self.lotteryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lotteryImageView.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 21));
    }];
    
    [self addSubview:self.isAddButton];
    [self.isAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        make.centerY.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
-(void)addLotteryClick:(UIButton *)sender{
    if (sender.selected) {
        sender.selected = NO;
        _model.lottery_flag = @"1";
      
    }else{
        _model.lottery_flag = @"0";
        sender.selected = YES;
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(AddLotteryStatusClick:andRow:)]) {
        [self.delegate AddLotteryStatusClick:_model andRow:self.row];
    }
}

-(UIButton *)isAddButton{
    if (!_isAddButton) {
        self.isAddButton = [[UIButton alloc]init];
        [self.isAddButton addTarget:self action:@selector(addLotteryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.isAddButton setImage:[UIImage imageNamed:@"Reuse_reduce"] forState:UIControlStateNormal];
        [self.isAddButton setImage:[UIImage imageNamed:@"Reuse_add"] forState:UIControlStateSelected];
        
    }
    return _isAddButton;
}
-(UIImageView *)lotteryImageView{
    if (!_lotteryImageView) {
        self.lotteryImageView = [[UIImageView alloc]init];
        
    }
    return _lotteryImageView;
}
-(UILabel *)lotteryName{
    if (!_lotteryName) {
        self.lotteryName = [[UILabel alloc]init];
        self.lotteryName.font = MCFont(17);
    }
    return _lotteryName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
