//
//  MCTool.m
//  BuBuBa
//
//  Created by goulela on 16/5/19.
//  Copyright © 2016年 bububa. All rights reserved.
//

#import "MCTool.h"
#import <sys/utsname.h>
#import "KKAbnormalNetworkView.h"

#define MCUserDefaults [NSUserDefaults standardUserDefaults]

@implementation MCTool

#pragma mark - UserDefault
+ (void)BSSetObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
    [userDefaults synchronize];
}
+ (id)BSGetObjectForKey:(NSString *)key {
    return [MCUserDefaults objectForKey:key];
}
+ (void)BSRemoveObjectforKey:(NSString *)key {
    [MCUserDefaults removeObjectForKey:key];
    [MCUserDefaults synchronize];
}

#pragma mark - 获取内购包名
+ (NSMutableArray *)getIAPsBundleId {
    
    
    NSMutableArray *ids = [NSMutableArray arrayWithCapacity:5];
    
    for (NSString *idStr in KIAP_Array) {
        [ids addObject:[NSString stringWithFormat:@"%@.%@",kAPP_BundleId,idStr]];
    }
    
    return ids;
}


#pragma mark - 用户信息
+ (NSString *)getDevice {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone5,2"])
    return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])
    return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])
    return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])
    return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])
    return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])
    return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])
    return@"iPhone 6,6s,7,8";
    
    if([platform isEqualToString:@"iPhone8,1"])
    return@"iPhone 6,6s,7,8";
    
    if([platform isEqualToString:@"iPhone8,2"])
    return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])
    return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])
    return@"iPhone 6,6s,7,8";
    
    if([platform isEqualToString:@"iPhone9,2"])
    return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])
    return@"iPhone 6,6s,7,8";
    
    if([platform isEqualToString:@"iPhone10,4"])
    return@"iPhone 6,6s,7,8";
    
    if([platform isEqualToString:@"iPhone10,2"])
    return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])
    return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])
    return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])
    return@"iPhone X";
    
    return @"模拟器";
}

+ (NSString *)BSGetUserinfo_token {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    NSString * token = userinfoDict[BSUserinfo_token];
    
    if (!token) {
        token = @"";
    }
    return token;
}

+ (NSString *)BSGetUserinfo_salt {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    NSString * salt = userinfoDict[BSUserinfo_md5_salt];
    return salt;
}


+ (NSString *)BSGetUserinfo_userId {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    NSString * userId = userinfoDict[BSUserinfo_userId];
    return userId;
}

+ (NSString *)BSGetUserinfo_nick_name {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    NSString * nick_name = userinfoDict[BSUserinfo_nick_name];
    return nick_name;
}


+ (NSString *)BSGetUserinfo_imageUrl {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    NSString * url = userinfoDict[BSUserinfo_image_url];
    return url;
}

+ (BOOL)BSGetUserinfo_bank_status {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    BOOL bank_status = [userinfoDict[BSUserinfo_bank_status] integerValue];
    return bank_status;
}

+ (BOOL)BSGetUserinfo_password_status {
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    BOOL password_status =  kStringIsEmpty(userinfoDict[BSUserinfo_password_status]) ? YES :  [userinfoDict[BSUserinfo_password_status] integerValue];
    return password_status;
}

+ (BOOL)BSGetBank_passwd_status{
    NSDictionary * userinfoDict = [MCTool BSGetObjectForKey:BSUserinfo];
    BOOL bank_passwd_status =  kStringIsEmpty(userinfoDict[BSbank_passwd_status]) ? YES :  [userinfoDict[BSbank_passwd_status] integerValue];
    return bank_passwd_status;
}

#pragma mark - 返回颜色图片
+(UIImage*) imageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



