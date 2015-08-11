//
//  HttpTool.h
//  聚派
//
//  Created by yintao on 15/6/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  数据请求工具类
 */
@interface HttpTool : NSObject
@property (nonatomic)BOOL isNetworking;
+ (void)checkedNetWork;
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)postXmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
/**
 *  发送一个post请求,带上传文件
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param formDataArray 保存（多个）文件数据的数组
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 *  上传图片
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param image         图片
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)uploadImageWithURL:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 *  发送一个Imagepost请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithImageURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

/**
 *  获取天气
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWeatherDataWithparams:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
@end
/**
 *  用来封装文件数据的模型
 */
@interface WBFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
