//
//  ButtonViewTouchBlock.m
//  聚派
//
//  Created by yintao on 15/7/6.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "ButtonViewTouchBlock.h"
@implementation ButtonViewTouchBlock
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initGesture];
    }
    return self;
}
- (void)awakeFromNib{
    if (_tapGestureRecognizer==nil) {
        [self _initGesture];
    }
}
- (void)layoutSubviews{
    _imageView.frame=CGRectMake((self.width-25)/2, 5, 25, 25);
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
     [_imageView setImage:[UIImage imageNamed:self.buttonImageName]];
    
    _label.frame=CGRectMake(0, CGRectGetMaxY(_imageView.frame)+2, self.width, 20);
      _label.text=self.buttonTitle;
}
- (void)_initGesture{
    NSLog(@"eeeee%f",self.width);
   _imageView=[[UIImageView alloc] init];
    [self addSubview:_imageView];
    
   _label=[[UILabel alloc] init];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:15.0f];
    _label.textColor=GPTextColor;
    [self addSubview:_label];
    self.userInteractionEnabled=YES;
    _tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:_tapGestureRecognizer];
}
- (void)tapAction:(UITapGestureRecognizer *)tapGestureRecognizer{
    if (self.touchBlock) {
        self.touchBlock();
    }
}
@end
