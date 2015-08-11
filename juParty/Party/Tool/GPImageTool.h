//
//  GPImageTool.h
//  聚派
//
//  Created by yintao on 15/7/18.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPImageTool : NSObject
///判断设备是否有摄像头
+ (BOOL) isCameraAvailable;
///后面的摄像头是否可用
+ (BOOL) isRearCameraAvailable;
///前面的摄像头是否可用
+ (BOOL) isFrontCameraAvailable ;
// 检查摄像头是否支持拍照
+ (BOOL) doesCameraSupportTakingPhotos;
// 判断是否支持某种多媒体类型：拍照，视频
+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;
#pragma mark - 相册文件选取相关
///相册是否可用
+ (BOOL) isPhotoLibraryAvailable;
///是否可以在相册中选择视频
+ (BOOL) canUserPickVideosFromPhotoLibrary;
///是否可以在相册中选择图片
+ (BOOL) canUserPickPhotosFromPhotoLibrary;
@end
