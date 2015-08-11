//
//  MapNavigationView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/22.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMapKit/QMapKit.h>
#import "MapTableView.h"
@protocol GPMapDelegate <NSObject>
@optional

/**
 *  点击地图按钮
 */
-(void)mapButtonClick;
- (void)selectMapTableViewWithLatitude:(double)latitude withLongitude:(double)longitude withTitle:(NSString *)name withAddress:(NSString *)address;
/**
 *  获取周边商户信息
 */
- (void)getBusinessWithLatitude:(double)userLatitude withUserLongitude:(double)userLongitude;
- (void)getWeatherInformation:(double)userLatitude withUserLongitude:(double)userLongitude;
- (void)searchBusiness:(double)userLatitude withUserLongitude:(double)userLongitude keyword:(NSString *)keyword;
@end
/**
 *  地图导航View
 */
@interface MapNavigationView : UIView<QMapViewDelegate,selectTableViewDelegate,UISearchBarDelegate>{
//    NSInteger type;

    QPinAnnotationView * _annotationView;
}
typedef NS_ENUM(NSInteger, PartyTypeMapView){
    startPartyMapView, //发起聚会
    checkPartyMapView //查看聚会
};
@property (nonatomic,assign)PartyTypeMapView partyType;
/**
 *  判断是否有搜索框
 */
@property (nonatomic,assign)BOOL isSearchBar;
@property (nonatomic,strong)QMapView *mapView;
@property (nonatomic,retain)UILabel *stepNumber;
@property (nonatomic,retain)MapTableView *mapTableView;
@property (nonatomic,assign)float searchBar_height;
@property (nonatomic,retain)UISearchBar *searchBar;
/**
 * 用户纬度
 */
@property (nonatomic,assign) double userLatitude;
/**
 *  用户经度
 */
@property (nonatomic,assign) double userLongitude;
@property (nonatomic,retain)UIButton *annotationViewButton;

@property (nonatomic,retain) QPointAnnotation *annotation;
@property (nonatomic,retain) QAnnotationView* annotationView;
@property (nonatomic,weak) id <GPMapDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *annotations;
@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,copy)NSString *buttonTitle;
@property (nonatomic,assign)NSInteger index;
- (void)addAnnotation;
- (void)removeAnnotation;
@end
