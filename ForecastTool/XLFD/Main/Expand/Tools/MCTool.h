//
//  MCTool.h
//  BuBuBa
//
//  Created by goulela on 16/5/19.
//  Copyright © 2016年 bububa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

typedef void(^SuccessBlock)(id data);
typedef void(^DislikeBlock)(id data);
typedef void(^FailureBlock)(NSError * error);
typedef void(^ErrorMessageDealBlock)(id data);
typedef void(^CodeImageSuccessBlock)(UIImage *image,NSString *codeID);

@interface MCTool : NSObject


+(NSDictionary *)getWF_classDict:(NSString *)key;
+(NSDictionary *)getPK10_classDict:(NSString *)key;
+(NSDictionary *)getKL10F_classDict:(NSString *)key;
+(NSDictionary *)get11x5_classDict:(NSString *)key;
+(NSDictionary *)getk3_classDict:(NSString *)key;


#pragma mark - UserDefault
+ (void)BSSetObject:(id)object forKey:(NSString *)key;
+ (id)BSGetObjectForKey:(NSString *)key;
+ (void)BSRemoveObjectforKey:(NSString *)key;

#pragma mark - 用户信息
+ (NSString *)getDevice;
+ (NSString *)BSGetUserinfo_token;
+ (NSString *)BSGetUserinfo_salt;
+ (NSString *)BSGetUserinfo_userId;
+ (NSString *)BSGetUserinfo_nick_name;
+ (NSString *)BSGetUserinfo_imageUrl;
+ (BOOL)BSGetUserinfo_bank_status;
+ (BOOL)BSGetUserinfo_password_status;
+ (BOOL)BSGetBank_passwd_status;



#pragma mark - 返回颜色图片
+(UIImage*) imageWithColor:(UIColor*)color;

#pragma mark - Networking
//网络请求 -->> post
+ (void)BSNetWork_postWithUrl:(NSString *)url parameters:(id)dict andViewController:(UIViewController *)viewController isShowHUD:(BOOL)isShowHUD isShowTabbar:(BOOL)isShowTabbar success:(SuccessBlock)successBlock dislike:(DislikeBlock)dislikeBlock failure:(FailureBlock)failureBlock;
+ (void)BSNetWork_post_uploadDataWithUrl:(NSString *)url data:(id)data andViewController:(UIViewController *)viewController success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
+ (void)BSNetWork_postWithUrl:(NSString *)url parameters:(id)dict andViewController:(UIViewController *)viewController success:(SuccessBlock)successBlock error:(ErrorMessageDealBlock)errorDealBlock failure:(FailureBlock)failureBlock;
//验证码获取接口
+(void)getCodeImageSuccess:(CodeImageSuccessBlock)success failure:(FailureBlock)failureBlock;

+ (UIImage *)BSImage_createImageWithColor:(UIColor *)color;
#warning 即将废弃 请用上面那个方法
// 通过颜色生成图片
+ (UIImage *)MCImageWithColor:(UIColor *)color;
+ (UIImage *)BSImage_createFromURL:(NSString *)fileURL;




#pragma mark - 字符串
+ (NSAttributedString *)BSNSAttributedString_fontAndColorWithColorRange:(NSRange)colorRange fontRange:(NSRange)fontRange color:(UIColor *)color font:(CGFloat)font text:(NSString * )text;
+ (NSAttributedString *)BSNSAttributedString_deleteLineWithLineColor:(UIColor *)color Text:(NSString * )text;
+ (NSString *)BSNSString_cutOutFromZeroPositionWithLength:(NSInteger)length andText:(NSString *)text;

#pragma mark - 判断
+ (BOOL)BSJudge_phoneNumber:(NSString *)phoneNum;
// 判断账号是否正确
+ (BOOL)BSJudge_accountWith:(NSString *)userName;
// 是否登录
+ (BOOL)BSJudge_userIsLoginWith:(UIViewController *)vc;

+ (UIViewController *)getCurrentVC;

#pragma mark - 系统

+ (NSMutableArray *)getIAPsBundleId;

@end
