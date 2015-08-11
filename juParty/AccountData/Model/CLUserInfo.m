//
//  CLUserInfo.m
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLUserInfo.h"

#define CLNicknameKey @"nickname"
#define CLHeadimgurlKey @"headimgurl"

@implementation CLUserInfo

+(instancetype)userinfoWithDict:(NSDictionary *)dict
{
    CLUserInfo *userinfo = [[self alloc]init];
    userinfo.nikename = dict[@"nickname"];
    userinfo.headimgurl = dict[@"headimgurl"];
    
    return userinfo;
}
/**
 *  归档
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_nikename forKey:CLNicknameKey];
    [aCoder encodeObject:_headimgurl forKey:CLHeadimgurlKey];
}
/**
 *  解档
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _nikename = [aDecoder decodeObjectForKey:CLNicknameKey];
        _headimgurl = [aDecoder decodeObjectForKey:CLHeadimgurlKey];
    }
    return self;
}



@end
