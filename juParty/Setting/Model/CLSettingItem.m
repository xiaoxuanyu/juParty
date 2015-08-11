//
//  CLSettingItem.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/22.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLSettingItem.h"

@implementation CLSettingItem

-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title{
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
    }
    
    return self;
}
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    return [[self alloc] initWithIcon:icon title:title];
}

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass
{
    CLSettingItem *item = [self itemWithIcon:icon title:title];
    item.vcClass = vcClass;
    return item;

}

//+(instancetype)initWithvcClass:(Class)vcClass
//{
//    CLSettingItem *item = [[CLSettingItem alloc]init];
//    if (self = [super init]) {
//        
//    }
//
//}

@end