#pragma mark - 网络请求(外部只处理成功的情况)
+ (void)BSNetWork_postWithUrl:(NSString *)url parameters:(id)dict andViewController:(UIViewController *)viewController isShowHUD:(BOOL)isShowHUD isShowTabbar:(BOOL)isShowTabbar success:(SuccessBlock)successBlock dislike:(DislikeBlock)dislikeBlock failure:(FailureBlock)failureBlock {

    if (isShowHUD) {
        [MCView BSMBProgressHUD_bufferAndTextWithView:[self BSGetCurrentViewWith:viewController] andText:nil];
    }
    
    if (dict == nil) {
        dict = @{};
    }
    
    NSMutableDictionary * originDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    [originDictM setObject:@"2" forKey:@"platform"];   // 2 代表ios
    
    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        [originDictM setObject:token forKey:@"user_token"];
    }
    //包名和版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_bundleId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [originDictM setObject:app_bundleId forKey:@"app_bundleId"];
    [originDictM setObject:app_version forKey:@"app_version"];
    
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
    }
    
    [originDictM setObject:[sign md5Encrypt] forKey:@"sign"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = 10;
    [manager POST:url parameters:originDictM progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (viewController != nil) {
            [MCView BSMBProgressHUD_hideWith:[self BSGetCurrentViewWith:viewController]];
        }
        
        
        if([responseObject isKindOfClass:[NSArray class]]) {
            NSError *error;
            NSString *dataStr = [responseObject mj_JSONString];
            NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            //是一个array
            successBlock(dataArr);
        } else if([responseObject isKindOfClass:[NSDictionary class]]) {
            //是一个字典
            NSArray * allKeys = [(NSDictionary *)responseObject allKeys];
            int i = 0;
            for (NSString * key in allKeys) {
                if ([key isEqualToString:@"errorMsg"] || [key isEqualToString:@"errorCode"]) { i ++;}
            }
            
            if (i >= 2) { // 是错误
                
                NSInteger  errorCode = [responseObject[@"errorCode"] integerValue];
                if (errorCode == [code_tokenFailure integerValue] || errorCode == [code_validationFails integerValue]) {   // 会话失效或者签名验证不合法
                    
                    [MCTool BSRemoveObjectforKey:BSUserinfo];
                    //发出通知 刷新首页的数据
                    NSNotification * notification = [NSNotification notificationWithName:@"RELOADHOMEPAGE" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    NSString * str = [NSString stringWithFormat:@"%@,重新登录",responseObject[@"errorMsg"]];
                    
                    [MCView BSAlertController_twoOptions_viewController:viewController message:str confirmTitle:@"去登录" cancelTitle:@"取消" confirm:^{
                        if (viewController != nil) {

                            KKLoginViewController * login = [[KKLoginViewController alloc] init];
                            login.isMandatory = YES;
                            [viewController.navigationController pushViewController:login animated:YES];
                           
                        }
                    } cancle:^{
                        
                    }];
                    
                    dislikeBlock(responseObject);
                } else {
                    if (viewController != nil) {
                        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"errorMsg"]];
                        [MCView BSAlertController_oneOption_viewController:viewController message:message cancle:^{
                            NSError *errorData = [NSError new];
                             failureBlock(errorData);
                        }];
                        dislikeBlock(responseObject);
                    }
                }
            } else {  // 正确. 使用者对返回进行业务逻辑处理
                successBlock(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        if (viewController != nil) {
            [MCView BSMBProgressHUD_hideWith:[self BSGetCurrentViewWith:viewController]];
        }
        // 抛出异常,看情况处理.
        failureBlock(error);
    }];
}



+ (void)BSNetWork_postWithUrl:(NSString *)url parameters:(id)dict andViewController:(UIViewController *)viewController success:(SuccessBlock)successBlock error:(ErrorMessageDealBlock)errorDealBlock failure:(FailureBlock)failureBlock {
    
    if (viewController != nil) {
        [MCView BSMBProgressHUD_bufferAndTextWithView:[self BSGetCurrentViewWith:viewController] andText:nil];
    }
    
    if (dict == nil) {
        dict = @{};
    }
    
    NSMutableDictionary * originDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    [originDictM setObject:@"2" forKey:@"platform"];   // 2 代表ios

    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        [originDictM setObject:token forKey:@"user_token"];
    }
    
    //包名和版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_bundleId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [originDictM setObject:app_bundleId forKey:@"app_bundleId"];
    [originDictM setObject:app_version forKey:@"app_version"];
    
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

        [MCView BSMBProgressHUD_hideWith:[self BSGetCurrentViewWith:viewController]];
        if([responseObject isKindOfClass:[NSArray class]])
        {
            //是一个array
            successBlock(responseObject);
        }else if([responseObject isKindOfClass:[NSDictionary class]])
        {
            //是一个字典
            NSArray * allKeys = [(NSDictionary *)responseObject allKeys];
            int i = 0;
            for (NSString * key in allKeys) {
                if ([key isEqualToString:@"errorMsg"] || [key isEqualToString:@"errorCode"]) { i ++;}
            }
            
            if (i >= 2) { // 是错误
                
                NSInteger  errorCode = [responseObject[@"errorCode"] integerValue];
                if (errorCode == 20012) {   // 会话失效
                    if (viewController != nil) {
                        [MCTool BSRemoveObjectforKey:BSUserinfo];
                        //发出通知 刷新首页的数据
                        NSNotification * notification = [NSNotification notificationWithName:@"RELOADHOMEPAGE" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        NSString * message = @"登录失效，请重新登录";
                        [MCView BSAlertController_twoOptions_viewController:viewController message:message confirmTitle:@"去登录" cancelTitle:@"取消" confirm:^{
                            if (viewController != nil) {

                                KKLoginViewController * login = [[KKLoginViewController alloc] init];
                                login.isMandatory = YES;
                                [viewController.navigationController pushViewController:login animated:YES];
                            }
                        } cancle:^{
                            
                        }];
                    }
                    
                } else {
                    if (viewController != nil) {
                        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"errorMsg"]];
                        errorDealBlock(message);
                        
                    }
                }
            } else {  // 正确. 使用者对返回进行业务逻辑处理
                successBlock(responseObject);
            }

        }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (viewController != nil) {
            [MCView BSMBProgressHUD_hideWith:[self BSGetCurrentViewWith:viewController]];
        }
        // 抛出异常,看情况处理.
        failureBlock(error);
    }];
}


