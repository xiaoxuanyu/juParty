//
//  CLHttpTool.h
//  聚派
//
//  Created by 伍晨亮 on 15/6/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHttpTool : NSObject


+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
