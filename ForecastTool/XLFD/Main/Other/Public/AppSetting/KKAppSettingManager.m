//
//  AppSettingManager.m
//  
//
//  Created by hello on 2018/3/8.
//

#import "KKAppSettingManager.h"
#import "MCTabbarController.h"
#import "KKLocationManager.h"
#import "XXHomeViewController.h"
#import "XXLBaseNavigationController.h"

@implementation KKAppSettingManager

+(void)appSetting{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self tabBarViewControllerSetting];
    
}



+(void)getLanguageSetting{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LanguageSetting"];
//    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"/v2/app-charge-url/get-globalization-set"];
//
//    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:nil isShowHUD:NO isShowTabbar:nil success:^(id data) {
//
//        NSDictionary *dict = data;
//        BOOL isEn = [dict[@"is_english"] integerValue];
//        [[NSUserDefaults standardUserDefaults] setBool:!isEn forKey:@"LanguageSetting"];
//
        [self activityVCStateSetting];
//    } dislike:^(id data) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LanguageSetting"];
//        [self activityVCStateSetting];
//    } failure:^(NSError *error) {
//
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LanguageSetting"];
//        [self activityVCStateSetting];
//    }];
}

+(void)tabBarViewControllerSetting{
    
    //因为打开app后 需要请求服务器判断是否添加活动页面 系统自带的lunchImage会加载完成而消失 这时候会出现黑屏 为了作为缓冲界面所以添加了一个VC 在上面加上lunchImage的图片 等到数据返回再移除
    UIImageView *lunchImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    lunchImageView.image = [self getLaunchImage];
    UIViewController *vc = [UIViewController new];
    [vc.view addSubview:lunchImageView];
    [[UIApplication sharedApplication].keyWindow setRootViewController:vc];
    
    BOOL status = [self appOpenTest];
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"tabBarViewControllerSettingKey"];
    if(!KK_STATUS){
        [self appUpload];
        [self getLanguageSetting];
        [self judgeRedEnvelope];
    }else{
        [self setting_mainViewController];
    }
}

+(BOOL)appOpenTest{
    NSInteger num = 0;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Sinaweibo://"]]) {
        //新浪微博
        NSLog(@"安装了新浪微博");
        num++;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        //qq
        NSLog(@"安装了QQ");
        num++;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqzone://"]]) {
        //qq
        NSLog(@"安装了QQ空间");
        num++;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        //微信
        NSLog(@"安装了WX");
        num++;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
        //支付宝
        NSLog(@"安装了支付宝");
        num++;
    }
    return num == 0;
}

#pragma mark app更新
+(void)appUpload{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"app/check-update"];
    NSDictionary * parameter = @{
                                 @"device_type" : @"ios",
                                 @"version_code": kAPP_Version,
                                 @"app_pac_name": kAPP_BundleId
                                 };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:nil isShowHUD:NO isShowTabbar:YES success:^(id data) {
        if ([data[@"is_update"] integerValue] == 1) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本:%@",data[@"version_code"]] message:data[@"info"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data[@"download_url"]]];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:libraryAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    } dislike:^(id data) {
    } failure:^(NSError *error) {
    }];
}

#pragma mark 判断是否开启活动页面
+(void)activityVCStateSetting{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"/v2/app-pac-version/get-set"];
    NSDictionary * parameter = @{
                                 @"type" : @"type_huodong",
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:[MCTool getCurrentVC] isShowHUD:NO isShowTabbar:YES success:^(id data) {
        NSDictionary *dataDic = data;
        [MCTool BSSetObject:[NSString stringWithFormat:@"%@",dataDic[@"on_off"]] forKey:BSActivityViewControllerState];
        
        [self setting_rootViewController];

    } dislike:^(id data) {
        [MCTool BSSetObject:@(0) forKey:BSActivityViewControllerState];
        [self setting_rootViewController];
        NSLog(@"%@",data);

    } failure:^(NSError *error) {

        [MCTool BSSetObject:@(0) forKey:BSActivityViewControllerState];
        [self setting_rootViewController];
    }];
}

+ (UIImage *)getLaunchImage
{
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    UIWindow *currentWindow = [[UIApplication sharedApplication].windows firstObject];
    CGSize viewSize = currentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImageName];
}

#pragma mark 设置TabBarViewController
+ (void)setting_rootViewController {
    MCTabbarController * tabbar = [[MCTabbarController alloc] init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:tabbar];
    [[KKLocationManager shareManager] getLocationInfor];
}

+ (void)setting_mainViewController{
    XXHomeViewController *home = [XXHomeViewController new];
    XXLBaseNavigationController *navigationVC = [[XXLBaseNavigationController alloc]initWithRootViewController:home];
    [[UIApplication sharedApplication].keyWindow setRootViewController:navigationVC];
}

#pragma mark 判断是否有红包
+ (void) judgeRedEnvelope {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"v2/app-pac-version/get-set"];
    NSDictionary *param = @{@"type": @"type_hongbao"};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:[MCTool getCurrentVC] isShowHUD:NO isShowTabbar:YES success:^(id data) {
        
        NSMutableDictionary *redEnvelopeDict = (NSMutableDictionary *)data;
        [MCTool BSSetObject:redEnvelopeDict forKey:BSLuckyMoneyState];
        
    } dislike:^(id data) {
    } failure:^(NSError *error) {
    }];
}

@end
