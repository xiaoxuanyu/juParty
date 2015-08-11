//
//  BasicView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/18.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "GPTextField.h"
#import "GPTextView.h"
#import "CustomIOSAlertView.h"
#import "GPDatePickerView.h"
#import "GPWeatherModel.h"
//@class GPWeatherModel;
/**
 *  基本信息头部View
 */
@interface BasicView : UICollectionReusableView<GPTextFieldDelegate,GPTextViewDelegate,CustomIOSAlertViewDelegate>{

}
@property (nonatomic,retain) GPDatePickerView *pickerView;
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
@property (nonatomic,strong)GPTextField *themeText;
@property (nonatomic,retain)UIView *partyContentView;
@property (nonatomic,strong)GPTextView *detailTextView;
/**
 * 日期字符串
 */
@property (nonatomic,copy)NSString *dateString;
/**
 *  天气图片
 */
@property (nonatomic,retain)UIImageView *weatherImageView;
@property (nonatomic, strong) GPWeatherModel *weatherInfo;
@property (nonatomic, assign) BOOL isCheck;
@end;
