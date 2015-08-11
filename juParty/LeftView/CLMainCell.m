//
//  CLMainCell.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/21.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLMainCell.h"
#import "UIImageView+WebCache.h"
@implementation CLMainCell

- (void)awakeFromNib {
    // Initialization code
    //UimageView图片展示时先以展示局部，用户点击后显示整个图片，代码如下
    self.LeftView.contentMode = UIViewContentModeScaleAspectFill;
    [self.LeftView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.LeftView.contentMode = UIViewContentModeScaleAspectFill;
    self.LeftView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.LeftView.clipsToBounds = YES;
    self.iconBtnView.layer.cornerRadius = 30;
    self.iconBtnView.layer.masksToBounds = YES;
    //设置边框颜色
    self.iconBtnView.layer.borderColor=[UIColor whiteColor].CGColor;
    //设置边框宽度
    self.iconBtnView.layer.borderWidth=1.5f;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _userNameLabel.text=_status.plannerName;
    _collectLabel.text=[NSString stringWithFormat:@"%d",_status.count];
    _collectLabel.textAlignment=NSTextAlignmentLeft;
    _userNameLabel.textAlignment=NSTextAlignmentCenter;
    [self.locationImageView setImage:[UIImage imageNamed:@"icon_home_locating.png"]];
    [self.starImageView setImage:[UIImage imageNamed:@"icon_home_star.png"]];
     [_locationImageView setContentMode:UIViewContentModeScaleAspectFit];
     [_starImageView setContentMode:UIViewContentModeScaleAspectFit];
    NSURL *iconurl = [NSURL URLWithString:_status.plannerHeadurl];
    NSURL *backurl = [NSURL URLWithString:_status.picurl];
    [self.userImageView sd_setImageWithURL:iconurl placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    [self.LeftView sd_setImageWithURL:backurl placeholderImage:[UIImage imageNamed:@"image_home_background.png"]];
    [self.userImageView setUserInteractionEnabled:YES];
    [self.userImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CenterClick:)]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)CenterClick:(UITapGestureRecognizer *)tapGesture{
    if ([_delegate respondsToSelector:@selector(CenterDidClick:)])  {
        
        [_delegate CenterDidClick:self.status];
    }
}

@end
