//
//  KKMessageDetailsView.m
//  Kingkong_ios
//
//  Created by hello on 2018/4/26.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMessageDetailsView.h"

@interface KKMessageDetailsView()
@property(nonatomic,weak)UIView * bgView;
@property(nonatomic,weak)UIView * whiteView;
@property(nonatomic,weak)UIView *viewLine;
@property(nonatomic,weak)UILabel *timelabel;
@property(nonatomic,weak)UIView *contentView;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UILabel *contentLabel;
@property(nonatomic,weak)UIButton *deleteButton;
@property(nonatomic,weak)UIButton *shutdownButton;
@end

@implementation KKMessageDetailsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    } return self;
}

#pragma mark 界面初始化
-(void)addSubviews{
    [self bgView];
    [self whiteView];
    
    [self titleLabel];
    [self viewLine];
    
    [self deleteButton];
    [self shutdownButton];
    
    [self contentView];
    [self timelabel];
    [self contentLabel];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _bgView = bgView;
    }
    return _bgView;
}

- (UIView *)whiteView {
    if (_whiteView == nil) {
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor =  [UIColor colorWithRed:244/255.0 green:235/255.0 blue:230/255.0 alpha:1/1.0];
        whiteView.layer.cornerRadius = 5;
        whiteView.layer.masksToBounds = YES;
        [self addSubview:whiteView];
      
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.height.equalTo(@300);
            make.center.equalTo(self);
            
        }];
        
        _whiteView = whiteView;
    }
    return _whiteView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"标题";
        titleLabel.numberOfLines = 2;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = MCFont(18);
        titleLabel.textColor = [UIColor colorWithRed:188/255.0 green:84/255.0 blue:84/255.0 alpha:1/1.0];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_whiteView);
            make.left.equalTo(_whiteView).offset(20);
            make.right.equalTo(_whiteView).offset(-20);
            make.height.equalTo(@60);
        }];
        
        _titleLabel = titleLabel;
    }
    
    return _titleLabel;
}

-(UIView *)viewLine{
    if (_viewLine == nil) {
        UIView *viewLine =  [[UIView alloc] init];
        viewLine.backgroundColor = MCUIColorLighttingBrown;
        [self addSubview:viewLine];
        
        [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(_whiteView);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.height.equalTo(@1);
        }];
        
        _viewLine = viewLine;
    }
    
    return _viewLine;
}

-(UIView *)contentView{
    if (_contentView == nil) {
        UIView *contentView  = [[UIView alloc]init];
        contentView.backgroundColor =   [UIColor colorWithRed:230/255.0 green:212/255.0 blue:206/255.0 alpha:1/1.0];
        contentView.layer.cornerRadius = 3;
        contentView.layer.masksToBounds = YES;
        [self addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewLine.mas_bottom).offset(20);
            make.left.equalTo(_whiteView).offset(20);
            make.right.equalTo(_whiteView).offset(-20);
            make.bottom.equalTo(_deleteButton.mas_top).offset(-20);
        }];
        
        _contentView = contentView;
    }
    
    return _contentView;
}

-(UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.text =@"内容";
        contentLabel.numberOfLines = 0;
        contentLabel.font = MCFont(16);
        contentLabel.textColor =  [UIColor colorWithRed:58/255.0 green:54/255.0 blue:52/255.0 alpha:1/1.0];
//        contentLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_contentView).offset(10);
            make.right.equalTo(_contentView).offset(-10);
            make.height.equalTo(@100);
        }];
        
        _contentLabel = contentLabel;
    }
    
    return _contentLabel;
}

-(UILabel *)timelabel{
    if (_timelabel == nil) {
        UILabel *timelabel = [[UILabel alloc]init];
        timelabel.text = _model.create_time;
        timelabel.font = MCFont(13);
        timelabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1/1.0];
        [self addSubview:timelabel];
        
        [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_contentView).offset(-10);
            make.right.equalTo(_contentView).offset(-10);
        }];
        
        _timelabel = timelabel;
    }
    
    return _timelabel;
}

