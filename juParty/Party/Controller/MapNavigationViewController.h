//
//  MapNavigationViewController.h
//  GPCollectionView
//
//  Created by yintao on 15/5/26.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapNavigationView.h"
#import "BaseViewController.h"
#import "ImageAlbumViewController.h"
#import "GPPlaceModel.h"
/**
 *  地图类
 */
@interface MapNavigationViewController : BaseViewController
@property (nonatomic,retain)MapNavigationView *mapNavigationView;
@property (nonatomic,copy)NSString *partyTitle;
@property (nonatomic,copy)NSString *partyContent;
@property (nonatomic,retain)NSString *partyTime;
@property (nonatomic,copy)NSString *partyPlace;
@property (nonatomic,copy)NSString *partyPlace1;
@property (nonatomic,copy)NSString *partyId;
@property (nonatomic,retain) ImageAlbumViewController  *imageAlbumCtrl;
@property (nonatomic,retain)NSMutableArray *annotations;
@property (nonatomic,retain)NSMutableArray *placeArray;
@property (nonatomic,copy)NSString *positionString;
@property (nonatomic,copy)NSString *positionDetailString;
//@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,assign)BOOL isAdd;
/**
 * 地点纬度
 */
@property (nonatomic,assign) double placeLatitude;
/**
 *  地点经度
 */
@property (nonatomic,assign) double placeLongitude;
@end
