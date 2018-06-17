//
//  SignInView.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "SignInView.h"
#import "KKNewMemberViewManager.h"

@interface SignInView()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *signInImageView;
@property (nonatomic, strong) UIImageView *goldImageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *signInButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, copy) NSString *memberUrl;
@property (nonatomic, assign) BOOL isNewMember;

@end

@implementation SignInView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [KKNewMemberViewManager checkUserisNewMember:^(BOOL isNew, NSString *url) {
            self.isNewMember = isNew;
            self.memberUrl = url;
        }];
    }
    return self;
}

- (void)newMemberActivityAction{
    if(self.isNewMember){
        [MCView BSAlertController_twoOptions_viewController:[MCTool getCurrentVC] message:@"您还有一份开户礼金未领取" confirmTitle:@"确定" cancelTitle:@"取消" confirm:^{
            MCH5ViewController *h5VC = [MCH5ViewController new];
            h5VC.url = self.memberUrl;
            [[MCTool getCurrentVC].navigationController pushViewController:h5VC animated:YES];
        } cancle:^{
            
        }];
    }
}

- (void)configUI {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self addSubview:self.signInImageView];
    [self.signInImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth * 3/4, MCScreenWidth * 3/4));
    }];
    
    
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.signInImageView.mas_top).offset(kAdapterFontSize(-15));
        make.right.equalTo(self).offset(kAdapterFontSize(-50));
        make.size.mas_equalTo(CGSizeMake(kAdapterFontSize(30), kAdapterFontSize(30)));
    }];
    
    [self addSubview:self.signInButton];
    [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.signInImageView);
        make.top.mas_equalTo(self.signInImageView.mas_bottom).offset(kAdapterFontSize(-40));
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth * 1/2, kAdapterFontSize(50)));
    }];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }
    return _bgView;
}

- (UIImageView *)signInImageView {
    if (_signInImageView == nil) {
        _signInImageView = [[UIImageView alloc] init];
        _signInImageView.image = [UIImage imageNamed:@"签到"];
        _signInImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _signInImageView;
}

- (UIImageView *)goldImageView {
    if (_goldImageView == nil) {
        _goldImageView = [[UIImageView alloc] init];
        _goldImageView.image = [UIImage imageNamed:@"签到红包"];
        _goldImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goldImageView;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        _closeButton.imageView.contentMode = UIViewContentModeScaleToFill;
        _closeButton.adjustsImageWhenHighlighted = NO;
        [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)signInButton {
    if (_signInButton == nil) {
        _signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signInButton setImage:[UIImage imageNamed:@"立即签到"] forState:UIControlStateNormal];
        _signInButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _signInButton.adjustsImageWhenHighlighted = NO;
        [_signInButton addTarget:self action:@selector(signButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signInButton;
}

- (UIButton *)sureButton {
    if (_sureButton == nil) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        _sureButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _sureButton.adjustsImageWhenHighlighted = NO;
        [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UILabel *)infoLabel {
    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.numberOfLines = 0;
		_infoLabel.font = [UIFont fontWithName:@"Menlo-Bold" size:kAdapterFontSize(24)];
        _infoLabel.textColor = [UIColor whiteColor];
        [_infoLabel sizeToFit];
    }
    return _infoLabel;
}

-(void)closeButtonClick {
    [self closeView];
}

-(void)signButtonClick {
    [self.signInButton setUserInteractionEnabled:NO];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/activity/user-sign"];
    NSDictionary *param = @{};
    [self BSNetWork_postWithUrl:urlStr parameters:param andViewController:nil success:^(id data) {
        NSDictionary *dataDict = (NSDictionary *)data;
        NSString *message = dataDict[@"errorMsg"];
        if (message.length > 0) {
            [self closeView];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [[MCTool getCurrentVC] presentViewController:alert animated:YES completion:^{
                
            }];
            return;
        }
        NSNumber *money = [dataDict objectForKey:@"receive_money"];
        [self receiveSuccessWithMoney:[money doubleValue]];
    } error:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self andText:data];
        [self.signInButton setUserInteractionEnabled:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

-(void)sureButtonClick {
    [self closeView];
}

- (void)closeView {
    [self newMemberActivityAction];
    [self removeFromSuperview];
}

- (void)receiveSuccessWithMoney:(double)money {
    [self.signInImageView removeFromSuperview];
    [self.signInButton removeFromSuperview];
    [self.closeButton removeFromSuperview];
	[self.bgView addSubview:self.goldImageView];
	[self.goldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self);
		make.centerY.equalTo(self).offset(kAdapterFontSize(-10));
		make.size.mas_equalTo(CGSizeMake(MCScreenWidth * 4/5, MCScreenWidth * 4/5));
	}];
    [self.bgView addSubview:self.infoLabel];
    NSString *textContent = [NSString stringWithFormat:@"恭喜您！\n获得%.2f元", money];
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:textContent];
    [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:236/255.0 blue:0/255.0 alpha:1.0] range:NSMakeRange(0, [textContent length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];//调整行间距
    [titleStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textContent length])];
    self.infoLabel.attributedText = titleStr;
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(MCScreenWidth / 2);
    }];
	
    [self.bgView addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goldImageView.mas_bottom).offset(kAdapterFontSize(10));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MCScreenWidth/ 2, kAdapterFontSize(50)));
    }];
    [self.bgView addSubview:self.closeButton];
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goldImageView.mas_top).offset(kAdapterFontSize(20));
        make.right.equalTo(self).offset(kAdapterFontSize(-80));
        make.size.mas_equalTo(CGSizeMake(kAdapterFontSize(30), kAdapterFontSize(30)));
    }];
}

- (void)BSNetWork_postWithUrl:(NSString *)url parameters:(id)dict andViewController:(UIViewController *)viewController success:(SuccessBlock)successBlock error:(ErrorMessageDealBlock)errorDealBlock failure:(FailureBlock)failureBlock {

    NSMutableDictionary * originDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    [originDictM setObject:@"2" forKey:@"platform"];   // 2 代表ios
    
    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        [originDictM setObject:token forKey:@"user_token"];
    }
    
    NSArray * allKeys = [originDictM allKeys];
    NSArray *sortKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString * sign = [NSMutableString string];
    for (NSString * str in sortKeys) {
        NSString * value = originDictM[str];
        NSString * needStr = [NSString stringWithFormat:@"%@=%@",str,value];
        if (sign.length > 0) {
            [sign appendFormat:@"&"];
        }
        [sign appendFormat:@"%@",needStr];
    }
    
    // 判断是否登录,或者登录返回的md5_salt,没登录用默认的default_key = fb2356ddf5scc5d4d2s9e@2scwu7io2c
    if ([MCTool BSGetUserinfo_salt] == nil) {
        [sign appendFormat:@"%@",@"fb2356ddf5scc5d4d2s9e@2scwu7io2c"];
    } else {
        [sign appendFormat:@"%@",[MCTool BSGetUserinfo_salt]];
        //    NSLog(@"登录之后私钥: %@",[MCTool BSGetUserinfo_salt]);
    }
    
    [originDictM setObject:[sign md5Encrypt] forKey:@"sign"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = 10;
    
    
    
    [manager POST:url parameters:originDictM progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        // 抛出异常,看情况处理.
        failureBlock(error);
    }];
}

@end
