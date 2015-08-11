//
//  UIButton+UIButtonImageWithLable.h
//  GPCollectionView
//
//  Created by yintao on 15/5/28.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义UIButton
 */
@interface UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
- (void) buttonWithImage:(UIImage *)image withTitle:(NSString *)title withFrame:(CGRect)frame;
@end
