//
//  CLAccount.h
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/6.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>




/*
 2015-06-06 10:56:07.792 微信开放测试-01[31906:8906475] {
 "access_token" = "OezXcEiiBSKSxW0eoylIeI6tEes0kQDSe4XnHTLz-99MMccLb0a-kmEGVU1Fld8h2RAHxL_QokAIIXrS73CZ-pT6BYEyZE25-qvnUHxX972a_QVkcPWHHAe3qYlPCxSGeA5P1AtA7fUkjuYk9hugbA";
 "expires_in" = 7200;
 openid = "oKQvAuA0x9KgffRdo2i2G_zeN0bQ";
 "refresh_token" = "OezXcEiiBSKSxW0eoylIeI6tEes0kQDSe4XnHTLz-99MMccLb0a-kmEGVU1Fld8h_2cFCDVei30vl8bSq2AoKZkEHHEjjd_0UzF9nUBnBQciMiaIcA-vXZbQURDj0hELG7pXCKqVF7DAa6jTEh1Z9Q";
 scope = "snsapi_userinfo";
 unionid = oIYXxjgMwHcwq4Se4zcHOKBF127w;
 }

 */

@interface CLAccount : NSObject
/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  授权用户唯一标识
 */
@property (nonatomic, copy) NSString *openid;
/**
 *  用户刷新access_token
 */
@property (nonatomic, copy) NSString *refresh_token;
/**
 *  用户授权的作用域
 */
@property (nonatomic, copy) NSString *scope;
/**
 *  用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的
 */
@property (nonatomic, copy) NSString *unionid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
