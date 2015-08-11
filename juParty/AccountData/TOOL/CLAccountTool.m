//
//  CLAccountTool.m
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLAccountTool.h"
#import "CLAccount.h"
#import "CLUserInfo.h"



@implementation CLAccountTool

static CLAccount *_account;
static CLUserInfo *_userinfo;

+(void)saveAccount:(CLAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:CLAccountFileName];
}

+(CLAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CLAccountFileName];
        
    }
    
    return _account;
}

+(void)saveUserInfo:(CLUserInfo *)userinfo
{
    [NSKeyedArchiver archiveRootObject:userinfo toFile:CLUserInfoFileName];

}

+(CLUserInfo *)userinfo
{
    if (_userinfo == nil) {
        _userinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:CLUserInfoFileName];
    }
    return _userinfo;
}
+ (void)removeAccount{
    //删除归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:CLUserInfoFileName]) {
        [defaultManager removeItemAtPath:CLUserInfoFileName error:nil];
    }    if ([defaultManager isDeletableFileAtPath:CLAccountFileName]) {
        [defaultManager removeItemAtPath:CLAccountFileName error:nil];
    }
}

@end
