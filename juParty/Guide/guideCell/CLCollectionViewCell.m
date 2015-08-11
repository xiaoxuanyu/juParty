//
//  CLCollectionViewCell.m
//  聚派
//
//  Created by 伍晨亮 on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLCollectionViewCell.h"


@interface CLCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, weak) UIButton *startButton;

@end

@implementation CLCollectionViewCell




-(UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _startButton = btn;
    }
    return _startButton;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        [imageV setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.startButton.frame = self.bounds;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页，激活开始按钮
        self.startButton.hidden = NO;
    }else
    {
        self.startButton.hidden = YES;
    }
}

-(void)start
{
    NSLog(@"gogogo");
    if ([_delegate respondsToSelector:@selector(SwitchingControllerToAuthorizeArrivals)]) {
        [_delegate SwitchingControllerToAuthorizeArrivals];
    }
}

@end
