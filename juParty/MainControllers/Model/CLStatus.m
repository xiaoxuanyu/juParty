//
//  CLStatus.m
//  聚派
//
//  Created by 伍晨亮 on 15/6/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLStatus.h"

@implementation CLStatus
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"ids": @"id"
              };
}
@end
