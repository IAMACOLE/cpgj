//
//  ChaseLotteryV2TableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "ChaseLotteryTableViewCell.h"


@interface ChaseLotteryTableViewCell()
//@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *periodLabel;
@property(nonatomic, strong)UIButton *multipleLabel;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UILabel *priceLabel;
//@property(nonatomic,strong)UIView *mainBGView;
@property(nonatomic,strong)UIView *editNumberView;

@end


@implementation ChaseLotteryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubViews];
        
    }
    return self;
}
-(void)setModel:(LockTimeModel *)model{
    
    _model = model;
    self.periodLabel.text = [NSString stringWithFormat:@"%@",model.show_qh];
    [self.multipleLabel setTitle:[NSString stringWithFormat:@"%@",model.timesStr] forState:UIControlStateNormal];
    self.priceLabel.text = model.moneyStr;
}


-(void)addSubViews{
    
    [self addSubview:self.periodLabel];
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(0);
        make.centerY.mas_equalTo(self);
        make.height.equalTo(@27);
        make.width.equalTo(@(kAdapterWith(50)));
    }];
    
    [self addSubview: self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(kAdapterWith(-5));
        make.centerY.mas_equalTo(self).with.offset(0);
        make.height.equalTo(@27);
        make.width.equalTo(@(kAdapterWith(40)));
    }];
    
    
    [self addSubview:self.editNumberView];
    [self.editNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.periodLabel.mas_right).with.offset(0.5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kAdapterWith(150));
    }];
    
    [self addSubview:self.multipleLabel];
    [self.multipleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.editNumberView.mas_left).offset(kAdapterWith(35));
        make.right.mas_equalTo(self.editNumberView.mas_right).offset(kAdapterWith(-35));
        make.centerY.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(kAdapterWith(110-74), 34));
    }];


    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editNumberView.mas_right).offset(0.5);
        make.right.mas_equalTo(self.cancelButton.mas_left);
        make.centerY.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(kAdapterWith(54), 10));
    }];
    
    UIView *lin2View = [[UIView alloc] init];
    lin2View.backgroundColor = MCUIColorLighttingBrown;
//    lin2View.frame = CGRectMake(kAdapterWith(50), 0, 0.5, 34);
    [self addSubview:lin2View];
    [lin2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.periodLabel.mas_right);
        make.top.mas_equalTo(self);
        make.height.equalTo(@34);
        make.width.equalTo(@0.5);
    }];
    
    
    UIView *lin3View = [[UIView alloc] init];
    lin3View.backgroundColor = MCUIColorLighttingBrown;
//    lin3View.frame = CGRectMake(CGRectGetMaxX(lin2View.frame) + kAdapterWith(110), 0, 0.5, 34);
    [self addSubview:lin3View];
    [lin3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.editNumberView.mas_right);
        make.top.mas_equalTo(self);
        make.height.equalTo(@34);
        make.width.equalTo(@0.5);
    }];
    
    UIView *lin4View = [[UIView alloc] init];
    lin4View.backgroundColor = MCUIColorLighttingBrown;
    lin4View.frame = CGRectMake(MCScreenWidth - 46, 0, 0.5, 34);
    [self addSubview:lin4View];
    [lin4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right);
        make.top.equalTo(self);
        make.height.equalTo(@34);
        make.width.equalTo(@0.5);
    }];
    
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.backgroundColor = MCUIColorLighttingBrown;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)cancelClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChaseLotteryTableViewCellDelegate:)]) {
        [self.delegate ChaseLotteryTableViewCellDelegate:self.row];
    }
}
-(void)addlClick{
    CGFloat tempMoneyStr = [self.model.moneyStr floatValue] / self.multipleLabel.titleLabel.text.integerValue;
    NSInteger multipleVal = self.multipleLabel.titleLabel.text.integerValue + 1;
    if (multipleVal > BigBettingRate) {
        [MCView BSMBProgressHUD_onlyTextWithView:[MCTool getCurrentVC].view andText:[NSString stringWithFormat:@"最多只能设置%d倍",BigBettingRate]];
        multipleVal = BigBettingRate;
    }
    [self.multipleLabel setTitle:[NSString stringWithFormat:@"%li",(long)multipleVal] forState:UIControlStateNormal];
    self.priceLabel.text =  [NSString stringWithFormat:@"%.02f", multipleVal *  tempMoneyStr];
    self.model.moneyStr = self.priceLabel.text;
    _model.timesStr = self.multipleLabel.titleLabel.text;
    [self didChangePrice];
}
-(void)sublClick{
    CGFloat tempMoneyStr = [self.model.moneyStr floatValue] / self.multipleLabel.titleLabel.text.integerValue;
    NSInteger multipleVal = self.multipleLabel.titleLabel.text.integerValue - 1;
    
    if (multipleVal > 0) {
         [self.multipleLabel setTitle:[NSString stringWithFormat:@"%li",(long)multipleVal] forState:UIControlStateNormal];
//         self.multipleLabel.titleLabel.text = [NSString stringWithFormat:@"%li",(long)multipleVal];
        self.priceLabel.text =  [NSString stringWithFormat:@"%.02f", multipleVal *  tempMoneyStr];
        self.model.moneyStr = self.priceLabel.text;
        _model.timesStr = self.multipleLabel.titleLabel.text;
        [self didChangePrice];
    }
}

