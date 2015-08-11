//
//  CLPersonalView.m
//  图片放大滚动
//
//  Created by 伍晨亮 on 15/5/29.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLPersonalView.h"
#import "UIImageView+WebCache.h"
@implementation CLPersonalView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image_personal.png"]];
        self.bgImage = bg;
        [self addSubview:bg];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    
    self.bgImage.frame = frame;
    
    self.iconImage.frame = CGRectMake(self.frame.size.width / 2 - 35,self.frame.size.height / 5 ,70, 70);
    self.namelabl.frame = CGRectMake(0, self.frame.size.height / 5 + 65, self.frame.size.width, 33);
    self.namelabl.textAlignment=NSTextAlignmentCenter;
}

-(void)setUpOtherControlsWithImageName:(NSString *)imagename nametext:(NSString *)Ntext;
{
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagename]];
    icon.layer.cornerRadius = 35;
    icon.layer.masksToBounds = YES;
    //设置边框颜色
    icon.layer.borderColor=[UIColor whiteColor].CGColor;
    //设置边框宽度
    icon.layer.borderWidth=1.5f;
    [icon sd_setImageWithURL:[NSURL URLWithString:imagename] placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    self.iconImage=icon;
//    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:imagename] placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    [self addSubview:icon];
    
    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = Ntext;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.numberOfLines = 0;
    self.namelabl = lbl;
    self.namelabl.textColor=[UIColor whiteColor];
    [self addSubview:lbl];
    
    
}


@end
