//
//  MapViewController.h
//  juParty
//
//  Created by yintao on 15/8/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapNavigationView.h"
#include "BaseViewController.h"
#import "CLStatus.h"
@interface MapViewController : BaseViewController
@property (nonatomic,retain)MapNavigationView *mapNavigationView;
@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,retain)NSMutableArray *placeMutableArray;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic, assign) int partyId;
@property (nonatomic,copy)NSString *userID;
@end
