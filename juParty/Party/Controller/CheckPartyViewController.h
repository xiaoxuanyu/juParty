//
//  CheckPartyViewController.h
//  juParty
//
//  Created by yintao on 15/8/7.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"
#import "BaseViewController.h"
#import "CLStatus.h"
#import "PagerBasicViewController.h"
#import "MapViewController.h"
#import "ImageViewController.h"
@interface CheckPartyViewController : BaseViewController<DLTabedSlideViewDelegate>
@property (retain, nonatomic) DLTabedSlideView *tabedSlideView;
@property (nonatomic, assign) int partyId;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,retain)NSMutableArray *placeMutableArray;
@property (nonatomic,retain)PagerBasicViewController *pagerCtrl;
@property (nonatomic,retain)MapViewController *mapCtrl;
@property (nonatomic,retain)ImageViewController *imageCtrl;
@end
