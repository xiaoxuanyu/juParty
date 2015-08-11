//
//  Header.h
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#ifndef GPCollectionView_Header_h
#define GPCollectionView_Header_h
//----NSKeyedArchiver-----
#define CLAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#define CLUserInfoFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userinfo.data"]
//-----key----
#define baidukey @"s1ix8uDooeZENEbGwwkZzj2b"
#define UMSocialKey @"55b9f6a1e0f55a0b84005379"
//-----NSUserDefaults------
#define kSelectPlace @"selectPlace"
//----字体颜色----
#define GPTextColor [Utils colorWithHexString:@"4b4646"]
//----版本信息--------
#define IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//----屏幕宽高----------
#define fDeviceWidth [[UIScreen mainScreen] bounds].size.width
#define fDeviceHeight [[UIScreen mainScreen] bounds].size.height

#define cellWidth (fDeviceWidth-20)/4
#define basicHeader_hight 245
//-------通知---------------
#define kPartyTpe @"kPartyTpe"

//-------mburl---------------
//保存创建活动信息
#define Url_createParty @"gp_juhui_add"
//发布聚会
#define Url_publishParty @"gp_juhui_finish"
//收藏活动
#define Url_collectionParty @"gp_collection_add"
//记录当前用户报名的活动
#define Url_joinParty @"gp_baoming_add"
//意见反馈
#define Url_suggest @"gp_suggest_add"
//查询出用户创建或者参加的活动
#define Url_queryParty @"gp_user_query"
//查询出该用户收藏的活动
#define Url_queryCollection @"gp_collection_query"
//查询出该用户参加的活动
#define Url_queryJoin @"gp_baoming_query"
//查询该用户发布的活动
#define Url_queryPublishParty @"gp_user_query_rj"
//根据聚会id查询出活动的基本信息
#define Url_queryPartyById @"gp_juhui_query_byid"
//查询活动报名人员
#define Url_queryJoinPerson @"gp_baoming_by_juhui"
//查询出该活动下的相册图片记录
#define Url_queryImage @"gp_tupian_query_byjuhui"
//查询当前用户图片
#define Url_queryImageByUser @"gp_baoming_by_user"
//查询出平台活动信息
#define Url_qureyMianParty @"gp_juhui_query"
//删除图片记录
#define Url_deleteImageByUrl @"gp_tupian_delete"
//查询出用户相关消息
#define Url_queryMessage @"gp_message_query"
//删除消息
#define Url_deleteMessage @"gp_message_delete"
//-------wxurl---------------
#define Url_uploadImg @"uploadImg"
#define Url_addImage @"tupian_add"
#define Url_uploadImg1 @"gp_Tupian_up_android"
#endif
