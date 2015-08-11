//
//  UserCollectionViewCell.m
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "UserCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation UserCollectionViewCell
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
/**
 *  初始化cell内容
 */
- (void)_initView{
   _userView=[[UserView alloc] initWithFrame:CGRectMake(0, 0, cellWidth,cellWidth)];
    [self.contentView addSubview:_userView];
    
}
- (void)setUserInfo:(GPJoinUserModel *)userInfo{
    if (_userInfo!=userInfo) {
        _userInfo=userInfo;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _userView.userInfo=self.userInfo;
    ///让gridview 异步调用layoutSubView
    [_userView setNeedsLayout];
}

@end
