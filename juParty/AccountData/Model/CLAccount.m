//
//  CLAccount.m
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/6.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLAccount.h"




#define CLAccountTokenKey @"token"
#define CLUidKey @"uid"
#define CLOpenidKey @"openid"


@implementation CLAccount

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    CLAccount *account = [[self alloc]init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}

/**
 *  归档
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:CLAccountTokenKey];
    [aCoder encodeObject:_openid forKey:CLOpenidKey];
    [aCoder encodeObject:_unionid forKey:CLUidKey];
    
}
/**
 *  解档
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _access_token = [aDecoder decodeObjectForKey:CLAccountTokenKey];
        _openid = [aDecoder decodeObjectForKey:CLOpenidKey];
        _unionid = [aDecoder decodeObjectForKey:CLUidKey];
    }
    return self;
}

@end
