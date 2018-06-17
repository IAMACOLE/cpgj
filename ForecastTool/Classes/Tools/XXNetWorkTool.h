//
//  XXNetWorkTool.h
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetRequestSuccessBlock)(id responseObject);//成功Block
typedef void (^NetRequestFailedBlock)(NSError *error);//失败Block

@interface XXNetWorkTool : NSObject

+(instancetype)shareTool;

/**
 *  Get形式提交数据
 *
 *  @param urlString  Url
 *  @param parameters 参数
 *  @param success    成功Block
 *  @param fail       失败Block
 */
-(void)postDataWithUrl:(NSString *)urlString parameters:(id)parameters success:(NetRequestSuccessBlock)success fail:(NetRequestFailedBlock)fail;

@end
