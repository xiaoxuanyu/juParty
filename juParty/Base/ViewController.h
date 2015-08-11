//
//  ViewController.h
//  定位+自定义标注+添加手势
//
//  Created by ljy on 15-4-13.
//  Copyright (c) 2015年 ljy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMapKit/QMapKit.h>
@interface ViewController : UIViewController

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

