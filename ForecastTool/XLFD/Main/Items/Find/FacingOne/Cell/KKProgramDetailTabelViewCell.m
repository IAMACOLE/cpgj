//
//  KKProgramDetailTabelViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramDetailTabelViewCell.h"

@interface KKProgramDetailTabelViewCell ()
@property (nonatomic, strong) UILabel *issueLabel;
@property (nonatomic, strong) UILabel *winNumberLabel;
@property (nonatomic, strong) UILabel *isWinLabel;
@end

@implementation KKProgramDetailTabelViewCell

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

-(void)addSubViews {
    
    
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];

    lineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    
    [self addSubview:self.issueLabel];
   // self.issueLabel.frame = CGRectMake(0, 0, 80, 24);
    [self.issueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(90);
    }];
    UIView *lineIssueView = [[UIView alloc] init];
    [self addSubview:lineIssueView];
    lineIssueView.backgroundColor = MCUIColorFromRGB(0x979797);
    [lineIssueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(90);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    
    [self addSubview:self.winNumberLabel];
    [self.winNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.isWinLabel];
    
    [self.isWinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(90);
    }];
    
    UIView *lineIsWinView = [[UIView alloc] init];
    [self addSubview:lineIsWinView];
    lineIsWinView.backgroundColor = MCUIColorFromRGB(0x979797);
    [lineIsWinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-90);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)buildWithData:(KKGDDetailModel *)model {
    
    
//    if (self.row%2 == 0) {
//        self.backgroundColor = MCUIColorFromRGB(0xF4F4F4);
//    }else{
//        self.backgroundColor = [UIColor whiteColor];
//    }
    
    
    self.issueLabel.text = model.lottery_qh;
    self.winNumberLabel.text = model.kj_code;
    
    
    //开奖结果(0未开奖1未中奖2撤销3中奖4异常)
    if (model.kj_result == 0) {
        self.isWinLabel.text = @"未开奖";
    }else if (model.kj_result == 1) {
        self.isWinLabel.text = @"未中奖";
        
    }else if (model.kj_result == 2) {
        self.isWinLabel.text = @"撤销";
        
    }else if (model.kj_result == 3) {
        self.isWinLabel.text = @"中奖";
        
    }else if (model.kj_result == 4) {
        self.isWinLabel.text = @"异常";
        
    }else{
        self.isWinLabel.text = @"未知";
    }
    
}


-(UILabel *)issueLabel {
    if (_issueLabel == nil) {
        _issueLabel = [[UILabel alloc]init];
        _issueLabel.text = @"期号";
        
        _issueLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _issueLabel.font = MCFont(12);
        _issueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _issueLabel;
}

-(UILabel *)winNumberLabel {
    if (_winNumberLabel == nil) {
        _winNumberLabel = [[UILabel alloc]init];
        _winNumberLabel.text = @"开奖号码";
        
        _winNumberLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _winNumberLabel.font = MCFont(12);
        _winNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _winNumberLabel;
}


-(UILabel *)isWinLabel {
    if (_isWinLabel == nil) {
        _isWinLabel = [[UILabel alloc]init];
        _isWinLabel.text = @"中奖";
        
        _isWinLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _isWinLabel.font = MCFont(12);
        _isWinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _isWinLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
