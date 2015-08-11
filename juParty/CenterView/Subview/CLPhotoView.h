//
//  CLPhotoView.h
//  图片放大滚动
//
//  Created by 伍晨亮 on 15/5/30.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  个人信息界面图片
 */
@interface CLPhotoView : UIView
/**
 *  图片数组
 */
@property(nonatomic,strong)NSArray *images;

@property (nonatomic,copy) void (^ClickImageBlock)(NSUInteger index);


@end
