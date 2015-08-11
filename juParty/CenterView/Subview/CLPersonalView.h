//
//  CLPersonalView.h
//  图片放大滚动
//
//  Created by 伍晨亮 on 15/5/29.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  个人信息界面头像部分
 */
@interface CLPersonalView : UIView

@property (nonatomic,weak) UIImageView *bgImage;

@property (nonatomic,weak) UIImageView *iconImage;

@property (nonatomic,weak) UILabel     *namelabl;

@property (nonatomic,strong)NSArray    *icons;

@property (nonatomic,strong)NSArray    *names;

/**
 *  放置其他控件
 */
-(void)setUpOtherControlsWithImageName:(NSString *)imagename nametext:(NSString *)Ntext;

@end
