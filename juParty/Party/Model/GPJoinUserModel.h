//
//  GPJoinUserModel.h
//  聚派
//
//  Created by yintao on 15/7/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
/*{"joinName":"^_−☆","isDelete":0,"juhuiId":1179,"joinHeadurl":"http://wx.qlogo.cn/mmopen/ujobib5Bpqq6hD5icWfr9DQn3aSOPhpTHeEibFREA6Piaic0zt8Zt3SYw4JY9rfE4bDHztsncZBhcOY4pB7YcQCUPwQ/0","joinId":"oIYXxjqQmpltBoPe6UgTGZs5tkMA","id":1157,"time":"1434680732"}*/
@interface GPJoinUserModel : NSObject
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *joinName;
/**
 *  是否删除，0为未删，1为删除
 */
@property (nonatomic,assign) int isDelete;
/**
 *  聚会Id
 */
@property (nonatomic,assign) int juhuiId;
/**
 *  用户头像链接地址
 */
@property (nonatomic, copy) NSString *joinHeadurl;
/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *joinId;
/**
 *  表主键
 */
@property (nonatomic, copy) NSString *partyId;
/**
 *  报名时间
 */
@property (nonatomic, copy) NSString *time;
@end