-(void)didChangePrice{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeTotalPrices)]) {
        [self.delegate changeTotalPrices];
    }
}

-(UIView *)editNumberView {
    if (!_editNumberView) {
        self.editNumberView = [[UIView alloc] init];
        self.editNumberView.backgroundColor = [UIColor clearColor];
        
        UIButton *subButton = [[UIButton alloc] init];
        [subButton setImage:[UIImage imageNamed:@"icon-lotterydetail-sub"] forState:UIControlStateNormal];
        [self.editNumberView addSubview: subButton];
        subButton.frame = CGRectMake(0, 0, kAdapterWith(35), 34);
        [subButton addTarget:self action:@selector(sublClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *addButton = [[UIButton alloc] init];
        [self.editNumberView addSubview: addButton];
        [addButton setImage:[UIImage imageNamed:@"icon-lotterydetail-add"] forState:UIControlStateNormal];
        addButton.frame = CGRectMake(kAdapterWith(150) - kAdapterWith(35), 0, kAdapterWith(35), 34);
        [addButton addTarget:self action:@selector(addlClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _editNumberView;
}

-(UILabel *)periodLabel{
    if (!_periodLabel) {
        self.periodLabel = [[UILabel alloc]init];
        self.periodLabel.textColor = [UIColor blackColor];
        self.periodLabel.font = MCFont(14);
        self.periodLabel.adjustsFontSizeToFitWidth = YES;
        self.periodLabel.textAlignment = NSTextAlignmentCenter;
        self.periodLabel.text = [NSString stringWithFormat:@"期号：%@",@"2017032234"];
    }
    return _periodLabel;
}

//-(UIView *)mainBGView{
//    if (!_mainBGView) {
//        self.mainBGView = [[UIView alloc]init];
//
//        self.mainBGView.backgroundColor = MCUIColorWithRGB(8, 8, 8, 0.3);
//    }
//    return _mainBGView;
//}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.textColor = [UIColor blackColor];
        self.priceLabel.font = MCFont(14);
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
    
        self.priceLabel.text = @"100";
    }
    return _priceLabel;
}
-(UIButton *)multipleLabel{
    if (!_multipleLabel) {
        self.multipleLabel = [[UIButton alloc]init];
        [self.multipleLabel setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.multipleLabel.titleLabel setFont:MCFont(14)];
//        self.multipleLabel.textAlignment = NSTextAlignmentCenter;
//        self.multipleLabel.textColor = MCUIColorMain;
//        self.multipleLabel.font = MCFont(14);
//        self.multipleLabel.text = @"1";
        [self.multipleLabel setTitle:@"1" forState:UIControlStateNormal];
        
        [self.multipleLabel addTarget:self action:@selector(clickMultipleLabel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _multipleLabel;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]init];
       
        self.cancelButton.backgroundColor = MCUIColorLighttingBrown;
        self.cancelButton.layer.masksToBounds = YES;
        self.cancelButton.layer.cornerRadius = 4;
        
        [self.cancelButton setTitle:@"删除" forState: UIControlStateNormal];
    
        self.cancelButton.titleLabel.font = MCFont(14);
       
        [self.cancelButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
       
        [self.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


-(void)clickMultipleLabel{
    NSInteger cellRow = 200 + self.row;
    if ([self.delegate respondsToSelector:@selector(stareEditing:andStatus:andSelectTextField:)]) {
        [self.delegate stareEditing:self.multipleLabel.titleLabel.text andStatus:@"倍" andSelectTextField:cellRow];
    }
}

@end
