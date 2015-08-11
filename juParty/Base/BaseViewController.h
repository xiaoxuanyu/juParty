//
//  BaseViewController.h
//  聚派
//
//  Created by yintao on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLAccountTool.h"
/**
 * ViewController的基类
 */
@interface BaseViewController : UIViewController
@property (nonatomic,assign)BOOL isBackButton;
/**
 *  获取用户id
 *
 *  @param NSString 用户id
 *
 *  @return 返回用户id
 */
- (NSString *)userId;
/**
 *  获取授权用户标识openid
 *
 *  @param NSString 用户openId
 *
 *  @return 返回授权用户标识openid
 */
- (NSString *)openId;
/**
 *  获取用户头像地址
 *
 *  @param NSString 用户头像地址
 *
 *  @return 返回用户头像地址
 */
- (NSString *)headimgurl;
/**
 *  获取用户昵称
 *
 *  @param NSString 用户昵称
 *
 *  @return 返回用户头像地址
 */
- (NSString *)nikename;
/**
 *  获取授权用户个人信息
 *
 *  @param CLUserInfo 授权用户个人信息
 *
 *  @return 返回授权用户个人信息
 */
- (CLUserInfo *)userInfo;
@end
