//
//  GPTextField.h
//  聚派
//
//  Created by yintao on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * TextFieldDelegate协议
 */
@protocol GPTextFieldDelegate<NSObject>
@optional
///键盘出现
-(void)textFieldKeybordShow:(UITextField *)textField withKeybordRect:(CGRect)endKeybordRect withAnimationDuration:(CGFloat)animationDuration;
///键盘消失
-(void)textFieldKeybordHidden:(UITextField *)textField;
///输入的文字
-(void)textFieldInputText:(NSString *)inputText;
@end
/**
 *  自定义TextField
 */
@interface GPTextField : UITextField<UITextFieldDelegate>
/**
 *  声明GPTextFieldDelegate协议
 */
@property(nonatomic,weak)id <GPTextFieldDelegate>GPTfieldDelegate;
@end
