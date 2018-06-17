//
//  XXNetWorkTool.m
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXNetWorkTool.h"

@implementation XXNetWorkTool

+(instancetype)shareTool{
    
    static XXNetWorkTool *tool = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        tool = [[self alloc] init];
    });
    
    return tool;
}

- (AFHTTPSessionManager *)sharedManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"text/javascript",nil];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20;
    });
    return manager;
}

-(void)postDataWithUrl:(NSString *)urlString parameters:(id)parameters success:(NetRequestSuccessBlock)success fail:(NetRequestFailedBlock)fail{
    AFHTTPSessionManager *manager = [self sharedManager];
    
    parameters = [self dealWithParameters:parameters];
    
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSString *dataStr = [responseObject mj_JSONString];
            NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            success(dict);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(NSDictionary *)dealWithParameters:(NSDictionary *)dict{
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
    
    return originDictM;
}

@end