#pragma mark - 上传图片(外部只处理成功的情况)
+ (void)BSNetWork_post_uploadDataWithUrl:(NSString *)url data:(id)data andViewController:(UIViewController *)viewController success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    
    if (viewController != nil) {
        [MCView BSMBProgressHUD_bufferAndTextWithView:[self BSGetCurrentViewWith:viewController] andText:nil];
    }
    
    
    NSMutableDictionary * originDictM = [NSMutableDictionary dictionaryWithCapacity:0];
    [originDictM setObject:@"2" forKey:@"platform"];   // 2 代表ios
    
    NSString * token = [MCTool BSGetUserinfo_token];
    if (token.length > 0) {
        [originDictM setObject:token forKey:@"user_token"];
    }
    
    //包名和版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_bundleId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [originDictM setObject:app_bundleId forKey:@"app_bundleId"];
    [originDictM setObject:app_version forKey:@"app_version"];
    
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
    //接收类型不一致请替换一致text/html或别的
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];

    [manager POST:url parameters:originDictM constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(data,0.1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"photoFile"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MCView BSMBProgressHUD_hideWith:[self BSGetCurrentViewWith:viewController]];
        if([responseObject isKindOfClass:[NSArray class]])
        {
            //是一个array
            successBlock(responseObject);
        }else if([responseObject isKindOfClass:[NSDictionary class]])
        {
            //是一个字典
            NSArray * allKeys = [(NSDictionary *)responseObject allKeys];
            int i = 0;
            for (NSString * key in allKeys) {
                if ([key isEqualToString:@"errorMsg"] || [key isEqualToString:@"errorCode"]) { i ++;}
            }
            
            if (i >= 2) { // 是错误
                if (viewController != nil) {
                    NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"errorMsg"]];
                    [MCView BSAlertController_oneOption_viewController:viewController message:message cancle:nil];
                }
            } else {  // 正确. 使用者对返回进行业务逻辑处理
                successBlock(responseObject);
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (viewController != nil) {
            [MCView BSMBProgressHUD_hideWith:[self BSGetCurrentViewWith:viewController]];
        }
        // 抛出异常,看情况处理.
        failureBlock(error);
    }];
}



// 获取当前的视图的view,给MBProgressHUD当父视图
+ (UIView *)BSGetCurrentViewWith:(UIViewController *)viewController {
    UIView *view;
    if (viewController == nil) {
        view = viewController.navigationController.view;
    } else {
        view=viewController.view;
    } return view;
}

