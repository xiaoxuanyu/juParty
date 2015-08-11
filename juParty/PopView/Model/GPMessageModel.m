//
//  GPMessageModel.m
//  聚派
//
//  Created by yintao on 15/7/31.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "GPMessageModel.h"

@implementation GPMessageModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"messageId": @"id"
              };
}
@end
