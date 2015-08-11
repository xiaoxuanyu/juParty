//
//  JoinUserCollectionViewCell.m
//  聚派
//
//  Created by yintao on 15/7/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "JoinUserCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation JoinUserCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self _initView];
        
        //        self.text=[[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.frame)-10, 20)];
        //        self.text.backgroundColor=[UIColor brownColor];
        //        self.text.textAlignment=NSTextAlignmentCenter;
        //        [self addSubview:self.text];
        //
        //        self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
        //        self.btn.frame=CGRectMake(5, CGRectGetMaxY(self.text.frame), CGRectGetWidth(self.frame)-10, 30);
        //        [self.btn setTitle:@"按钮" forState:UIControlStateNormal];
        //        [self.btn setBackgroundColor:[UIColor orangeColor]];
        //        [self addSubview:self.btn];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    [self _initView];
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
//        _nickLabel.text = _userInfo.joinName;
//
//        [ _userImageView sd_setImageWithURL:[NSURL URLWithString:_userInfo.joinHeadurl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
       [self loadData];

}
- (void)setUserInfo:(GPJoinUserModel *)userInfo{
    //    _userInfo=[[GPJoinUserModel alloc] init];
    _userInfo = userInfo;
    _nikename=_userInfo.joinName;
    _headimgurl=_userInfo.joinHeadurl;
   [self loadData];
    
}

- (void)loadData
{
    //     CLUserInfo *userInfo=[CLAccountTool userinfo];
    //    _nikename=userInfo.nikename;
    //    _headimgurl=userInfo.headimgurl;
    if (_nikename.length != 0)
    {
        
//        NSLog(@"_nikenameeeee:%@",_nikename);
        _nickLabel.text = self.nikename;
    }
    if (_headimgurl.length != 0)
    {
//        NSLog(@"_headimgurlffff:%@",_headimgurl);
        [ _userImageView sd_setImageWithURL:[NSURL URLWithString:self.headimgurl] placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    }
}
@end
