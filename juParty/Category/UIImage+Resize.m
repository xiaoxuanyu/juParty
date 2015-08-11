//
//  UIImage+Resize.m
//  GPCollectionView
//
//  Created by yintao on 15/5/19.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    ///1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    ///2.开启上下文
    CGFloat imageW = oldImage.size.width + 22 * borderWidth;
    CGFloat imageH = oldImage.size.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    ///3.取得当前的上下文,这里得到的就是上面刚创建的那个图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    ///4.画边框(大圆)
    [borderColor set];
    ///大圆半径
    CGFloat bigRadius = imageW * 0.5;
    ///圆心
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    //画圆。As a side effect when you call this function, Quartz clears the current path.
    CGContextFillPath(ctx);
    ///5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    ///裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    ///6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    ///7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    ///8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
