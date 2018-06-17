//
//  KKRechargeViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/3/31.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKRechargeViewController.h"
#import "KKRechargeHeadView.h"
#import "KKRechargeFooterView.h"
#import "KKPayTypeView.h"
#import "KKBalanceManager.h"
#import "PayModel.h"
#import "IAPHelper.h"
#import "KKRechargePromptViewController.h"
#import "KKRechargeMoneyView.h"
#import "IAPShare.h"
#import "KKPayTypeTabelViewCell.h"
#import "KKPayChannelModel.h"
#import "KKInReViewRechargeView.h"
#import "KKNativeRechargeView.h"
#import "KKAppSettingManager.h"

#define NAME_KEY   @"NAME_KEY"
#define IMAGE_KEY  @"IMAGE_KEY"
#define SELECT_KEY @"SELECT_KEY"
#define SELECTSTATUS @"1"
#define NORMALSTATUS @"0"
@interface KKRechargeViewController ()<UIWebViewDelegate>
{
    NSInteger _isFirstShow;
    UIWebView * _webView;
}
//headView
@property (assign, nonatomic)NSInteger moneyTpyeIndex;
@property(nonatomic ,strong)UIImageView * emptyImageView;
@property(nonatomic ,strong)UIButton * loginButton;
@property(nonatomic, assign)BOOL isOnOrOff;
@property(nonatomic, copy)NSString *payUrl;
@property (nonatomic, strong)NSMutableArray *payChannelArray;
@property (nonatomic, strong)KKInReViewRechargeView *inReView;
@property (nonatomic, strong)KKNativeRechargeView *nativeView;
@end

@implementation KKRechargeViewController

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if([KKAppSettingManager appOpenTest]){
//        self.isOnOrOff = NO;
//        [self initUI];
//    }else{
//       [self sendNetWorking];
//    }
    
    self.isOnOrOff = [KKAppSettingManager appOpenTest];
    [self initUI];
    if(!self.isOnOrOff){
        [self getUrl];
    }
    
//    if(self.isOnOrOff){
//        if(self.nativeView){
//            WeakObject(self);
//            [KKBalanceManager getBalance:^(NSString *balance) {
//                weakObject.nativeView.balance = balance;
//            }];
//        }
//    }
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
}

- (void)loadNotLoginUI {

    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self.view addSubview:self.bgImageView];
    self.bgImageView.image = [UIImage imageNamed:@"bgImageView_Image1"];
    if(self.isFirstVC && IS_IPHONE_X){
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-30);
        }];
        UIImageView *imageView = [UIImageView new];
        [self.view addSubview:imageView];
        imageView.backgroundColor = MCUIColorFromRGB(0x272522);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
            
        }];
    }else{
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
    }
    
    [self.view addSubview:self.emptyImageView];
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.emptyImageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 35));
    }];
}

- (void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self sendNetWorking];
}

#pragma mark - 点击事件
- (void)rightItemClicked {

    KKRechargePromptViewController * prompt = [[KKRechargePromptViewController alloc] init];
    [self.navigationController pushViewController:prompt animated:YES];

}

- (void)loginButtonClicked {
    KKLoginViewController * vc = [[KKLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma mark - 网络请求
- (void)sendNetWorking {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"/v2/app-pac-version/get-set"];
    
    NSDictionary * parameter = @{
                                 @"type": @"type_charge"
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:YES success:^(id data) {
        NSDictionary *dataDict = data;
        self.isOnOrOff = YES;
        self.payUrl = dataDict[@"url"];
        self.payChannelArray = [KKPayChannelModel arrayOfModelsFromDictionaries:dataDict[@"charge_channel_list"] error:nil];
        [self initUI];
    } dislike:^(id data) {
        [self initUI];
    } failure:^(NSError *error) {
        [self initUI];
    }];

}


-(void)getUrl{
    NSString * token = [MCTool BSGetUserinfo_token];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/app-charge-url/get-charge-url"];
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSDictionary *dict = data;
        NSString *url = [NSString stringWithFormat:@"%@?user_token=%@",dict[@"url"],token];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.titleString = @"充值";
    
    self.navigationItem.leftBarButtonItem = self.customLeftItem;

    self.moneyTpyeIndex = 0;
    [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(22, 22) target:self selected:@selector(rightItemClicked) image:@"icon-buttonitem-wenhao" isLeft:NO];
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MCView BSMBProgressHUD_bufferAndTextWithView:self.view andText:@"正在为您加载\n请耐心等候..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MCView BSMBProgressHUD_hideWith:self.view];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    // h5 加载失败
    [MCView BSMBProgressHUD_hideWith:self.view];
    NSString *errorString = error.userInfo[@"NSErrorFailingURLKey"];
    if([errorString containsString:@"alipay://alipayclient/"]){
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"网络错误"];
    }else{
        [self setIsShow404View:YES];
    }
}

#pragma mark - UI布局
- (void)initUI {

    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length == 0) {
        [self loadNotLoginUI];
    } else {
        

        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
        }
        [self.view addSubview:self.bgImageView];
        self.bgImageView.image = [UIImage imageNamed:@"bgImageView_Image1"];
        if(self.isFirstVC && IS_IPHONE_X){
            [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.bottom.mas_equalTo(-30);
            }];
            UIImageView *imageView = [UIImageView new];
            [self.view addSubview:imageView];
            imageView.backgroundColor = MCUIColorFromRGB(0x272522);
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(30);
                
            }];
        }else{
            [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.mas_equalTo(0);
            }];
        }
        
        if (self.isOnOrOff) {
            [self.view addSubview:self.inReView];
            [self.inReView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
            }];
        }else{
            //1.创建containerView目标控制器
            _webView = [UIWebView new];
            [self.view addSubview:_webView];
//            self.nativeView.payChannelArray = self.payChannelArray;
            _webView.delegate = self;
            [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                 if(self.isFirstVC && IS_IPHONE_X){
                     make.bottom.mas_equalTo(-49-40);
                 }else{
                     make.bottom.mas_equalTo(-49);
                 }
                
            }];
            
        }
    }
}

-(KKNativeRechargeView *)nativeView {
    if (_nativeView== nil) {
        _nativeView = [[KKNativeRechargeView alloc] init];
        _nativeView.backgroundColor = [UIColor clearColor];
    }
    return _nativeView;
}
-(KKInReViewRechargeView *)inReView {
    if (_inReView== nil) {
        _inReView = [[KKInReViewRechargeView alloc] init];
        _inReView.backgroundColor = [UIColor clearColor];
    }
    return _inReView;
}


- (UIImageView *)emptyImageView {
    if (_emptyImageView == nil) {
        self.emptyImageView = [[UIImageView alloc] init];
        self.emptyImageView.image = [UIImage imageNamed:@"Reuse_empty"];
    }   return _emptyImageView;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginButton.layer.cornerRadius = 3;
        self.loginButton.layer.masksToBounds = true;
        self.loginButton.layer.borderColor = MCUIColorMain.CGColor;
        self.loginButton.layer.borderWidth = 1;
        self.loginButton.titleLabel.font = MCFont(15);
        [self.loginButton setTitle:@"请登录后再充值" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } return _loginButton;
}
-(NSMutableArray *)payChannelArray {
    if (_payChannelArray == nil) {
        _payChannelArray = [[NSMutableArray alloc] init];
    }
    return _payChannelArray;
}

@end
