//
//  GPImageModel.h
//  聚派
//
//  Created by yintao on 15/7/16.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//


/*
 {"picurl":"http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/20150715-72094389253d4.jpg","isDelete":0,"juhuiId":1440,"id":740,"time":"1436958250","viewCount":0,"userName":"","userId":"oIYXxjpXKPtbDqnAFhA1-vsn6zkg","isCover":0,"commentCount":0}*/
#import <Foundation/Foundation.h>

@interface GPImageModel : NSObject
/**
 *  图片链接地址
 */
@property (nonatomic, copy) NSString *picurl;
/**
 *  是否删除，0为未删，1为删除
 */
@property (nonatomic,assign) int isDelete;
/**
 *  聚会Id
 */
@property (nonatomic,assign) int juhuiId;
/**
 *  图片表主键
 */
@property (nonatomic,assign) int imageId;
/**
 *  报名时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  照片浏览人数
 */
@property (nonatomic,assign) int viewCount;
/**
 *  上传人姓名
 */
@property (nonatomic, copy) NSString *userName;
/**
 *  上传人id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  是否封面图片（0为非封面，1为封面，默认为0)
 */
@property (nonatomic,assign) int isCover;
/**
 *  照片评论人数
 */
@property (nonatomic,assign) int commentCount;
@end
