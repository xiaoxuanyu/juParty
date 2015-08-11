//
//  GPTextField.m
//  聚派
//
//  Created by yintao on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "GPTextField.h"

@implementation GPTextField
/**
 *  init方法
 *
 *  @param frame TextField的frame
 *
 *  @return 返回TextField对象
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
      
    }
    return self;
}
/**
 * 在dealloc中移除通知
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - keyBoard notification
/**
 *  注册通知
 */
-(void)registerForKeyboardNotifications{
    //键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/**
 *  键盘出现通知处理
 *
 *  @param aNotification 通知对象
 */
-(void)keyboardWillShow:(NSNotification *)aNotification{
    
    NSDictionary *info = [aNotification userInfo];
    ///动画曲线类型（UIViewAnimationCurve）
    NSValue *animationCurveObject = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    ///动画持续时间
    NSValue *animationDurationObject = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    ///键盘弹出后的frame的结构体对象
    NSValue *keyboardEndRectObject = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0,0, 0, 0);
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    if ([self.GPTfieldDelegate respondsToSelector:@selector(textFieldKeybordShow:withKeybordRect:withAnimationDuration:)]) {
        [self.GPTfieldDelegate textFieldKeybordShow:self withKeybordRect:keyboardEndRect withAnimationDuration:animationDuration];
    }
}
/**
 *  键盘消失通知处理
 *
 *  @return 通知对象
 */
-(void)keyboardWillHide:(NSNotification *)aNotification{
    if ([self.GPTfieldDelegate respondsToSelector:@selector(textFieldKeybordHidden:)]) {
        [self.GPTfieldDelegate textFieldKeybordHidden:self];
    }
}
#pragma mark - textField delegate
/**
 *  点击键盘return键,注销键盘，使键盘消失
 *
 *  @param textField textField对象
 *
 *  @return 返回YES
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}
/**
 *  限制输入长度，监听输入长度
 *
 *  @param textField textFiled对象
 *  @param range     输入范围
 *  @param string    替换字符串
 *
 *  @return 返回YES
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.GPTfieldDelegate respondsToSelector:@selector(textFieldInputText:)]) {
        [self.GPTfieldDelegate textFieldInputText:self.text];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
     [self registerForKeyboardNotifications];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
       [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
