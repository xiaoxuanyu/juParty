//
//  UIView+Additions.m
//  聚派
//
//  Created by yintao on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (UIViewController *)viewController{
    ///下一个响应者
    UIResponder *next= [self nextResponder];
    do {
        ///如果是UIViewController返回
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        ///如果不是继续寻找
        next=[next nextResponder];
    } while (next!=nil);
    return nil;
}
@end
