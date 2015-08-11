//
//  GPPartyHttpTool.h
//  聚派
//
//  Created by yintao on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  进一步封装数据请求
 */
@interface GPPartyHttpTool : NSObject
/**
 *  发送聚会信息
 *
 *  @param userId      用户Id
 *  @param userName    用户昵称
 *  @param userHeadurl 用户头像地址
 *  @param title       聚会标题
 *  @param time        聚会时间
 *  @param place       聚会地点
 *  @param success     请求成功后的回调
 *  @param failure     请求成功后的回调
 */
+ (void)postPartyInformation:(NSString *)userId userName:(NSString *)userName userHeadurl:(NSString *)userHeadurl title:(NSString *)title time:(NSString *)time place:(NSString *)place success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发布聚会
 *
 *  @param partyId 聚会Id
 *  @param success 请求成功后的回调
 *  @param failure 请求成功后的回调
 */
+ (void)postPartyFinishWithId:(NSString *)partyId success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  上传图片到相册service
 *
 *  @param partyId 聚会Id
 *  @param userId  上传图片人的微信openid
 *  @param imageUrl 上传图片的链接地址
 *  @param success 请求成功后的回调
 *  @param failure 请求成功后的回调
 */
+ (void)postPartyImageWithId:(NSString *)partyId openId:(NSString *)userId imageUrl:(NSString *)imageUrl success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  根据经纬度获取天气
 *
 *  @param userLatitude  用户纬度
 *  @param userLongitude 用户经度
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)getWeatherDataWithLatitude:(double)userLatitude withUserLongitude:(double)userLongitude success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
