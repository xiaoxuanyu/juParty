//
//  CheckPartyView.h
//  聚派
//
//  Created by yintao on 15/7/6.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "CustomIOSAlertView.h"
#import "CLStatus.h"
#import "GPWeatherModel.h"
/**
 *  查看聚会头部View
 */
@interface CheckPartyView : UICollectionReusableView<CustomIOSAlertViewDelegate>{
}
/**
 *  选择的时间
 */
@property (nonatomic, strong) NSDate *selectedDate;
/**
 * 聚会日期label
 */
@property (nonatomic,retain)UILabel *dateLabel;
/**
 * 聚会时间label
 */
@property (nonatomic,retain)UILabel *timeLabel;
//@property (nonatomic,retain)CLUserInfo *userInfo;
//typedef NS_ENUM(NSInteger, BasicPartyType){
//    startBasicParty, //发起聚会
//    checkBasicParty //查看聚会
//};
//@property (nonatomic,assign)BasicPartyType shipType;
/**
 *  上方textField主题view
 */
@property (nonatomic,retain)UIView *partyThemeView;
/**
 * 主题背景图片
 */
@property (nonatomic,retain)UIImageView *partyThemeBackgroundImageView;
@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UILabel *nickLabel;
@property (nonatomic,retain)UIView *userView;
/**
 *  倒计时显示label
 */
@property (nonatomic,retain)UILabel *countDownLabel;
/**
 *
 */
@property (nonatomic,strong)UILabel *themeText;
@property (nonatomic,strong)UILabel *detailText;
/**
 *  天气图片
 */
@property (nonatomic,retain)UIImageView *weatherImageView;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic, strong) GPWeatherModel *weatherInfo;
@end
