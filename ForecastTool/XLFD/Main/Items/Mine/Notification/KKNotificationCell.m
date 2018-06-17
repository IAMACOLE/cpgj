//
//  KKNotificationCell.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKNotificationCell.h"

#import "KKNotificationModel.h"

@interface KKNotificationCell ()

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UIImageView *logoImageView;

@end

@implementation KKNotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    } return self;
}

- (void)addSubviews {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 1, 0));
    }];
    
    [self.bgView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.centerY.equalTo(self.bgView);
        make.width.height.equalTo(@20);
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.logoImageView.mas_right);
        make.top.mas_equalTo(self.bgView).with.offset(15);
    }];
    
    
    [self.bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.bgView).offset(-10);
        make.bottom.mas_equalTo(self.nameLabel);
    }];
        
    [self.bgView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left).offset(10);
        make.right.mas_equalTo(self.bgView).offset(-10);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).with.offset(10);
    }];
}

#pragma mark - setter & getter
- (void)setModel:(KKNotificationModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.timeLabel.text = self.model.create_time;
    self.nameLabel.text = [NSString stringWithFormat:@"【%@】",self.model.title];
    self.detailLabel.text = [NSString stringWithFormat:@"尊敬的会员：%@",self.model.content];;
    
    if ([_model.is_read isEqualToString:@"1"]) {
        self.logoImageView.image = [UIImage imageNamed:@"KKNotificationCell_logoimage_1"];
    }else{
        self.logoImageView.image = [UIImage imageNamed:@"KKNotificationCell_logoimage_0"];
    }
    
}

- (UIView *)bgView {
    if (_bgView == nil) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = MCUIColorWhite;
    } return _bgView;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = MCFont(12);
        self.timeLabel.textColor = [UIColor colorWithRed:183/255.0 green:157/255.0 blue:147/255.0 alpha:1/1.0];
    } return _timeLabel;
}


- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = MCFont(16);
        self.nameLabel.textColor = [UIColor colorWithRed:188/255.0 green:84/255.0 blue:84/255.0 alpha:1];
    } return _nameLabel;
}



- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.font = MCFont(16);
        self.detailLabel.textColor = [UIColor colorWithRed:58/255.0 green:54/255.0 blue:52/255.0 alpha:1/1.0];
    } return _detailLabel;
}

-(UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        self.logoImageView = [[UIImageView alloc]init];
    }
    return _logoImageView;
}


@end
