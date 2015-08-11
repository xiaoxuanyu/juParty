//
//  BasicInformationViewController.h
//  GPCollectionView
//
//  Created by yintao on 15/5/26.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicView.h"
#import "BaseViewController.h"
#import "GPWeatherModel.h"
#import <QMapKit/QMapKit.h>
/**
 *  基本信息类
 */
@interface BasicInformationViewController : BaseViewController<QMapViewDelegate>
@property (nonatomic,retain)BasicView *basicView;
@property (nonatomic,strong)GPWeatherModel *weatherInfo;
@property (nonatomic,strong)QMapView *mapView;
/**
 * 用户纬度
 */
@property (nonatomic,assign) double userLatitude;
/**
 *  用户经度
 */
@property (nonatomic,assign) double userLongitude;
@end
