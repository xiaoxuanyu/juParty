//
//  CLUserInfo.h
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLUserInfo : NSObject
/**
 *      city = Wuhan;
 country = CN;
 headimgurl = "http://wx.qlogo.cn/mmopen/lg1CPbKurZsc48NuZVkDkSa8Fg5aIHjcZGGSN63IKwLKiap6HDPTFztaicZt1Rf9QlxOdvqXeyD5ibL7cPgNAq6neCF1uAwwxUA/0";
 language = "zh_CN";
 nickname = "\U6668\U4eae\U3001";
 openid = "oKQvAuA0x9KgffRdo2i2G_zeN0bQ";
 privilege =     (
 );
 province = Hubei;
 sex = 1;
 unionid = oIYXxjgMwHcwq4Se4zcHOKBF127w;
 */

/**
*  普通用户个人资料填写的城市
*/
@property (nonatomic, copy) NSString *city;
/**
 *  国家，如中国为CN
 */
@property (nonatomic, copy) NSString *country;
/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *headimgurl;
/**
 *  语言
 */
@property (nonatomic, copy) NSString *language;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *nikename;
/**
 *  普通用户的标识，对当前开发者帐号唯一
 */
@property (nonatomic, copy) NSString *openid;
/**
 *  用户特权信息，json数组
 */
@property (nonatomic,strong)NSArray *privilege;
/**
 *  普通用户个人资料填写的省份
 */
@property (nonatomic, copy) NSString *province;
/**
 *  普通用户性别，1为男性，2为女性
 */
@property (nonatomic,assign) int sex;
/**
 *  用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
 */
@property (nonatomic, copy) NSString *unionid;

+ (instancetype)userinfoWithDict:(NSDictionary *)dict;

@end
