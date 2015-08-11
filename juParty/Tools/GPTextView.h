//
//  GPTextView.h
//  聚派
//
//  Created by yintao on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  GPTextViewDelegate协议
 */
@protocol GPTextViewDelegate <NSObject>
@optional
///输入的文字
-(void)textViewTextOfInput:(NSString *)inputText;
///键盘出现
-(void)textViewKeybordShow:(CGRect)endKeybordRect withAnimationDuration:(CGFloat)animationDuration;
///键盘消失
-(void)textViewKeybordHidden;
///点击renturn
-(void)textViewClickedReturn;
@end
/**
 *  自定义TextView
 */
@interface GPTextView : UITextView<UITextViewDelegate>
{
    UILabel *_placeholderLable;
}
@property(nonatomic,strong)NSString *placeholder;
/**
 *  是否隐藏placleholder
 */
@property (nonatomic) BOOL placleholderLableHidden;
/**
 *  声明GPTextViewDelegate协议
 */
@property(nonatomic,weak)id <GPTextViewDelegate>GPDelegate;
@end
