//
//  GPDPHttpTool.h
//  聚派
//
//  Created by yintao on 15/6/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class GPBusinessModel;
// business里面装的都是模型数据
typedef void (^BusinessesSuccessBlock)(NSArray *businesses, int totalCount);
typedef void (^BusinessesErrorBlock)(NSError *error);

// business里面装的都是模型数据
typedef void (^BusinessSuccessBlock)(GPBusinessModel *business);
typedef void (^BusinessErrorBlock)(NSError *error);


typedef void (^RequestBlock)(id result, NSError *errorObj);
/**
 *  大众点评数据请求类
 */
@interface GPDPHttpTool : NSObject
singleton_interface(GPDPHttpTool)
///获得周边商家数据
- (void)businessesWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude success:(BusinessesSuccessBlock)success error:(BusinessesErrorBlock)error;

- (void)businessesWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude keyword:(NSString *)keyword success:(BusinessesSuccessBlock)success error:(BusinessesErrorBlock)error;
@end
