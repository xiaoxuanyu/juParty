//
//  PagerBasicView.m
//  聚派
//
//  Created by yintao on 15/7/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "PagerBasicView.h"
#import "UIButton+UIButtonImageWithLable.h"
@implementation PagerBasicView
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

        self.backgroundColor=[Utils colorWithHexString:@"#ededed"];
        [self _initBasicView];
      [self initTabBarButton];
    }
    return self;
}
- (void)_initBasicView{
    float header_height1=basicHeader_hight;
    UICollectionViewFlowLayout *flowLayout1=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout1.headerReferenceSize=CGSizeMake(fDeviceWidth, header_height1);//头部
    self.userCollectionView=[[UserCollectionView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-159) collectionViewLayout:flowLayout1];
    self.userCollectionView.header_height=header_height1;
    [self addSubview:self.userCollectionView];
//    [_scrolview addSubview:self.userCollectionView];
//    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
//    //NSLog(@"userInfo:%@",userInfo.nikename);
//    [dataArray addObject:self.userInfo];
//    self.userCollectionView.collectionViewdatadata=dataArray;
//    [self.userCollectionView reloadData];
}
- (void)initTabBarButton{
    _btn1=[[ButtonViewTouchBlock alloc]initWithFrame:CGRectMake(0,fDeviceHeight-159, fDeviceWidth/3,55)];
    _btn1.buttonImageName=@"Activitypage_apply_icon.png";
    _btn1.buttonTitle=@"套用";
    _btn1.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
    __block PagerBasicView *this=self;
    _btn1.touchBlock=^{
        NSLog(@"套用");
        if ([this.delegate respondsToSelector:@selector(applyButtonClick)])  {
            
            [this.delegate applyButtonClick];
        }
    };
    
    UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(fDeviceWidth/3-1, 0, 1, 55)];
    lineLabel.backgroundColor=[UIColor grayColor];
  [_btn1 addSubview:lineLabel];
    
    _btn2=[[ButtonViewTouchBlock alloc]initWithFrame:CGRectMake(fDeviceWidth/3,fDeviceHeight- 159, fDeviceWidth/3,55)];
    _btn2.buttonImageName=@"Activitypage_registration_icon.png";
    _btn2.buttonTitle=@"报名";
    _btn2.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
    _btn2.touchBlock=^{
        NSLog(@"报名");
        if ([this.delegate respondsToSelector:@selector(registrationButtonClick)])  {
            
            [this.delegate registrationButtonClick];
        }
    };
    
    UILabel *lineLabel2=[[UILabel alloc] initWithFrame:CGRectMake(fDeviceWidth/3-1, 0, 1, 55)];
    lineLabel2.backgroundColor=[UIColor grayColor];
    [_btn2 addSubview:lineLabel2];
    
    _btn3=[[ButtonViewTouchBlock alloc]initWithFrame:CGRectMake(fDeviceWidth/3*2,fDeviceHeight-159, fDeviceWidth/3,59)];
    _btn3.buttonImageName=@"Activitypage_share_icon.png";
    _btn3.buttonTitle=@"分享";
    _btn3.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
    _btn3.touchBlock=^{
        NSLog(@"分享");
        if ([this.delegate respondsToSelector:@selector(shareButtonClick)])  {
            
            [this.delegate shareButtonClick];
        }
    };
    // [_btn1 setBackgroundColor:[UIColor blackColor]];

//    _btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    _btn2.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
//    [_btn2 setTitleColor:GPTextColor forState:UIControlStateNormal];
//    
//    [_btn2 buttonWithImage:[UIImage imageNamed:@"Activitypage_apply_icon.png"] withTitle:@"报名" withFrame:CGRectMake(fDeviceWidth/3,fDeviceHeight- 154, fDeviceWidth/3,50)];
//    //    [_btn2 setTitle:@"地图导航"forState:UIControlStateNormal];
//    _btn3=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth/3*2,fDeviceHeight-154, fDeviceWidth/3,50)];
//    _btn3.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
//    [_btn3 setTitleColor:GPTextColor forState:UIControlStateNormal];
//    
//    [_btn3 setImage:[UIImage imageNamed:@"Activitypage_apply_icon.png"] forState:UIControlStateNormal];
//    [_btn3 setTitle:@"活动相册"forState:UIControlStateNormal];
    //    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    //    _btn3.imageEdgeInsets=UIEdgeInsetsMake(40, 10, 0, 10);
    //      _btn2.titleEdgeInsets = UIEdgeInsetsMake(40, 10, 0, 10);
    [self addSubview:_btn1];
    [self addSubview:_btn2];
    [self addSubview:_btn3];
  
}
//- (void)tabBarButton{
//    _btn1=[[UIButton alloc]initWithFrame:CGRectMake(0,fDeviceHeight-154, fDeviceWidth/3,50)];
//    _btn1.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
//    // [_btn1 setBackgroundColor:[UIColor blackColor]];
//    [_btn1 setTitleColor:GPTextColor forState:UIControlStateNormal];
//    [_btn1 setImage:[UIImage imageNamed:@"Activitypage_apply_icon.png"] withTitle:@"朋友圈" forState:UIControlStateNormal];
////    [_btn1 setTitle:@"基本信息" forState:UIControlStateNormal];
//    _btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    _btn2.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
//    [_btn2 setTitleColor:GPTextColor forState:UIControlStateNormal];
//
//    [_btn2 buttonWithImage:[UIImage imageNamed:@"Activitypage_apply_icon.png"] withTitle:@"报名" withFrame:CGRectMake(fDeviceWidth/3,fDeviceHeight- 154, fDeviceWidth/3,50)];
////    [_btn2 setTitle:@"地图导航"forState:UIControlStateNormal];
//    _btn3=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth/3*2,fDeviceHeight-154, fDeviceWidth/3,50)];
//    _btn3.backgroundColor=[Utils colorWithHexString:@"#f2cc1a"];
//    [_btn3 setTitleColor:GPTextColor forState:UIControlStateNormal];
//    
//    [_btn3 setImage:[UIImage imageNamed:@"Activitypage_apply_icon.png"] forState:UIControlStateNormal];
//    [_btn3 setTitle:@"活动相册"forState:UIControlStateNormal];
////    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
////    _btn3.imageEdgeInsets=UIEdgeInsetsMake(40, 10, 0, 10);
////      _btn2.titleEdgeInsets = UIEdgeInsetsMake(40, 10, 0, 10);
//    [self addSubview:_btn1];
//    [self addSubview:_btn2];
//    [self addSubview:_btn3];
//}
//- (UIView *)withButtonImage:(NSString *)imageName withButtonTitle:(NSString *)title{
//    UIImageView
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
