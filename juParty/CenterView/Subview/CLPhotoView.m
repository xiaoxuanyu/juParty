//
//  CLPhotoView.m
//  图片放大滚动
//
//  Created by 伍晨亮 on 15/5/30.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLPhotoView.h"

@implementation CLPhotoView


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect myFrame = self.bounds;
    
    NSUInteger maxRow = 4;
    NSUInteger distance=4;
    CGFloat width = (myFrame.size.width -((maxRow+1)*distance))/ maxRow;
    CGFloat height = width;
//    CGFloat width = (fDeviceWidth -((maxRow+1)*distance))/ maxRow;
//    CGFloat height = width;

    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        NSUInteger row = idx % maxRow;
        CGFloat x = width * row+distance*(row+1);
        CGRect frame = CGRectMake(x, 2, width, height);
        subView.frame = frame;
    }];
    self.backgroundColor=GPTextColor;
}
-(void)setImages:(NSArray *)images
{
    _images = images;
    
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        
        //开启事件
        imageV.userInteractionEnabled = YES;
        //模式
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        imageV.clipsToBounds = YES;
        //添加手势
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        //设置tag
        imageV.tag = idx;
        
        [self addSubview:imageV];
        
    }];
    
    
    
}
-(void)touchImage:(UITapGestureRecognizer *)tap{
    if(_ClickImageBlock != nil) _ClickImageBlock(tap.view.tag);
}


@end
