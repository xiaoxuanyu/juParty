//
//  GPTextView.m
//  聚派
//
//  Created by yintao on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "GPTextView.h"
@implementation GPTextView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}
- (void)awakeFromNib{
    [self _initView];
}
- (void)_initView{
    //        [self setBackgroundColor:[UIColor orangeColor]];
    self.returnKeyType = UIReturnKeySend;
    //        [self setTextColor:[UIColor colorWithRed:237.0f/255.0f green:241.0f/255.0f blue:253.0f/255.0f alpha:1]];
    [self setTextColor:[UIColor blackColor]];
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:237.0f/255.0f green:241.0f/255.0f blue:253.0f/255.0f alpha:1].CGColor;
    self.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    self.dataDetectorTypes = UIDataDetectorTypeAll;
    self.delegate = self;
    
    _placeholderLable = [[UILabel alloc] init];
    _placeholderLable.alpha = .4;
    //        _placeholderLable.textColor = [UIColor colorWithRed:237.0f/255.0f green:241.0f/255.0f blue:253.0f/255.0f alpha:1];
    _placeholderLable.textColor = [UIColor grayColor];
    _placeholderLable.textAlignment = NSTextAlignmentLeft;
    _placeholderLable.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [self addSubview:_placeholderLable];
    
  
}
#pragma mark - getter
-(void)setPlacleholderLableHidden:(BOOL)placleholderLableHidden{
    _placleholderLableHidden = placleholderLableHidden;
    _placeholderLable.hidden = self.placleholderLableHidden;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _placeholderLable.text = _placeholder;
    CGFloat h = [Utils textSize:_placeholder withFont:16 withFontName:@"HelveticaNeue" withWidth:self.width - 20 withHeight:MAXFLOAT].height;
    _placeholderLable.frame = CGRectMake(10,10, 200, h);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - keyBoard notification
-(void)registerForKeyboardNotifications{
    //键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
//键盘出现通知处理
-(void)keyboardWillShow:(NSNotification *)aNotification{
    
    NSDictionary *info = [aNotification userInfo];
    NSValue *animationCurveObject = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardEndRectObject = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0,0, 0, 0);
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    if ([_GPDelegate respondsToSelector:@selector(textViewKeybordShow:withAnimationDuration:)]) {
        [self.GPDelegate textViewKeybordShow:keyboardEndRect withAnimationDuration:animationDuration];
    }
}

//键盘消失通知处理
-(void)keyboardWillHide:(NSNotification *)aNotification{
    if ([_GPDelegate respondsToSelector:@selector(textViewKeybordHidden)]) {
        [self.GPDelegate textViewKeybordHidden];
    }
}
//将坐标点y 在window和superview转化  方便和键盘的坐标比对
//-(float)convertYToWindow:(float)Y
//{
//    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
//    return o.y;
//
//}

#pragma mark - textView delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self.text isEqualToString:@""]) {
        _placeholderLable.text = self.placeholder;
    }else{
        _placeholderLable.text = @"";
    }
    if ([_GPDelegate respondsToSelector:@selector(textViewTextOfInput:)]) {
        [self.GPDelegate textViewTextOfInput:self.text];
    }
    if ([text isEqualToString:@"\n"]) {
        [self resignFirstResponder];
        if ([_GPDelegate respondsToSelector:@selector(textViewClickedReturn)]) {
            [self.GPDelegate textViewClickedReturn];
        }
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [_placeholderLable setHidden:YES];
    self.placleholderLableHidden = YES;
//    if (textView.isFirstResponder) {
          [self registerForKeyboardNotifications];
//    }
    
    return YES;
}
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    [_placeholderLable setHidden:YES];
//    self.placleholderLableHidden = YES;
//    //    if (textView.isFirstResponder) {
//    [self registerForKeyboardNotifications];
//}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
