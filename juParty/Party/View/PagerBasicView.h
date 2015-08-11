//
//  PagerBasicView.h
//  聚派
//
//  Created by yintao on 15/7/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCollectionView.h"
#import "ButtonViewTouchBlock.h"
@protocol partyButtonDelegate <NSObject>
@optional

/**
 *  点击套用按钮
 */
-(void)applyButtonClick;
/**
 *  点击报名按钮
 */
-(void)registrationButtonClick;
/**
 *  点击分享按钮
 */
-(void)shareButtonClick;
@end
@interface PagerBasicView : UIView
@property (nonatomic,retain)UserCollectionView *userCollectionView;
@property(nonatomic,strong)ButtonViewTouchBlock* btn1;
@property(nonatomic,strong)ButtonViewTouchBlock* btn2;
@property(nonatomic,strong)ButtonViewTouchBlock* btn3;
@property (nonatomic,weak) id <partyButtonDelegate> delegate;
@end
