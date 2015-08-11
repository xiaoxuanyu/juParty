//
//  UIButton+UIButtonImageWithLable.m
//  GPCollectionView
//
//  Created by yintao on 15/5/28.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "UIButton+UIButtonImageWithLable.h"
@implementation UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
//    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12.0]];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
    CGSize titleSize=[title sizeWithAttributes:attributes];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    ///用这个方法替换下面的方法，文字的颜色就可以显示了。
    [self setTitleColor:[UIColor blueColor] forState:stateType];
    //[self.titleLabel setTextColor:[UIColor blueColor]];
    if (stateType == UIControlStateSelected) {
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    }else{
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height/2,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
    
}
- (void) buttonWithImage:(UIImage *)image withTitle:(NSString *)title withFrame:(CGRect)frame{
// self = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
    self.frame = frame;//button的frame
    //    NSLog(@"-----frame--------%@",frame);
    CGFloat paddingLeft,paddingRight,paddingTop,paddingBottom;
    if (self.frame.size.width>self.frame.size.height) {
        paddingTop=fDeviceWidth/13;
        paddingBottom=paddingTop;
        paddingLeft=(self.frame.size.width-self.frame.size.height)/2+paddingTop;
        paddingRight=paddingLeft;
    }else{
        paddingLeft=fDeviceWidth/13;
        paddingRight=paddingLeft;
        paddingTop=paddingLeft;
        paddingBottom=paddingTop*1.5f;
    }
    
//    self.backgroundColor = [Utils colorWithHexString:@"#dfe8f9"];//button的背景颜色
    //    [button setBackgroundImage:[UIImage imageNamed:@"man_64.png"] forState:UIControlStateNormal];
    //    在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    [self setImage:image forState:UIControlStateNormal];//给button添加image
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
// self.imageEdgeInsets = UIEdgeInsetsMake(5,5,10,10);
    //设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    [self setTitle:title forState:UIControlStateNormal];//设置button的title
    self.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
    self.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
//     //设置title在一般情况下的字体
//    [self setTitleColor:[Utils colorWithHexString:@"#4f88e8"] forState:UIControlStateNormal];
//   //设置title在button被选中情况下为灰色字体
//    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    self.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
}
@end
