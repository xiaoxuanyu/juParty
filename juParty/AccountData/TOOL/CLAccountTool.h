//
//  CLAccountTool.h
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLAccount.h"
#import "CLUserInfo.h"

//@class CLAccount,CLUserInfo;
@interface CLAccountTool : NSObject

+(void)saveAccount:(CLAccount *)account;

+(CLAccount *)account;

+(void)saveUserInfo:(CLUserInfo *)userinfo;

+(CLUserInfo *)userinfo;
+(void)removeAccount;
@end
