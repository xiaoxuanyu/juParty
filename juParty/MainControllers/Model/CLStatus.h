//
//  CLStatus.h
//  聚派
//
//  Created by 伍晨亮 on 15/6/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLStatus : NSObject
/**
 *  聚会表主键
 */
@property (nonatomic, assign) int ids;
/**
 *  聚会主题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  聚会时间时间戳
 */
@property (nonatomic, copy) NSString *time;
/**
 *  发起聚会人id
 */
@property (nonatomic, copy) NSString *plannerId;
/**
 *  发起聚会人昵称
 */
@property (nonatomic, copy) NSString *plannerName;
/**
 *  发起聚会人头像链接地址
 */
@property (nonatomic, copy) NSString *plannerHeadurl;
/**
 *  聚会报名人数汇总
 */
@property (nonatomic,assign)int count;
/**
 *  聚会地点
 */
@property (nonatomic, copy) NSString *place;
/**
 *  0表示创建未为完成，1表示创建完成
 */
@property (nonatomic,assign)int finfished;
/**
 *  相册封面图片链接地址
 */
@property (nonatomic, copy) NSString *picurl;
@end