-(UIButton *)deleteButton{
    if (_deleteButton == nil) {
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setBackgroundColor:[UIColor colorWithRed:188/255.0 green:84/255.0 blue:84/255.0 alpha:1/1.0]];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton.titleLabel setFont:MCFont(18)];
        deleteButton.layer.cornerRadius = 3;
        deleteButton.layer.masksToBounds = YES;
        [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_whiteView).offset(-20);
            make.bottom.equalTo(_whiteView.mas_bottom).offset(-20);
            make.height.equalTo(@35);
            make.width.equalTo(@80);
        }];
        
        _deleteButton = deleteButton;
        
    }
    return _deleteButton;
}

-(UIButton *)shutdownButton{
    if (_shutdownButton == nil) {
        UIButton *shutdownButton = [[UIButton alloc]init];
        [shutdownButton setBackgroundColor:MCUIColorMiddleGray];
        [shutdownButton setTitle:@"关闭" forState:UIControlStateNormal];
        [shutdownButton.titleLabel setFont:MCFont(18)];
        shutdownButton.layer.cornerRadius = 3;
        shutdownButton.layer.masksToBounds = YES;
        [shutdownButton addTarget:self action:@selector(clickShutdownButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shutdownButton];
        
        [shutdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_whiteView).offset(20);
            make.bottom.equalTo(_whiteView.mas_bottom).offset(-20);
            make.height.equalTo(@35);
            make.width.equalTo(@80);
        }];
        
        _shutdownButton = shutdownButton;
        
    }
    return _shutdownButton;
}

#pragma makr 点击事件
-(void)clickShutdownButton{
    [self removeSuperView];
}

-(void)clickDeleteButton{
    NSString *token = [MCTool BSGetUserinfo_token];
    if(token.length == 0){
        UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:nil message:@"消息删除需登录平台，是否登录？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        alertView.tag = 1;
        alertView.delegate = self;
        [alertView show];
    }else{
        UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:nil message:@"您确定要删除此条消息吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 2;
        alertView.delegate = self;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
            [self removeSuperView];
            self.loginClick();
        }else{
            [self deleteItem];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == _bgView){
        [self removeSuperView];
    }
}

-(void)removeSuperView{
    [UIView animateWithDuration:1.0 animations:^{
        [self removeFromSuperview];
    }];
    
}

//删除消息
-(void)deleteItem{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/message-handle"];
    
    NSString *token = [MCTool BSGetUserinfo_token];
    NSDictionary *  parameter =  @{@"user_token" : token,@"msg_id": _model.lottery_id,@"flag": @"2"};
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:@"消息已成功删除！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.deleteItemClick(_model);
            [self clickShutdownButton];
        });
    } dislike:^(id data) {} failure:^(NSError *error) {}];
}

//读取消息
-(void)readingItem{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/message-handle"];
    NSString *token = [MCTool BSGetUserinfo_token];
    if (token.length == 0) {
        return;
    }
    NSDictionary * parameter =  @{@"user_token" : token,@"msg_id": _model.lottery_id,@"flag": @"1"};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        self.readItemClick(_model);
    } dislike:^(id data) {} failure:^(NSError *error) {}];
}

-(void)setModel:(KKNotificationModel *)model{
    _model = model;
    _titleLabel.text = [NSString stringWithFormat:@"【%@】",_model.title];
    _timelabel.text = [NSString stringWithFormat:@"系统于%@寄出",_model.create_time];

    CGSize contentSize = [[NSString stringWithFormat:@"尊敬的会员：\n\n       %@",model.content] boundingRectWithSize:CGSizeMake(MCScreenWidth-120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MCFont(16)} context:nil].size;
    _contentLabel.text = [NSString stringWithFormat:@"尊敬的会员：\n\n       %@",_model.content];
    
    CGFloat hh = MCScreenHeight-120-(61+60+35+55);
    
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_contentView).offset(10);
        make.right.equalTo(_contentView).offset(-10);
        if (contentSize.height < hh) {
            make.height.equalTo(@(contentSize.height+1));
        }else{
            make.height.equalTo(@(hh));
        }
    }];
    
    [_whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        
        if (contentSize.height < hh) {
            make.height.equalTo(@(61+60+35+55+contentSize.height+1));
        }else{
            make.height.equalTo(@(61+60+35+55+hh));
        }
        
        make.center.equalTo(self);
    }];
    
    [self readingItem];
}

@end
