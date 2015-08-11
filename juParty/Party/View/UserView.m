//
//  UserView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "UserView.h"
#import "CLAccountTool.h"
#import "UIImageView+WebCache.h"
@implementation UserView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIView *view=[[[NSBundle mainBundle] loadNibNamed:@"UserView" owner:self options:nil] lastObject];
        view.backgroundColor=[UIColor clearColor];
//        CGRect rect = view.frame;
//        rect.size.width=frame.size.width;
//        rect.size.height=frame.size.height;
//        view.frame = rect;
        self.size=view.size;
        [self addSubview:view];
    }
    return self;
}

/**
 *  初始化UserView
 */
- (void)_initView{
    [self.nickLabel setFont:[UIFont systemFontOfSize:13.0f]];
     _nickLabel.textColor=GPTextColor;
    _userImageView.layer.masksToBounds = YES;
    //设置layer的圆角,刚好是自身宽度的一半，这样就成了圆形
    _userImageView.layer.cornerRadius =CGRectGetWidth(_userImageView.frame) * 0.5;
   
}
- (void)layoutSubviews{
    [super layoutSubviews];
     [self _initView];
     [self loadData];
}
- (void)setUserInfo:(CLStatus *)userInfo{
//    _userInfo=[[GPJoinUserModel alloc] init];
    _userInfo = userInfo;
_nikename=_userInfo.plannerName;
   _headimgurl=_userInfo.plannerHeadurl;
  [self loadData];
    
}

- (void)loadData
{
//     CLUserInfo *userInfo=[CLAccountTool userinfo];
//    _nikename=userInfo.nikename;
//    _headimgurl=userInfo.headimgurl;
    if (_nikename.length != 0)
    {
        
       NSLog(@"_nikenam:%@",_nikename);
        _nickLabel.text = self.nikename;
    }
    if (_headimgurl.length != 0)
    {
    NSLog(@"_headimgurlffff:%@",_headimgurl);
  [ _userImageView sd_setImageWithURL:[NSURL URLWithString:self.headimgurl] placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    }
}
@end
