//
//  CLTitleButton.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLTitleButton.h"

@implementation CLTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont boldSystemFontOfSize:18.0f];
         //        backButton.titleLabel.font = font;;
//        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.currentImage == nil) return;
    
    // title
   self.titleLabel.x =  self.titleLabel.x-5;
    
    
    // image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    self.imageView.y = CGRectGetMinY(self.titleLabel.frame);
}




// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
   [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
 [self sizeToFit];
}

@end
