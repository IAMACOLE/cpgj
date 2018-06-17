//
//  ChaseLotteryHeaderView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/5.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "ChaseLotteryHeaderView.h"

@interface ChaseLotteryHeaderView()<UITextFieldDelegate,LotteryTimeViewDelegate>

@property(nonatomic,strong)UILabel *chasePreiodLabel;
@property(nonatomic,strong)UILabel *chasePreiod2Label;

@property(nonatomic,strong)UILabel *chasePlanLabel;

@property(nonatomic,strong)UIView *sectionView;

@property(nonatomic,strong)UILabel *modelLabel;

@end


@implementation ChaseLotteryHeaderView


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {
    
    [self addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    [self addSubview:self.chasePreiodLabel];
    [self.chasePreiodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self.timeView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(16);
    }];
    
    [self addSubview:self.preiodButton];
    [self.preiodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chasePreiodLabel.mas_right).with.offset(2);
        make.centerY.mas_equalTo(self.chasePreiodLabel);
        make.height.mas_equalTo(21);
    }];
    
    [self addSubview:self.chasePreiod2Label];
    [self.chasePreiod2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.preiodButton.mas_right).with.offset(2);
        make.centerY.mas_equalTo(self.chasePreiodLabel);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *bettingLabel = [[UILabel alloc]init];
    bettingLabel.text = @"起始";
    bettingLabel.font = MCFont(kAdapterFontSize(14));
    bettingLabel.textColor =  MCUIColorFromRGB(0x837B77);
    [self addSubview:bettingLabel];
    [bettingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.chasePreiod2Label.mas_right).with.offset(kAdapterWith(20));
        make.centerY.mas_equalTo(self.chasePreiodLabel);
        make.height.mas_equalTo(16);
    }];
   
    
    [self addSubview:self.timesButton];
    [self.timesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bettingLabel.mas_right).with.offset(2);
        make.centerY.mas_equalTo(bettingLabel);
        make.height.mas_equalTo(21);
    }];
    
    UILabel *betting3Label = [[UILabel alloc]init];
    betting3Label.text = @"倍";
    betting3Label.font = MCFont(kAdapterFontSize(14));
    betting3Label.textColor =  MCUIColorFromRGB(0x837B77);
    [self addSubview:betting3Label];
    [betting3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timesButton.mas_right).with.offset(2);
        make.centerY.mas_equalTo(self.timesButton);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *bettingLabel2 = [[UILabel alloc]init];
    [self addSubview:bettingLabel2];
    bettingLabel2.text = @"倍";
    bettingLabel2.font = MCFont(kAdapterFontSize(14));
    bettingLabel2.textColor =  MCUIColorFromRGB(0x837B77);
    [bettingLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(kAdapterWith(-10));
        make.centerY.mas_equalTo(self.timesButton);
        make.height.mas_equalTo(16);
    }];
    
    
    [self addSubview:self.bonusButton];
    
    [self.bonusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bettingLabel2.mas_left).with.offset(-2);
        make.centerY.mas_equalTo(bettingLabel2);
        make.height.mas_equalTo(21);
    }];
    
    UILabel *bettingLabel1 = [[UILabel alloc]init];
    [self addSubview:bettingLabel1];
    bettingLabel1.text = @"翻";
    bettingLabel1.font = MCFont(kAdapterFontSize(14));
    bettingLabel1.textColor =  MCUIColorFromRGB(0x837B77);
    [bettingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bonusButton.mas_left).with.offset(-2);
        make.centerY.mas_equalTo(self.bonusButton);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *proideLabel = [[UILabel alloc]init];
    [self addSubview:proideLabel];
    proideLabel.text = @"期";
    proideLabel.font = MCFont(kAdapterFontSize(14));
    proideLabel.textColor =  MCUIColorFromRGB(0x837B77);
    [proideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bettingLabel1.mas_left).with.offset(kAdapterWith(-15));
        make.centerY.mas_equalTo(bettingLabel1);
        make.height.mas_equalTo(16);
    }];
    
    [self addSubview:self.modelButton];
    [self.modelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(proideLabel);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(proideLabel.mas_left).with.offset(-2);
    }];
    
    
    [self addSubview:self.modelLabel];
    [self.modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_modelButton);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(_modelButton.mas_left).with.offset(-2);
    }];
    
   [self addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(27);
        //make.top.mas_equalTo(self.preiodButton.mas_bottom).with.offset(5);
    }];
    
    
}
//从新刷新数据
-(void)endTimeReloadData{
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeReloadData)]) {
        [self.delegate endTimeReloadData];
    }
}
//本期已封顶
-(void)endTimeResponder{
    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeResponder)]) {
        [self.delegate endTimeResponder];
    }
}