#pragma mark - 图片相关
+ (UIImage *)BSImage_createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 6.0f, 6.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
// 获取网络图片
+ (UIImage *)BSImage_createFromURL:(NSString *)fileURL {
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    UIImage * result = [UIImage imageWithData:data];
    return result;
}


#pragma mark - 文字的处理
+ (NSAttributedString *)BSNSAttributedString_fontAndColorWithColorRange:(NSRange)colorRange fontRange:(NSRange)fontRange color:(UIColor *)color font:(CGFloat)font text:(NSString * )text {
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:fontRange];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    return attributedString;
}

+ (NSAttributedString *)BSNSAttributedString_deleteLineWithLineColor:(UIColor *)color Text:(NSString * )text {
    NSRange range = NSMakeRange(0, text.length);
    UIColor * deleteLineColor = color;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, text.length)];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
    [attributedString addAttribute:NSStrikethroughColorAttributeName value:deleteLineColor range:range];
    return attributedString;
}

+ (NSString *)BSNSString_cutOutFromZeroPositionWithLength:(NSInteger)length andText:(NSString *)text {
    if (text.length > length) {
        return [text substringToIndex:length];
    } else {
        return text;
    }
}

#pragma mark - 判断处理
// 判断手机号是否正确
+ (BOOL)BSJudge_phoneNumber:(NSString *)phoneNum {
    NSString *regex = @"^1[3|4|5|6|7|8][0-9]{9}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isValid = [pre evaluateWithObject:phoneNum];
    
    BOOL result;
    if (isValid) {
        NSInteger length = phoneNum.length;
        if (length == 11) {
            result = YES;
        } else {
            result = NO;
        }
    } else {
        result = NO;
    } return result;
}
// 判断账号
+ (BOOL)BSJudge_accountWith:(NSString *)account {
    if (account.length <= 0) {
        return NO;
    }
    NSString * regex = @"^[A-Za-z0-9]{1,15}$";    //正则表达式
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];    //Cocoa框架中的NSPredicate用于查询，原理和用法都类似于SQL中的where，作用相当于数据库的过滤取
    BOOL isMatch = [pred evaluateWithObject:account];    //判读userNameField的值是否吻合
    return isMatch;
}
+ (BOOL)BSJudge_userIsLoginWith:(UIViewController *)vc {
    if ([MCTool BSGetUserinfo_token].length == 0) {
        KKLoginViewController * loginViewController = [[KKLoginViewController alloc] init];
        [vc.navigationController pushViewController:loginViewController animated:YES];
        return NO;
    } else {
        return YES;
    }
}

// ======================== 刘烨的方法 ======================== //时时彩
+(NSDictionary *)getWF_classDict:(NSString *)key{
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"lottery_wf_detail" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *sscDic = jsonDic[@"ssc"];
    NSDictionary *wf_classDic = sscDic[@"wf_class"];
    NSArray *wf_array = [wf_classDic allValues];
    for (NSDictionary *dict in wf_array) {
        NSArray *arr = [dict allKeys];
        for (NSString *str in arr) {
            if ([str isEqual:key]) {
                return dict[str];
            }
        }
    }
    return nil;
}
//pk10
+(NSDictionary *)getPK10_classDict:(NSString *)key{
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"lottery_wf_detail" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *sscDic = jsonDic[@"pk10"];
    NSDictionary *wf_classDic = sscDic[@"wf_class"];
    NSArray *wf_array = [wf_classDic allValues];
    for (NSDictionary *dict in wf_array) {
        NSArray *arr = [dict allKeys];
        for (NSString *str in arr) {
            if ([str isEqual:key]) {
                return dict[str];
            }
        }
    }
    return nil;
}
//11x5
+(NSDictionary *)get11x5_classDict:(NSString *)key{
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"lottery_wf_detail" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *sscDic = jsonDic[@"11x5"];
    NSDictionary *wf_classDic = sscDic[@"wf_class"];
    NSArray *wf_array = [wf_classDic allValues];
    for (NSDictionary *dict in wf_array) {
        NSArray *arr = [dict allKeys];
        for (NSString *str in arr) {
            if ([str isEqual:key]) {
                return dict[str];
            }
        }
    }
    return nil;
}
+(NSDictionary *)getk3_classDict:(NSString *)key{
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"lottery_wf_detail" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *sscDic = jsonDic[@"k3"];
    NSDictionary *wf_classDic = sscDic[@"wf_class"];
    NSArray *wf_array = [wf_classDic allValues];
    for (NSDictionary *dict in wf_array) {
        NSArray *arr = [dict allKeys];
        for (NSString *str in arr) {
            if ([str isEqual:key]) {
                return dict[str];
            }
        }
    }
    return nil;
}
+(NSDictionary *)getKL10F_classDict:(NSString *)key{
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"lottery_wf_detail" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *sscDic = jsonDic[@"kl10f"];
    NSDictionary *wf_classDic = sscDic[@"wf_class"];
    NSArray *wf_array = [wf_classDic allValues];
    for (NSDictionary *dict in wf_array) {
        NSArray *arr = [dict allKeys];
        for (NSString *str in arr) {
            if ([str isEqual:key]) {
                return dict[str];
            }
        }
    }
    return nil;
}













