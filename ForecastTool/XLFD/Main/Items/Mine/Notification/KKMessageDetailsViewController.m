//
//  KKMessageDetailsViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/4/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKMessageDetailsViewController.h"

@interface KKMessageDetailsViewController ()
@property(nonatomic,weak)UILabel *timelabel;
@property(nonatomic,weak)UIView *contentView;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UILabel *contentLabel;
@property(nonatomic,weak)UIView *footView;
@property(nonatomic,weak)UIButton *deleteButton;
@property(nonatomic,weak)UIButton *shutdownButton;

@end

@implementation KKMessageDetailsViewController

-(void)setModel:(KKNotificationModel *)model{
    _model = model;
    _model.content = [NSString stringWithFormat:@"      %@",model.content];
    CGSize contentSize = [_model.content boundingRectWithSize:CGSizeMake(MCScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MCFont(17)} context:nil].size;
    _model.contentH = contentSize.height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self readingItem];
}

-(void)initView{
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"消息详情";
    
    [self timelabel];
    [self contentView];
    [self titleLabel];
    [self contentLabel];
    
    [self footView];
    
    [self deleteButton];
    [self shutdownButton];
}

-(UILabel *)timelabel{
    if (_timelabel == nil) {
        UILabel *timelabel = [[UILabel alloc]init];
        timelabel.text = _model.create_time;
        timelabel.font = MCFont(18);
        timelabel.textColor = MCUIColorGray;
        [self.view addSubview:timelabel];
        
        [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.height.equalTo(@50);
        }];
        
        _timelabel = timelabel;
    }
    
    return _timelabel;
}

-(UIView *)contentView{
    if (_contentView == nil) {
        UIView *contentView  = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 5;
        contentView.layer.masksToBounds = YES;
        [self.view addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timelabel.mas_bottom);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.height.equalTo(@(_model.contentH+50+20));
        }];
        
        _contentView = contentView;
    }
    
    return _contentView;
}


-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = _model.title;
        titleLabel.font = MCFont(17);
        titleLabel.textColor = MCUIColorGray;
        [self.view addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentView);
            make.left.equalTo(_contentView).offset(10);
            make.right.equalTo(_contentView).offset(-10);
            make.height.equalTo(@50);
        }];
        
        _titleLabel = titleLabel;
    }
    
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.text = _model.content;
        contentLabel.numberOfLines = 0;
        contentLabel.font = MCFont(17);
        contentLabel.textColor = MCUIColorMiddleGray;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.height.equalTo(@(_model.contentH));
        }];
        
        _contentLabel = contentLabel;
    }
    
    return _contentLabel;
}

-(UIView *)footView{
    if (_footView == nil) {
        UIView *footView  = [[UIView alloc]init];
        footView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:footView];
        
        [footView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@50);
        }];
        
        _footView = footView;
    }
    
    return _footView;
}

-(UIButton *)deleteButton{
    if (_deleteButton == nil) {
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setBackgroundColor:[UIColor redColor]];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton.titleLabel setFont:MCFont(14)];
        deleteButton.layer.cornerRadius = 3;
        deleteButton.layer.masksToBounds = YES;
        [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:deleteButton];
        
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(25);
            make.top.equalTo(_footView.mas_top).offset(10);
            make.bottom.equalTo(_footView.mas_bottom).offset(-10);
            make.width.equalTo(@60);
        }];
        
        _deleteButton = deleteButton;
        
    }
    return _deleteButton;
}

-(UIButton *)shutdownButton{
    if (_shutdownButton == nil) {
        UIButton *shutdownButton = [[UIButton alloc]init];
        [shutdownButton setBackgroundColor:MCUIColorBrown];
        [shutdownButton setTitle:@"关闭" forState:UIControlStateNormal];
        [shutdownButton.titleLabel setFont:MCFont(14)];
        shutdownButton.layer.cornerRadius = 3;
        shutdownButton.layer.masksToBounds = YES;
        [shutdownButton addTarget:self action:@selector(clickShutdownButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shutdownButton];
        
        [shutdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-25);
            make.top.equalTo(_footView.mas_top).offset(10);
            make.bottom.equalTo(_footView.mas_bottom).offset(-10);
            make.width.equalTo(@60);
        }];
        
        _shutdownButton = shutdownButton;
        
    }
    return _shutdownButton;
}

#pragma makr 点击事件
-(void)clickShutdownButton{
    [self.navigationController popViewControllerAnimated:YES];
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
            KKLoginViewController *login = [[KKLoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }else{
            [self deleteItem];
        }
    }
}

//删除消息
-(void)deleteItem{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/message-handle"];
    
    NSString *token = [MCTool BSGetUserinfo_token];
    NSDictionary *  parameter =  @{@"user_token" : token,@"msg_id": _model.lottery_id,@"flag": @"2"};
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"消息已成功删除！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.deleteItemClick(_model);
            [self clickShutdownButton];
        });
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

//读取消息
-(void)readingItem{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/message-handle"];
    NSString *token = [MCTool BSGetUserinfo_token];
    if (token.length == 0) {
        return;
    }
    NSDictionary *  parameter =  @{@"user_token" : token,@"msg_id": _model.lottery_id,@"flag": @"1"};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        self.readItemClick(_model);
    } dislike:^(id data) {} failure:^(NSError *error) {}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
