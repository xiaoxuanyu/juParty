//
//  ShareView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/28.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
         NSString *text=@"你已经成功创建一次活动 邀请你的朋友一起参加吧";
         UIFont *font=[UIFont fontWithName:@"Arial" size:12];
        //、根据label内容、字体等获取label的Size
         CGSize textSize =[text boundingRectWithSize:CGSizeMake(fDeviceWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        _describeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0, textSize.width,textSize.height)];
        _describeLabel.backgroundColor=[UIColor clearColor];
        _describeLabel.textColor=[UIColor blackColor];
        _describeLabel.textAlignment=NSTextAlignmentCenter;
        _describeLabel.font=font;
        _describeLabel.text=text;
        _describeLabel.numberOfLines=0;
        [self addSubview:_describeLabel];
        
        _weChat =[UIButton buttonWithType:UIButtonTypeCustom];
        _weChat.frame=CGRectMake(100, CGRectGetHeight(_describeLabel.frame)+10, 50,50);
        [_weChat setImage:[UIImage imageNamed:@"w3.png"] withTitle:@"朋友圈" forState:UIControlStateNormal];
        [self addSubview:_weChat];
    }
    return self;
}
@end