// ======================== 即将被废弃的方法 =================== // 新方法已经更新了.看上面的warning

// 通过颜色生成图片
+ (UIImage *)MCImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 6.0f, 6.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
#pragma mark 网络请求 -->> post
+ (void)MCSEndPOSTNetWorkWithUrl:(NSString *)url parameters:(id)dict success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // 拿到字典, 获取所有的keys.对key进行自然排序,
    /*
     系统默认密钥（default_key）：fb2356ddf5scc5d4d2s9e@2scwu7io2c
     
     每一次请求，如果有参数就要带上sign值，其计算方式为： 需将键值对按照自然排序后，在拼接上加密的key值（登陆后用md5_salt,没有登陆则用default_key），用md5获取摘要
     
     示例：请求参数 userId=test&password=1&cv=125&sign=83a66c30d2d14695aa93e21d9f6ae4ae&ab=12&ac=23&c=5 排序后：ab=12&ac=23&c=5&cv=125&password=1&userId=test 则sign=Md5(ab=12&ac=23&c=5&cv=125&password=1&userId=testfb2356ddf5scc5d4d2s9e@2scwu7io2c) 计算出sign:b4e8c79dd4786b78c960f6cc941b9baf
     
     3. 登陆后才能访问的url，用户需要带上user_token(登陆接口返回的),以此来辨别所属用户，同时用户需要在客户端保存md5_salt（盐值），以此来加密每次的参数
     */
    
    NSMutableDictionary * originDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    [originDictM setObject:@"2" forKey:@"platform"];   // 2 代表ios
    
    
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
    [sign appendFormat:@"%@",@"fb2356ddf5scc5d4d2s9e@2scwu7io2c"];
    [originDictM setObject:[sign md5Encrypt] forKey:@"sign"];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    
    [manager POST:url parameters:originDictM progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        if([nextResponder isKindOfClass:[UITabBarController class]]){
            result = ((UITabBarController*)nextResponder).selectedViewController;
            if([result isKindOfClass:[UINavigationController class]]){
                result = ((UINavigationController*)result).visibleViewController;
            }
        }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
            result = ((UINavigationController*)nextResponder).visibleViewController;
        }else{
           result = nextResponder;
        }
    }else{
        result = window.rootViewController;
    }
    return result;
}

+(void)getCodeImageSuccess:(CodeImageSuccessBlock)success failure:(FailureBlock)failureBlock{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSString *newSting = [[NSString stringWithFormat:@"%@%@",dateString,@"XLFD"] md5Encrypt];
    NSLog(@"%@",newSting);
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",KK_STATUS ? STIP : MCIP,@"config/generator-code"];
    NSDictionary * parameter = @{@"code_id": newSting};
    
    
    NSMutableDictionary * originDictM = [NSMutableDictionary dictionaryWithDictionary:parameter];
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
    }
    
    [originDictM setObject:[sign md5Encrypt] forKey:@"sign"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/png",nil];
    manager.requestSerializer.timeoutInterval = 15;
    
    NSMutableDictionary *baseParameters = [[NSMutableDictionary alloc] initWithDictionary:originDictM];
    
    [manager GET:urlStr parameters:baseParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIImage *decodedImage = [UIImage imageWithData:responseObject];
        
        success(decodedImage,newSting);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

@end
