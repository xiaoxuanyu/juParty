//
//  HttpTool.m
//  聚派
//
//  Created by yintao on 15/6/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "UIImage+FixOrientation.h"
//服务器地址
#define BASE_URL @"http://192.168.20.138:8089/SSM/Front/"
#define BASE_IMAGE_URL @"http://112.124.12.201:8181/guangpai/home/api/"
#define BASE_IMAGE_URL1 @"http://192.168.20.138:8080/SSM/Front/"

@implementation HttpTool
+ (void)checkedNetWork{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
//            self.isNetworking = NO;
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"当前网络不可用" message:@"请检查你的网络设置" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [a show];
        }else if (status == 1){
//            self.isNetworking = YES;
            NSLog(@"正在使用手机网络");
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"当前网络为手机2G/3G网" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [a show];
        }else if (status == 2){
//            self.isNetworking = YES;
            NSLog(@"正在使用手机WIFI");
        }else{
            
        }
    }];
}
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    url=[BASE_URL stringByAppendingFormat:@"%@",url];
    NSLog(@"url:%@",url);
    ///发送请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)postXmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSDictionary *params = @{@"format": @"xml"};
    ///发送请求
     url=[BASE_URL stringByAppendingFormat:@"%@",url];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
/**
 *  发送一个post请求,带上传文件
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param formDataArray 保存（多个）文件数据的数组
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     url=[BASE_URL stringByAppendingFormat:@"%@",url];
    ///发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> allFormData) {
        for (WBFormData *formData in formDataArray) {
            [allFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  上传图片
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param image         图片
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)uploadImageWithURL:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(void(^)(id json))success failure:(void(^)(NSError *error))failure{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    url=[BASE_URL stringByAppendingFormat:@"%@",url];
    ///发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id formData) {
        //添加图片，并对其进行压缩（0.0为最大压缩率，1.0为最小压缩率）
        NSLog(@"url:%@",url);
//        image = [self imageByScalingAndCroppingForSize:image toSize:CGSizeMake(256,256*image.size.height/image.size.width)];
//        image =[image fixOrientation]; //Put it like this.
        NSData *imageData = UIImageJPEGRepresentation([image fixOrientation], 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // 设置时间格式
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        //添加要上传的文件，此处为图片
        [formData appendPartWithFileData:imageData
         
                                    name:@"uploadFile"
         
                                fileName:fileName
         
                                mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  发送一个Imagepost请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithImageURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    url=[BASE_IMAGE_URL stringByAppendingFormat:@"%@",url];
    NSLog(@"url:%@",url);
    ///发送请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     url=[BASE_URL stringByAppendingFormat:@"%@",url];
    
    ///发送请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"url:%@",url);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)getWeatherDataWithparams:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure{
    ///AFNetWorking
    ///创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    ///发送请求
    [manager GET:@"http://api.map.baidu.com/telematics/v3/weather?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end

/**
 *  用来封装文件数据的模型
 */
@implementation WBFormData

@end
