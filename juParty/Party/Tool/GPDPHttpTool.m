//
//  GPDPHttpTool.m
//  聚派
//
//  Created by yintao on 15/6/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "GPDPHttpTool.h"
#import "DPAPI.h"
#import "GPBusinessModel.h"
#import "MJExtension.h"
typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface GPDPHttpTool() <DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}
@end
@implementation GPDPHttpTool
singleton_implementation(GPDPHttpTool)
- (id)init{
    if (self=[super init]) {
        _blocks=[NSMutableDictionary dictionary];
    }
    return self;
}
- (void)businessesWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude keyword:(NSString *)keyword success:(BusinessesSuccessBlock)success error:(BusinessesErrorBlock)error{
    ///请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"latitude"]=@(latitude);
    params[@"longitude"]=@(longitude);
    params[@"radius"]=[NSNumber numberWithInt:2000];
    params[@"keyword"]=keyword;
    [self requestWithURL:@"v1/business/find_businesses" params:params block:^(id result, NSError *errorObj) {//请求失败
        if (errorObj) {
            if (error) {
                error(errorObj);
            }
        }else if (success){// 请求成功
            if ([result[@"status"] isEqualToString:@"OK"]) {
                NSArray *array=result[@"businesses"];
                NSMutableArray *businesses = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    GPBusinessModel *business=[GPBusinessModel objectWithKeyValues:dict];
                    [businesses addObject:business];
                }
                success(businesses,[result[@"total_count"] intValue]);
            }else{
                if (error) {
                    error(errorObj);
                }
            }
        }
    }];

}
/**
 *  获得周边商家数据
 *
 *  @param latitude  纬度坐标
 *  @param longitude 经度坐标
 *  @param success   请求成功
 *  @param error     请求失败
 */
- (void)businessesWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude  success:(BusinessesSuccessBlock)success error:(BusinessesErrorBlock)error{
    ///请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"latitude"]=@(latitude);
    params[@"longitude"]=@(longitude);
    params[@"radius"]=[NSNumber numberWithInt:2000];
    [self requestWithURL:@"v1/business/find_businesses" params:params block:^(id result, NSError *errorObj) {//请求失败
        if (errorObj) {
            if (error) {
                error(errorObj);
            }
        }else if (success){// 请求成功
            if ([result[@"status"] isEqualToString:@"OK"]) {
                NSArray *array=result[@"businesses"];
                NSMutableArray *businesses = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    GPBusinessModel *business=[GPBusinessModel objectWithKeyValues:dict];
                    [businesses addObject:business];
                }
                success(businesses,[result[@"total_count"] intValue]);
            }else{
                if (error) {
                    error(errorObj);
                }
            }
        }
    }];
}
#pragma mark 封装了点评的任何请求
- (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    /*
     1.请求成功会调用self的下面方法
     - (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
     
     2.请求失败会调用self的下面方法
     - (void)request:(DPRequest *)request didFailWithError:(NSError *)error
     */
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    // 一次请求 对应 一个block
    // 不直接用request的原因是：字典的key必须遵守NSCopying协议
    // request.description返回的是一个格式为“<类名：内存地址>”的字符串，能代表唯一的一个request对象
    [_blocks setObject:block forKey:request.description];
}

#pragma mark - 大众点评的请求方法代理
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
    [_blocks removeObjectForKey:request.description];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
    [_blocks removeObjectForKey:request.description];
}
@end
