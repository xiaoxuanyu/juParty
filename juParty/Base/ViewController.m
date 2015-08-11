//
//  ViewController.m
//  定位+自定义标注+添加手势
//
//  Created by ljy on 15-4-13.
//  Copyright (c) 2015年 ljy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate,QMapViewDelegate>
{
    QPointAnnotation * _annotation;
    QPinAnnotationView * _annotationView;
    CGPoint _point;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initMapView];


    [self startLocation];
        [self addAnnotation];
//    UILongPressGestureRecognizer * _tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
//   
//    
//    _tap.delegate = self;
//    
//    [_mapView addGestureRecognizer:_tap];
//    
}
/**
 *  实例化地图view
 */
- (void)_initMapView{
    //    _searchBar_height=0;
    //    if (type==0) {
    //        _searchBar_height=40;
    //    }
    //    if (type==1) {
    //        _searchBar_height=0;
    //    }
    //
    //    if (type==0) {
    //        _searchBar_height=40;
    //    }

    self.mapView = [[QMapView alloc] initWithFrame:CGRectMake(0,50, fDeviceWidth, fDeviceHeight*3/5)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
}
/*************************************
 开始定位
 *************************************/
- (void) startLocation
{
    [self.mapView setShowsUserLocation:YES];
    NSLog(@"start location......");
}
/*************************************
 添加标准
 ***********************************/
- (void) addAnnotation
{
    
    _annotation = [[QPointAnnotation alloc]init];
    
    [_annotation setTitle:@"当前位置"];
    //    [_annotation setSubtitle:@"北京市区海淀区苏州街银科大厦"];
    [_mapView addAnnotation:_annotation];
    NSLog(@"add annotation......");
}
-(void)tapClick:(UILongPressGestureRecognizer *)tappress
{

    if (_annotation != nil) {
        [_mapView removeAnnotation:_annotation];
    }
    _point = [tappress locationInView:_mapView];
    
    CLLocationCoordinate2D coord = [_mapView convertPoint:_point toCoordinateFromView:_mapView];
    //将屏幕坐标转换成经纬度
    NSLog(@"%lf %lf",coord.latitude,coord.longitude
          );
    
    _annotation = [[QPointAnnotation alloc]init];
    
    _annotation.coordinate = coord;
    _annotation.title = @"标题";
    
    [_mapView addAnnotation:_annotation];
    
    
}

/*************************************
 代理方法
 *************************************/
#pragma mark -                                                                                                                                                                                                                                                                                    0
#pragma mark Q             MapViewDelegate
#pragma mark - Annotation Delegate
-(QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation
{
    NSLog(@"%@",annotation);
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation";
        
        _annotationView = (QPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (nil == _annotationView) {
            _annotationView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
            
            
        }
        else
        {
            _annotationView.annotation = annotation;
        }
        
        _annotationView.pinColor = QPinAnnotationColorRed;
        _annotationView.animatesDrop = YES;
        _annotationView.canShowCallout =YES;
          UIView *annotationView=[[UIButton alloc] initWithFrame:CGRectMake(_annotationView.frame.origin.x+30, _annotationView.frame.origin.y, _annotationView.frame.size.width,35)];
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, _annotationView.frame.size.width,35)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 1,35)];
        label.backgroundColor=[UIColor grayColor];
        [annotationView addSubview:label];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:15.0f];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//      [button setBackgroundColor:[UIColor grayColor]];
       [annotationView addSubview:button];
        _annotationView.rightCalloutAccessoryView=annotationView;
        return _annotationView;
    }
    return nil;
}
////来弹出自定义的callout
//- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view{
//    UIView *annotationView=[[UIView alloc] initWithFrame:_annotationView.bounds];
//    annotationView.backgroundColor=[UIColor grayColor];
//    NSLog(@"_annotationView:%f",_annotationView.frame.size.height);
//    [_annotationView addSubview:annotationView];
//    
////    UILabel *annotationLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, annotationView.width, 20)];
////    annotationLabel.textAlignment=NSTextAlignmentCenter;
////    annotationLabel.text=@"减减肥额wife发你空间恩负";
////    [annotationView addSubview:annotationLabel];
//// _annotationView.image = [UIImage imageNamed:@"w3.png"];
//}
-(QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id <QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QCircle class]])
    {
        QCircleView *circleView = [[QCircleView alloc] initWithCircle:overlay];
        
        circleView.lineWidth  = 3;
        circleView.strokeColor = [UIColor greenColor];
        circleView.fillColor  = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return circleView;
    }
    else if ([overlay isKindOfClass:[QPolygon class]])
    {
        QPolygonView *polygonView = [[QPolygonView alloc] initWithPolygon:overlay];
        polygonView.lineWidth  = 3;
        polygonView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:.3];
        polygonView.fillColor  = [UIColor redColor];
        
        return polygonView;
    }
    else if ([overlay isKindOfClass:[QPolyline class]])
    {
        QPolylineView *polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
        polylineView.lineWidth  =10;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.7];
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark - UserLocation
- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    NSLog(@"start location user......");
    
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    NSLog(@"stop location user......");
   [self.mapView setShowsUserLocation:NO];
    
}
///实现位置的更新
-(void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
   [_mapView setShowsUserLocation:NO];
    NSLog(@"update location user...... long %f,lat %f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    _userLatitude=userLocation.location.coordinate.latitude;
    _userLongitude=userLocation.location.coordinate.longitude;
    CLLocationCoordinate2D coordinate=userLocation.coordinate;
    QCoordinateSpan span={0.1,0.1};
    QCoordinateRegion region={coordinate,span};
    [_mapView setRegion:region animated:YES];
    [_annotation setCoordinate:CLLocationCoordinate2DMake(_userLatitude, _userLongitude)];
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(_userLatitude, _userLongitude) zoomLevel:15 animated:YES];
    //    QReverseGeocoder* geocode = [[QReverseGeocoder alloc] initWithCoordinate:coor];
    //    geocode.delegate = self;
    //    self.reverseGeocoder = geocode;
    //
    //
    //    [_reverseGeocoder start];
    //    QPointAnnotation *green = [[QPointAnnotation alloc] init];
    //    green.coordinate = CLLocationCoordinate2DMake(_userLatitude,_userLongitude);
    //    green.title = @"Green";
    //    green.subtitle = [NSString stringWithFormat:@"Green:{%f,%f}",green.coordinate.latitude,green.coordinate.longitude];
    //    [annotations addObject:green];
    //
    //    [self.mapView addAnnotations:annotations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
