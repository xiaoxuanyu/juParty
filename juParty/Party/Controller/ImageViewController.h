//
//  ImageViewController.h
//  juParty
//
//  Created by yintao on 15/8/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionView.h"
#import "BaseViewController.h"
#include "CLStatus.h"
@interface ImageViewController : BaseViewController{
       BOOL _isJoin;
}
@property (nonatomic,retain) CollectionView *collectionView;
@property (nonatomic, assign) int partyId;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,retain)CLStatus *status;
@end
