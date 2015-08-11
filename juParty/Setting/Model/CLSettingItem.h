//
//  CLSettingItem.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/22.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OperationBlock)();

@interface CLSettingItem : NSObject

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *title;
/**
 *  控制器的类型
 */
@property(nonatomic,assign)Class vcClass;
/**
 *  存储一个特殊的BLOCK操作
 */
@property(nonatomic,copy)OperationBlock operation;

//+(instancetype)initWithvcClass:(Class)vcClass;

-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass;

@end
