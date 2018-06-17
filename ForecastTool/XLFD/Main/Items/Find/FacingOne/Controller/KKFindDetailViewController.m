//
//  KKFindDetailViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/17.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindDetailViewController.h"
#import "KKFindDetailHeadView.h"
#import "KKFindTableViewCell.h"
#import "KKFindDetailInfoView.h"
#import "KKProgramViewController.h"
#import "KKGDInfoModel.h"
#import "KKFollowBetView.h"
#import "KKGDDetailModel.h"
#import "KKGDUserModel.h"
#import "KKFindMVPDetailViewController.h"
#import "KKFindDetailWinPopView.h"
#import "KKFindDetailPublicView.h"
@interface KKFindDetailViewController ()<KKFollowBetViewDelegate,KKFindDetailHeadViewDelegate>
@property(nonatomic,strong)KKFindDetailHeadView *headView;
@property(nonatomic,strong)KKFindDetailInfoView *infoView;
@property(nonatomic,strong)KKFindDetailPublicView *publicView;
//@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)KKGDInfoModel *gdInfoModel;
@property(nonatomic,strong)KKMVPPeopleModel *dsInfoModel;
@property(nonatomic,strong)NSMutableArray *gdDetailModelArray;
@property(nonatomic,strong)NSMutableArray *gdUserModelArray;
@property(nonatomic,strong)KKFollowBetView *betView;
@property(nonatomic,strong)KKProgramViewController *programVC;
@property(nonatomic,strong)UIView *containerView;
@property(assign,nonatomic)NSInteger selectIndex; //选择方案详情或者跟单用户
@end

@implementation KKFindDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self basicSetting];
    [self initUI];
      if ([MCTool BSGetUserinfo_token].length != 0) {
        [self sendUserInfoNetWorking];
    }
    
    [self sendNetWorking];
    
}


#pragma mark - UI布局
- (void)initUI {
    
    self.view.backgroundColor = MCUIColorFromRGB(0xF4F4F4);

    

    [self addSubViews];
}



-(void)addSubViews {
    
    
    
//    self.scrollView.backgroundColor = MCUIColorFromRGB(0xF4F4F4);
//
//
//    [self.scrollView setHidden:YES];
//    [self.view addSubview:self.scrollView];
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//
//    UIView* contentView = UIView.new;
//    [self.scrollView addSubview:contentView];
//
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scrollView);
//        make.width.equalTo(self.scrollView);
//    }];
    
    
    [self.view addSubview:self.headView];

    
    [self.headView setHidden:YES];
    [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(74));
    }];



    

    


    [self.view addSubview: self.infoView];
    [self.infoView setHidden:YES];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.headView.mas_bottom).offset(0);
    }];




    [self.view addSubview:self.publicView];
    [self.publicView setHidden:YES];
    [self.publicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.infoView.mas_bottom).offset(0);
    }];





    self.containerView = self.programVC.view;

        //3.添加到当前视图
    [self.view addSubview:self.containerView];
    [self.containerView setHidden:YES];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.publicView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(self.view).offset(-100);
    }];

    [self.view addSubview:self.betView];
//    [self.betView setHidden:YES];
    // self.betView.moneyTextField.text = [NSString stringWithFormat:@"%@",self.gdInfoModel.bet_min_money];
    [self.betView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);

        if(IS_IPHONE_X) {
            make.bottom.mas_equalTo(-34);
        }else{
            make.bottom.mas_equalTo(0);
        }


        make.height.mas_equalTo(100);
    }];
}


#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"跟单详情";
    self.selectIndex = 0;
}


#pragma mark - 网络请求
- (void)sendUserInfoNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/user-info"];
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        [self setIsShow404View:NO];
      
        NSString *balanceStr = [NSString stringWithFormat:@"您的余额:%@元",[data objectForKey:@"balance"]];
        self.betView.balanceLabel.text = balanceStr;
      
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/get-gd-detail"];

    NSDictionary * parameter = @{
                                 @"user_flag" : self.model.user_flag,
                                 @"gd_number" : self.model.gd_number,
                                 };
    
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
       
        self.dsInfoModel = [[KKMVPPeopleModel alloc] initWithDictionary:[data objectForKey:@"ds_info"] error:nil];
      
        
        self.gdInfoModel = [[KKGDInfoModel alloc] initWithDictionary:[data objectForKey:@"gd_info"] error:nil];
        
        self.gdDetailModelArray = [KKGDDetailModel arrayOfModelsFromDictionaries:[data objectForKey:@"gd_detail"] error:nil];

        self.gdUserModelArray = [KKGDUserModel arrayOfModelsFromDictionaries:[data objectForKey:@"gd_user"] error:nil];

        [self.headView buildWithData:self.dsInfoModel];
        [self.programVC buildData:self.gdDetailModelArray gdUserModelArray:self.gdUserModelArray findModel:self.model];
        [self.infoView buildWithData:self.gdInfoModel];
    
    
        [self.publicView buildWithData:self.gdInfoModel];
       // [self.scrollView setHidden:NO];
        
        [self isHiddBetView];

        for (UIView *view in self.view.subviews) {
            [view setHidden:NO];
        }
        
    } dislike:^(id data) {
        [self setIsShow404View:YES];
    } failure:^(NSError *error) {
        [self setIsShow404View:YES];
    }];
}


