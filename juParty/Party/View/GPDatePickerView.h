//
//  GPDatePickerView.h
//  HSDatePickerViewControllerDemo
//
//  Created by yintao on 15/6/11.
//  Copyright (c) 2015年 Hydra Softworks. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义时间选择器
 */
@interface GPDatePickerView : UIView
/**
*  时间字体颜色
*/
@property (nonatomic, strong) UIColor *mainColor;
/**
 *  Selected date. Warning! Don't read selected date from this variable. User NSDatePickerViewControllerDelegate protocol instead.
 */
/**
 *  选择时间.警告！不能从这个变量读取选择时间
 */
@property (nonatomic, strong) NSDate *date;
/**
 *  Maximum avaiable date on picker
 */
@property (nonatomic, strong) NSDate *minDate;
/**
 *  Maximum avaiable date on picker
 */
@property (nonatomic, strong) NSDate *maxDate;
/**
 *  Formater for date in picker. Default format is "ccc d MMM"
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

///选择的时间
- (NSDate *)dateWithSelectedTime;
@end
