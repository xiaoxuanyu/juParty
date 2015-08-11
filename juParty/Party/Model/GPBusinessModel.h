//
//  GPBusinessModel.h
//  聚派
//
//  Created by yintao on 15/6/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  商户信息model
 */
@interface GPBusinessModel : NSObject
/**
 *  地址
 */
@property (nonatomic,copy)NSString *address;
/**
 *  商户名
 */
@property (nonatomic,copy)NSString *name;
/**
 *  所在城市
 */
@property (nonatomic, copy) NSString * city;
/**
 *  商户ID
 */
@property (nonatomic, assign) int business_id;
/**
 *  纬度坐标
 */
@property (nonatomic, assign) double latitude;
/**
 *  经度坐标
 */
@property (nonatomic, assign) double longitude;

// 商家信息
@property (nonatomic, strong) NSArray *businesses;
@end
