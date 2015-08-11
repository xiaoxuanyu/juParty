//
//  PagerBasicViewController.h
//  juParty
//
//  Created by yintao on 15/8/7.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagerBasicView.h"
#import "BaseViewController.h"
#import "GPWeatherModel.h"
@interface PagerBasicViewController : BaseViewController
@property (nonatomic,retain)PagerBasicView *pagerBasicView;
@property (nonatomic,retain)UserCollectionView *userCollectionView;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic, assign) int partyId;
@property (nonatomic,retain)NSMutableArray *userArray;
@property (nonatomic,strong)GPWeatherModel *weatherInfo;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,retain)NSMutableArray *placeMutableArray;
@end
