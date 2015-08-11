//
//  GPMessageModel.h
//  聚派
//
//  Created by yintao on 15/7/31.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {"picurl":"http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/AO5lqJA1GbQkMEou6EnzFOZkkbhFVwWtOanTEr2t1InUid05qww5PveViW9pFwKa.jpeg","messageContents":"今晚补脑袋已收藏","removed":0,"createTime":"Thu Jul 30 14:53:56 CST 2015","juhuiTitle":"组团给《大圣归来》当自来水","juhuiId":1207,"id":754,"receiveId":"oIYXxjvsiKJ68x1ug3sacI2yKSNI"}
 */
@interface GPMessageModel : NSObject
/**
 *  相册封面图片链接地址
 */
@property (nonatomic,copy)NSString *picurl;
/**
 *  消息内容
 */
@property (nonatomic,copy)NSString *messageContents;
/**
 *  0: 创建    1：删除
 */
@property (nonatomic,assign) int removed;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 *  聚会标题
 */
@property (nonatomic, copy) NSString *juhuiTitle;
/**
 *  聚会Id
 */
@property (nonatomic,assign) int juhuiId;
/**
 *  消息表主键Id
 */
@property (nonatomic,assign) int messageId;
/**
 *  接受者ID
 */
@property (nonatomic,copy)NSString *receiveId;
@end
