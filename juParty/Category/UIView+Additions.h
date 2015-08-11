//
//  UIView+Additions.h
//  聚派
//
//  Created by yintao on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  通过UIView对象获取该对象所属的UIViewController
 */
@interface UIView (Additions)
- (UIViewController *)viewController;
@end