-(void)editButtonClick:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(stareEditing:andStatus:andSelectTextField:)]) {
        if (sender == self.preiodButton) {
            [self.delegate stareEditing:self.preiodButton.titleLabel.text andStatus:@"期" andSelectTextField:1];
        } else if (sender == self.timesButton){
            [self.delegate stareEditing:self.timesButton.titleLabel.text andStatus:@"倍" andSelectTextField:2];
        }else if(sender == self.modelButton){
            [self.delegate stareEditing:self.modelButton.titleLabel.text andStatus:@"期" andSelectTextField:4];
        }
        else{
              [self.delegate stareEditing:self.bonusButton.titleLabel.text andStatus:@"倍" andSelectTextField:3];
        }
    }
    

}

-(UIView *)sectionView {
    if (!_sectionView) {
        self.sectionView = [[UIView alloc]init];
        self.sectionView.backgroundColor = MCUIColorLighttingBrown;
        
//        UILabel *idLabel = [[UILabel alloc] init];
//        idLabel.font = [UIFont systemFontOfSize:14];
//        idLabel.frame = CGRectMake(0, 0, kAdapterWith(50), 27);
//        idLabel.text = @"序号";
//        idLabel.font = MCFont(14);
//        idLabel.textAlignment = NSTextAlignmentCenter;
//        idLabel.textColor = MCUIColorFromRGB(0xACDAC5);
//        [self.sectionView addSubview:idLabel];
//
        UILabel *preiodLabel = [[UILabel alloc] init];
        preiodLabel.font = [UIFont systemFontOfSize:14];
        preiodLabel.text = @"期号";
        preiodLabel.font = MCFont(14);
        preiodLabel.textAlignment = NSTextAlignmentCenter;
        preiodLabel.textColor = [UIColor blackColor];
        [self.sectionView addSubview:preiodLabel];
        [preiodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.sectionView);
            make.width.equalTo(@(kAdapterWith(50)));
            make.height.equalTo(@27);
        }];
        
        
        UILabel *multipleLabel = [[UILabel alloc] init];
        multipleLabel.font = [UIFont systemFontOfSize:14];
//        multipleLabel.frame = CGRectMake(CGRectGetMaxX(preiodLabel.frame), 0, kAdapterWith(200), 27);
        multipleLabel.text = @"倍数";
        multipleLabel.font = MCFont(14);
        multipleLabel.textAlignment = NSTextAlignmentCenter;
        multipleLabel.textColor = [UIColor blackColor];
        [self.sectionView addSubview:multipleLabel];
        
        [multipleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sectionView);
            make.left.equalTo(preiodLabel.mas_right).offset(0.5);
            make.width.equalTo(@(kAdapterWith(150)));
            make.height.equalTo(@27);
        }];
        
        
        
        UILabel *bonusLabel = [[UILabel alloc] init];
        bonusLabel.font = [UIFont systemFontOfSize:14];
//        bonusLabel.frame = CGRectMake(MCScreenWidth- 46, 0, 46, 27);
        bonusLabel.text = @"编辑";
        bonusLabel.font = MCFont(14);
        bonusLabel.textAlignment = NSTextAlignmentCenter;
        bonusLabel.textColor = [UIColor blackColor];
        [self.sectionView addSubview:bonusLabel];
        [bonusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.sectionView);
            make.width.equalTo(@(kAdapterWith(50)));
            make.height.equalTo(@27);
        }];
        
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.font = [UIFont systemFontOfSize:14];
//        moneyLabel.frame = CGRectMake(CGRectGetMaxX(multipleLabel.frame), 0, MCScreenWidth - CGRectGetMaxX(multipleLabel.frame) - 46,  27);
        moneyLabel.text = @"金额";
        moneyLabel.font = MCFont(14);
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.textColor = [UIColor blackColor];
        [self.sectionView addSubview:moneyLabel];
        
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sectionView);
            make.left.equalTo(multipleLabel.mas_right).offset(0.5);
            make.right.equalTo(bonusLabel.mas_left).offset(-0.5);
            make.height.equalTo(@27);
        }];
        
        
//        UIView *lin2View = [[UIView alloc] init];
//        lin2View.backgroundColor = MCUIColorLighttingBrown;
//        lin2View.frame = CGRectMake(kAdapterWith(50), 0, 0.5, 27);
//        [_sectionView addSubview:lin2View];
//
//        UIView *lin3View = [[UIView alloc] init];
//        lin3View.backgroundColor = MCUIColorLighttingBrown;
//        lin3View.frame = CGRectMake(CGRectGetMaxX(lin2View.frame) + kAdapterWith(200), 0, 0.5, 27);
//        [_sectionView addSubview:lin3View];
//
//        UIView *lin4View = [[UIView alloc] init];
//        lin4View.backgroundColor = MCUIColorLighttingBrown;
//        lin4View.frame = CGRectMake(MCScreenWidth - 46, 0, 0.5, 27);
//        [_sectionView addSubview:lin4View];
        
    }
    return _sectionView;
}