-(void)isHiddBetView{
    if (self.gdInfoModel.finish_status) {
        [self.betView removeFromSuperview];
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.publicView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.equalTo(self.view).offset(-10);
        }];
    }
}


-(void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self setIsShow404View:NO];
    [self sendNetWorking];
}


-(void)didClickBetButton:(KKFollowBetView *)view money:(NSString *)money {

   
    if ([money isEqualToString:@""]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请输入跟单金额" cancle:^{
            
        }];
        return;
    }
    
    
    
    if ([money componentsSeparatedByString:@"."].count > 2) {
        [MCView BSAlertController_oneOption_viewController:self message:@"请输入金额不合法" cancle:^{
            
        }];
        return;
    }
    
    
    
    if([MCTool BSJudge_userIsLoginWith:self]) {
      
        
        NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/bet/bet-gd"];
        NSDictionary * parameter = @{
                                     @"gd_number" : self.gdInfoModel.gd_number,
                                     @"gd_money" : @(money.floatValue),
                                     };
        [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:FALSE isShowTabbar:YES success:^(id data) {
            
            self.betView.moneyTextField.text = @"";
            [MCView BSAlertController_oneOption_viewController:self message:@"跟单成功" cancle:^{
                [self sendNetWorking];
                if ([MCTool BSJudge_userIsLoginWith:self]) {
                    [self sendUserInfoNetWorking];
                }
            }];
            
        } dislike:^(id data) {
            
            
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)didClickAvatarView:(KKFindDetailHeadView *)view {
  
    KKFindMVPDetailViewController *viewController = [[KKFindMVPDetailViewController alloc] init];

    viewController.model = self.dsInfoModel;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didClickAttention:(KKFindDetailHeadView *)view {
    if([MCTool BSJudge_userIsLoginWith:self]){
        
        KKMVPPeopleModel *model = (KKMVPPeopleModel *)self.dsInfoModel;
        
        //        user_token    true
        //        user_flag    true    对方用户名    test
        //        status    true    1关注2取消关注
        //has_gz    是否关注(0未关注1已关注3隐藏关注按钮)，登录状态下返回
        NSInteger status;
        
        if(model.has_gz.integerValue == 0) {
            status = 1;
        }else {
            status = 2;
        }
        
        
        NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/gd-dsb/gz"];
        NSDictionary * parameter = @{
                                     @"status" : @(status),
                                     @"user_flag" : model.user_flag
                                     };
        [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
            if(model.has_gz.integerValue == 0) {
                model.has_gz = [[NSNumber alloc] initWithInt:1];;
                model.count_fans++;
            }else {
                model.has_gz = [[NSNumber alloc] initWithInt:0];;
                model.count_fans--;
            }
            
            
            [self.headView buildWithData:model];
        } dislike:^(id data) {
            
            
        } failure:^(NSError *error) {
            
        }];
    }
}



#pragma mark - setter & getter

- (KKFindDetailHeadView *)headView {
    if (_headView == nil) {
        _headView = [[KKFindDetailHeadView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.delegate = self;
    }
    return _headView;
}

-(KKProgramViewController *)programVC {
    if (_programVC == nil) {
        _programVC = [[KKProgramViewController alloc] init];
       
    }
    return _programVC;
}
-(KKFindDetailPublicView *)publicView {
    if (_publicView == nil) {
        _publicView = [[KKFindDetailPublicView alloc] initWithFrame:CGRectZero];

        _publicView.backgroundColor = [UIColor clearColor];
    }
    return _publicView;
}
-(KKFollowBetView *)betView {
    if (_betView == nil) {
        _betView = [[KKFollowBetView alloc] init];
        _betView.delegate = self;
        _betView.backgroundColor = MCUIColorFromRGB(0xC7B7B4);
    }
    return _betView;
}
- (KKFindDetailInfoView *)infoView {
    if (_infoView == nil) {
        _infoView = [[KKFindDetailInfoView alloc] initWithFrame:CGRectZero];
        _infoView.backgroundColor = [UIColor clearColor];
    }
    return _infoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
