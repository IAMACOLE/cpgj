//
//  KeyBoardView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/12.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KeyBoardView.h"
@interface KeyBoardView()
@property(nonatomic,strong)UIView *backGroundView;
@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong) UIButton *cancelButton;
@property(nonatomic,strong) UIView *multipleView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic ,strong) UIView *bottomView;
@end
@implementation KeyBoardView
static float buttonHeight = 52;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [self addSubview:self.backGroundView];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView).with.offset(0);
        make.top.mas_equalTo(self.bottomView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth, buttonHeight));
    }];
    [self.headView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView).with.offset(11);
        make.top.mas_equalTo(self.headView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.headView addSubview:self.timeLabel];
   
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.headView.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.headView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    [self.headView addSubview:self.countTextField];
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.headView).with.offset(11);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"投";
    label1.font = MCFont(21);
    label1.textColor = MCUIColorMiddleGray;
    [self.headView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countTextField.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.headView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    [self.bottomView addSubview:self.multipleView];
    [self.multipleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView).with.offset(0);
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth, buttonHeight));
    }];

    NSArray *array = @[@[@"1",@"2",@"3"],@[@"4",@"5",@"6"],@[@"7",@"8",@"9"],@[@"0",@"+1",@"-1"]];
    for (int i = 0; i<array.count; i++) {
        for (int j =0; j<[array[i] count]; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(j*(MCScreenWidth-63)/3, (buttonHeight*2+10)+i*buttonHeight,(MCScreenWidth-63)/3-1 , buttonHeight-1)];
            [btn setTitle:array[i][j] forState:UIControlStateNormal];
            [btn setTitleColor:MCUIColorGray forState:UIControlStateNormal];
            btn.titleLabel.font = MCFont(16);
            [btn addTarget:self action:@selector(keyBoardClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor whiteColor];
            btn.tag = 100 + i*3 +j;
            [self.bottomView addSubview:btn];
        }
    }
    NSArray *cancelArray = @[@"删除",@"确定"];
    for (int i =0; i<cancelArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(MCScreenWidth-63, (buttonHeight*2+10)+i*buttonHeight*2, 63, buttonHeight*2)];
        [btn setTitle:cancelArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = MCFont(18);
        btn.tag = 1000+i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (i==0) {
            btn.backgroundColor = MCUIColorMiddleGray;
        }else{
            btn.backgroundColor = MCUIColorMain;
        }
        [btn addTarget:self action:@selector(sureAndCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:btn];
    }
}
-(void)setTimesOrPreiod:(NSString *)str{
    NSArray *multipleArr = @[@"1",@"2",@"5",@"10",@"20"];
    self.timeLabel.text = str;
    for (int i =0; i<multipleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*MCScreenWidth/5, 0, MCScreenWidth/5-1, buttonHeight)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:MCUIColorGray forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@%@",multipleArr[i],str] forState:UIControlStateNormal];
        btn.titleLabel.font = MCFont(15);
        btn.tag = 500+i;
        [btn addTarget:self action:@selector(multipleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.multipleView addSubview:btn];
    }
}
-(void)sureAndCancel:(UIButton *)sender{
    NSInteger index = sender.tag-1000;
    
    switch (index) {
        case 0:
            if (self.countTextField.text.length == 0) {
                return;
            }
            self.countTextField.text = [self.countTextField.text substringToIndex:self.countTextField.text.length-1];
            break;
          case 1:
            if (self.delegate &&[_delegate respondsToSelector:@selector(KeyBoardViewSureClick:)]) {
                [self.delegate KeyBoardViewSureClick:self.countTextField.text];
            }
            [self hideKeyBoardView];
            break;
        default:
            break;
    }
}
-(void)keyBoardClick:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    NSInteger text = [self.countTextField.text integerValue];
    switch (index) {
        case 10:
            text ++;
            if (text > BigBettingRate) {
                self.countTextField.text = [NSString stringWithFormat:@"%d",BigBettingRate];
            }else{
               self.countTextField.text = [NSString stringWithFormat:@"%ld",text];
            }
            break;
         case 11:
            text--;
            if (text == 0) {
                return;
            }
            self.countTextField.text = [NSString stringWithFormat:@"%ld",text];
            break;
            case 9:
            if (text == 0) {
                self.countTextField.text = [NSString stringWithFormat:@"%d",0];
            }else{
                self.countTextField.text = [NSString stringWithFormat:@"%ld%d",text,0];
                if ([self.countTextField.text integerValue] > BigBettingRate) {
                    self.countTextField.text = [NSString stringWithFormat:@"%d",BigBettingRate];
                }
            }

            break;
        default:
            if (text == 0) {
                self.countTextField.text = [NSString stringWithFormat:@"%ld",index+1];
            }else{
                self.countTextField.text = [NSString stringWithFormat:@"%ld%ld",text,index+1];
                if ([self.countTextField.text integerValue] > BigBettingRate) {
                    self.countTextField.text = [NSString stringWithFormat:@"%d",BigBettingRate];
                }
            }

            break;
    }
 
    
    
}
-(void)multipleClick:(UIButton *)sender{
    NSInteger index = sender.tag-500;
    switch (index) {
        case 0:
            self.countTextField.text = @"1";
            break;
          case 1:
            self.countTextField.text = @"2";
            break;
            case 2:
            self.countTextField.text = @"5";
            break;
            case 3:
            self.countTextField.text = @"10";
            break;
            case 4:
            self.countTextField.text = @"20";
            break;
        default:
            break;
    }
}
-(void)hideKeyBoardView{
    self.backGroundView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, MCScreenHeight-buttonHeight*6-20, MCScreenWidth, MCScreenHeight);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });

    }];

}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]init];
        self.cancelButton.layer.borderColor = MCUIColorMiddleGray.CGColor;
        self.cancelButton.layer.borderWidth = 1;
        self.cancelButton.layer.cornerRadius = 4;
        [self.cancelButton setImage:[UIImage imageNamed:@"Home_HideView"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(hideKeyBoardView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
-(UIView *)backGroundView{
    if (!_backGroundView) {
        self.backGroundView = [[UIView alloc]initWithFrame:self.frame];
        self.backGroundView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoardView)];
        self.backGroundView.userInteractionEnabled = YES;
        [self.backGroundView addGestureRecognizer:tap];
        self.backGroundView.alpha = 0.4;
    }
    return _backGroundView;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"倍";
        _timeLabel.font = MCFont(21);
        _timeLabel.textColor = MCUIColorMiddleGray;
    }
    return _timeLabel;
}
-(UIView *)multipleView{
    if (!_multipleView) {
        self.multipleView = [[UIView alloc]initWithFrame:self.frame];
        self.multipleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
       
    }
    return _multipleView;
}
-(UIView *)headView{
    if (!_headView) {
        self.headView = [[UIView alloc]init];
        self.headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}
-(UITextField *)countTextField{
    if (!_countTextField) {
        self.countTextField = [[UITextField alloc]init];
        self.countTextField.layer.cornerRadius = 4;
        self.countTextField.clipsToBounds = YES;
        self.countTextField.userInteractionEnabled = NO;
        self.countTextField.layer.borderWidth = 1;
        self.countTextField.font = [UIFont systemFontOfSize:14];
        self.countTextField.adjustsFontSizeToFitWidth = YES;
        self.countTextField.textAlignment = NSTextAlignmentCenter;
        self.countTextField.layer.borderColor = MCUIColorMiddleGray.CGColor;
        self.countTextField.backgroundColor = [UIColor colorWithRed:249/256.0 green:250/256.0 blue:248/256.0 alpha:1];
    }
    return _countTextField;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MCScreenHeight-buttonHeight*6-20, MCScreenWidth, buttonHeight*6+10)];
        self.bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bottomView;
}

@end
