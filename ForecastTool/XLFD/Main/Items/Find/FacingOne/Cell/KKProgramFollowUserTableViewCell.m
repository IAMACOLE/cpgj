//
//  KKProgramFollowUserTableViewCell.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKProgramFollowUserTableViewCell.h"
@interface KKProgramFollowUserTableViewCell ()
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation KKProgramFollowUserTableViewCell

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
    [self addSubview:self.userLabel];
    [self addSubview:self.numberLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.timeLabel];
    
    
    NSMutableArray *masonryViewArray = [NSMutableArray array];
    [masonryViewArray addObject:self.userLabel];
    [masonryViewArray addObject:self.numberLabel];
    [masonryViewArray addObject:self.moneyLabel];
    [masonryViewArray addObject:self.timeLabel];
    
    
    //  @param axisType     横排还是竖排
    //  @param fixedSpacing 两个控件间隔
    //  @param leadSpacing  第一个控件与边缘的间隔
    //  @param tailSpacing  最后一个控件与边缘的间隔
    // 实现masonry水平固定间隔方法
    [masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView *userLineView =  [[UIView alloc] init];
    userLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self.userLabel addSubview:userLineView];
    [userLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *numberLineView =  [[UIView alloc] init];
    numberLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self.numberLabel addSubview:numberLineView];
    [numberLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView *moneyLineView =  [[UIView alloc] init];
    moneyLineView.backgroundColor = MCUIColorFromRGB(0x979797);
    [self.moneyLabel addSubview:moneyLineView];
    [moneyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView *leftView = [[UIView alloc] init];
    [self addSubview:leftView];
    leftView.backgroundColor = MCUIColorFromRGB(0x979797);
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] init];
    [self addSubview:rightView];
    rightView.backgroundColor = MCUIColorFromRGB(0x979797);
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self addSubview:rightView];
    
    

    
    UIView *boomView = [[UIView alloc] init];
    [self addSubview:boomView];
    boomView.backgroundColor = MCUIColorFromRGB(0x979797);
    [boomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    [self addSubview:boomView];
}

-(void)buildWithData:(KKGDUserModel *)model {
    self.userLabel.text = model.nick_name;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",model.gd_total_qs];
    self.moneyLabel.text = model.gd_total_money;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *create_timeStr = [model.create_time substringWithRange:NSMakeRange(0, 10)];
    NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[create_timeStr integerValue]];
    
    
    NSString *day = [dateFormatter stringFromDate:theday];
    self.timeLabel.text = day;
}


-(UILabel *)userLabel {
    if (_userLabel == nil) {
        _userLabel = [[UILabel alloc]init];
        _userLabel.text = @"用户";
        
        _userLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _userLabel.font = MCFont(12);
        _userLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userLabel;
}

-(UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.text = @"跟单期数";
        
        _numberLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _numberLabel.font = MCFont(12);
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}


-(UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.text = @"金额";
        
        _moneyLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _moneyLabel.font = MCFont(12);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

-(UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"跟单时间";
        
        _timeLabel.textColor = MCUIColorFromRGB(0x6E6E6E);
        _timeLabel.font = MCFont(12);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