-(UIButton *)preiodButton{
    if (!_preiodButton) {
        self.preiodButton = [[UIButton alloc]init];
       
        [self.preiodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.preiodButton.titleLabel.font = MCFont(kAdapterFontSize(15));
        [self.preiodButton setTitle:@"5" forState:UIControlStateNormal];
        self.preiodButton.layer.masksToBounds = YES;
        self.preiodButton.layer.cornerRadius = 4;
        self.preiodButton.backgroundColor = MCUIColorMain;
        
        [self.preiodButton setContentEdgeInsets:UIEdgeInsetsMake(2, 8, 2, 8)];
        [self.preiodButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _preiodButton;
}

-(UILabel *)chasePreiodLabel{
    if (!_chasePreiodLabel) {
        
        self.chasePreiodLabel = [[UILabel alloc]init];
        self.chasePreiodLabel.font = MCFont(kAdapterFontSize(14));
        self.chasePreiodLabel.textColor = MCUIColorFromRGB(0x837B77);
        self.chasePreiodLabel.text = @"追号";
    }
    return _chasePreiodLabel;
}
-(UILabel *)chasePreiod2Label{
    if (!_chasePreiod2Label) {
        self.chasePreiod2Label = [[UILabel alloc]init];
        self.chasePreiod2Label.font = MCFont(kAdapterFontSize(14));
        self.chasePreiod2Label.textColor =  MCUIColorFromRGB(0x837B77);
        self.chasePreiod2Label.text = @"期";
    }
    return _chasePreiod2Label;
}

-(ChaseLotterTimeView *)timeView{
    if (!_timeView) {
        self.timeView = [[ChaseLotterTimeView alloc] initWithFrame:CGRectMake(0, 0, MCScreenWidth, 17)];
        self.timeView.distanceLabel.textAlignment = NSTextAlignmentCenter;
        self.timeView.backgroundColor = MCUIColorLighttingBrown;
        self.timeView.delegate = self;
        self.timeView.textColor = [UIColor blackColor];
    }
    return _timeView;
}

//追号倍数
-(UIButton *)timesButton{
    if (!_timesButton) {
        self.timesButton = [[UIButton alloc]init];

        
        [self.timesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.timesButton.titleLabel.font = MCFont(kAdapterFontSize(15));
        [self.timesButton setTitle:@"1" forState:UIControlStateNormal];
        self.timesButton.layer.masksToBounds = YES;
        self.timesButton.layer.cornerRadius = 4;
        self.timesButton.backgroundColor = MCUIColorMain;
        
        [self.timesButton setContentEdgeInsets:UIEdgeInsetsMake(2, 8, 2, 8)];
        [self.timesButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return _timesButton;
}
//隔多少期
-(UIButton *)modelButton{
    if (!_modelButton) {
        self.modelButton = [[UIButton alloc]init];
        [self.modelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.modelButton.titleLabel.font = MCFont(kAdapterFontSize(15));
        [self.modelButton setTitle:@"1" forState:UIControlStateNormal];
        self.modelButton.layer.masksToBounds = YES;
        self.modelButton.layer.cornerRadius = 4;
        self.modelButton.backgroundColor = MCUIColorMain;
        
        [self.modelButton setContentEdgeInsets:UIEdgeInsetsMake(2, 8, 2, 8)];
        [self.modelButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _modelButton;
}
-(UILabel *)modelLabel{
    if (!_modelLabel) {
        self.modelLabel = [[UILabel alloc]init];
        self.modelLabel.textColor =  MCUIColorFromRGB(0x837B77);
        self.modelLabel.font = MCFont(kAdapterFontSize(14));
        self.modelLabel.text = @"隔";
    }
    return _modelLabel;
}
//倍数
-(UIButton *)bonusButton{
    if (!_bonusButton) {
        self.bonusButton = [[UIButton alloc]init];
        [self.bonusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bonusButton.titleLabel.font = MCFont(kAdapterFontSize(15));
        [self.bonusButton setTitle:@"1" forState:UIControlStateNormal];
        self.bonusButton.layer.masksToBounds = YES;
        self.bonusButton.layer.cornerRadius = 4;
        self.bonusButton.backgroundColor = MCUIColorMain;
        
        [self.bonusButton setContentEdgeInsets:UIEdgeInsetsMake(2, 8, 2, 8)];
        [self.bonusButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bonusButton;
            
}
@end
