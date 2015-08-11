//
//  MapNavigationView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/22.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "MapNavigationView.h"
#import "GPDPHttpTool.h"
#import "GPBusinessModel.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath:MYBUNDLE_PATH]
@implementation MapNavigationView
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        ///监听通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButton:) name:kPartyTpe object:nil];
//        [self _initMapView];
//        [self _initTableView];
//        if (type==1) {
//            _searchBar_height=0;
//        }
//        
//        if (type==0) {
//            _searchBar_height=40;
//        }
        [self _initMapView];
   
        [self startLocation];
     _annotations = [NSMutableArray array];
        _isSelect=NO;
        _buttonTitle=@"确定";
//        [self addAnnotation];
    }
    return self;
}
/**
 *  在delloc中移除通知
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    if (type==1) {
//         _searchBar_height=0;
//    }
//   
//    if (type==0) {
//        _searchBar_height=40;
//    }
    [self _initSearchBar];
    [self _initTableView];
//    [self startLocation];
//     [self addAnnotation];
}
//-(void)changeButton:(NSNotification *) noti
//{
//    //获取参数
//    NSNumber *shipType=[noti object];
//    type=[shipType integerValue];
//    NSLog(@"type:%ld",(long)type);
//    [self setNeedsLayout];
//}
- (void)_initSearchBar{
        _searchBar_height=0;
  
    ///在创建聚会时，添加搜索框
    if (self.partyType==startPartyMapView) {
        //        NSLog(@"%ld",(long)type);
        _searchBar_height=40;
         NSLog(@"_searchBar_height:%f",_searchBar_height);
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,fDeviceWidth ,_searchBar_height)];
        _searchBar.delegate=self;
        _searchBar.placeholder=@"搜索店铺";
  
        [self addSubview:_searchBar];
    }
}
#pragma mark - UISearchBarDelegate
//点击键盘上的search按钮时调用

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar

{
    
    NSString *searchTerm = searchBar.text;
    if ([self.delegate respondsToSelector:@selector(searchBusiness:withUserLongitude:keyword:)]) {
        if (_searchBar.isFirstResponder) {
            [_searchBar resignFirstResponder];
        }
        [self.delegate searchBusiness:_userLatitude withUserLongitude:_userLongitude keyword:searchTerm];
    }

//    [searchBar handleSearchForTerm:searchTerm];
//    [searchBar];
}


//输入文本实时更新时调用

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
//    
//    if (searchText.length == 0) {
//        
//        [self resetSearch];
//        
//        [table reloadData];
//        
//        return;
//        
//    }
//    
//    
//    
//    [self handleSearchForTerm:searchText];
    
}
//cancel按钮点击时调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"cancle clicked");
    
    if (_searchBar.isFirstResponder) {
        [_searchBar resignFirstResponder];
    }
      _searchBar.showsCancelButton=NO;
    _searchBar.text = @"";
}

//点击搜索框时调用

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar

{
      _searchBar.showsCancelButton=YES;
//    isSearching = YES;
//    
//    [table reloadData];
    
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
         NSLog(@"typeddd:%ld",(long)self.partyType);
    float mapTop_height=0;
//    ///在创建聚会时，添加搜索框
//    if (type==0) {
//        mapTop_height=40;
//    }
    self.mapView = [[QMapView alloc] initWithFrame:CGRectMake(0,mapTop_height+3, fDeviceWidth, fDeviceHeight*3/5)];
    self.mapView.delegate = self;
    self.mapView.zoomLevel=15;
    [self addSubview:self.mapView];
 
}
/**
 *  实例化地图下方地点tableView
 */
- (void)_initTableView{
//    self.mapTableView=[[MapTableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_mapView.frame),fDeviceWidth, fDeviceHeight-CGRectGetMaxY(_mapView.frame)-height)];
   
    if (self.partyType==startPartyMapView) {
      self.mapTableView=[[MapTableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_mapView.frame),fDeviceWidth, fDeviceHeight-CGRectGetMaxY(_mapView.frame)-64)];
        self.mapTableView.partyType=startPartyTable;
    }
    else if (self.partyType==checkPartyMapView){
         self.mapTableView=[[MapTableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_mapView.frame),fDeviceWidth, fDeviceHeight-CGRectGetMaxY(_mapView.frame)-104)];
         self.mapTableView.partyType=checkPartyTable;
    }
     self.mapTableView.selectTableViewDelegate=self;
    [self addSubview:self.mapTableView];
}
///**
// *  获取周边商户信息
// */
//- (void)getBusinessInformation{
//    [[GPDPHttpTool sharedGPDPHttpTool] businessesWithLatitude:self.userLatitude longitude:self.userLongitude success:^(NSArray *businesses, int totalCount) {
//        NSLog(@"userLatitude:%f",self.userLatitude);
//        self.mapTableView.tableViewdata=[businesses mutableCopy];
//        [self.mapTableView reloadData];
//    } error:^(NSError *error) {
//        
//    }];
//}
/*************************************
 添加标准
 ***********************************/
- (void) addAnnotation
{
    _annotation = [[QPointAnnotation alloc] init];
//    red.coordinate = CLLocationCoordinate2DMake(_userLatitude,_userLongitude);
//    red.title = @"red";
//    red.subtitle = [NSString stringWithFormat:@"Red:{%f,%f}",red.coordinate.latitude,red.coordinate.longitude];
    [_annotations addObject:_annotation];
    
     [self.mapView addAnnotations:_annotations];
//     [_annotationView setSelected:YES];
//    _annotation = [[QPointAnnotation alloc]init];
//    
//    [_annotation setTitle:@"当前位置"];
////    [_annotation setSubtitle:@"北京市区海淀区苏州街银科大厦"];
//    [_mapView addAnnotation:_annotation];
    NSLog(@"add annotation......");
}
#pragma mark 移除大头针
- (void)removeAnnotation{
//    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[QPointAnnotation class]]) {
            [_mapView removeAnnotation:_annotation];
    [_annotations removeObject:_annotation];
//        }
//    }];
}

//-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
//    [self removeCustomAnnotation];
//}

//#pragma mark 移除所用自定义大头针
//-(void)removeCustomAnnotation{
//    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[QPointAnnotation class]]) {
//            [_mapView removeAnnotation:obj];
//        }
//    }];
//}
/*************************************
 开始定位
 *************************************/
- (void) startLocation
{
    [self.mapView setShowsUserLocation:YES];
    NSLog(@"start location......");
}
/*************************************
 代理方法
 *************************************/
#pragma mark -
#pragma mark QMapViewDelegate
#pragma mark - Annotation Delegate
-(QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation
{
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
//        NSArray *imageArray=[NSArray arrayWithObjects:@"icon_map_location1",@"icon_map_location2",@"icon_map_location3", nil];
//            [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                if ([obj isKindOfClass:[QPointAnnotation class]]) {
//                    
//                    QPointAnnotation *pointAnnotation = (QPointAnnotation *)obj;
//                    if (annotation==pointAnnotation) {
//                        NSLog(@"idxxx:%d",idx);
//                        _index=idx;
//                    }
////        [_mapView removeAnnotation:_annotation];
////        [_annotations removeObject:_annotation];
//                }
//            }];
//      _annotationView.image=[UIImage imageNamed:[imageArray objectAtIndex:_index]];
    _annotationView.pinColor = QPinAnnotationColorRed;
        _annotationView.animatesDrop = YES;
        _annotationView.canShowCallout =YES;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(_annotationView.frame.origin.x+30, _annotationView.frame.origin.y, _annotationView.frame.size.width,35)];
        _annotationViewButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, _annotationView.frame.size.width,35)];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 1,35)];
        label.backgroundColor=[UIColor grayColor];
        [view addSubview:label];
         if (self.partyType==0) {
                [_annotationViewButton setTitle:@"确定" forState:UIControlStateNormal];
         }else{
                [_annotationViewButton setTitle:@"导航" forState:UIControlStateNormal];
         }
     
        [_annotationViewButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _annotationViewButton.titleLabel.font=[UIFont systemFontOfSize:15.0f];
        [_annotationViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //      [button setBackgroundColor:[UIColor grayColor]];
        [view addSubview:_annotationViewButton];
        _annotationView.rightCalloutAccessoryView=view;
        
        return _annotationView;
    }
    return nil;
}
- (void)buttonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(mapButtonClick)])  {
        
        [self.delegate mapButtonClick];
    }
    
//
//    if ([_annotationViewButton.titleLabel.text isEqualToString:@"确定"]) {
// 
////        NSLog(@"gbb5%d",[_mapView.selectedAnnotations count]);
//       
//        for (int i=0; i<[_annotations count]; i++) {
//            if ([[_annotations objectAtIndex:i] isEqualToString:_positionString]) {
//                NSLog(@"已添加过该地点");
//                   [_mapView removeAnnotation:_annotation];
//            }
//                 [_annotations addObject:_annotation.title];
//        
//        }
//   
////        ['晶靓亮蒸虾','30.59382','114.30377','江岸区中山大道公安路口','14684199']
//            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//            NSInteger time1 = round(time)/100;
//            NSString *timeString= [NSString stringWithFormat:@"%ld", (long)time1];
//        NSString *kkk=[NSString stringWithFormat:@"['%@','%f','%f','%@','%@']",_positionString,_userLatitude,_userLongitude,_positionDetailString,timeString];
//        [_placeArray addObject:kkk];
////        NSLog(@"%@",kkk);
////        NSArray *labelArray=[[NSArray alloc] initWithObjects:@"11", @"bb",nil];
////        [_placeArray addObjectsFromArray:labelArray];
////           NSLog(@"fwkfkk%@",_placeArray);
//        [_annotationViewButton setTitle:@"删除" forState:UIControlStateNormal];
//
//    }else if ([_annotationViewButton.titleLabel.text isEqualToString:@"删除"]){
//         [_annotationViewButton setTitle:@"确定" forState:UIControlStateNormal];
//           [_mapView removeAnnotation:_annotation];
//    }

//    [_mapView removeAnnotation:_annotation];
}
/**
 *  取消选中时触发
 *
 *  @param mapView mapView description
 *  @param view    view description
 */
- (void)mapView:(QMapView *)mapView didDeselectAnnotationView:(QAnnotationView *)view{
  

      NSLog(@"rrtrr%hhd",view.selected);
     if ([_buttonTitle isEqualToString:@"确定"]) {
//           [_mapView removeAnnotation:_annotation];
         [self removeAnnotation];
         
     }
    _isSelect=NO;
}
//来弹出自定义的callout
/**
 *  选中大头针时触发
 *
 *  @param mapView mapView description
 *  @param view    view description
 */
- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view{
//  [_mapView removeAnnotation:view.annotation];
    _annotation=view.annotation;
    for (UIView *vw in view.rightCalloutAccessoryView.subviews) {
        
        if ([vw isKindOfClass:[UIButton class]]) {
            
            UIButton *buttonView = (UIButton *)vw;
            NSLog(@"VM%@",buttonView.titleLabel.text);
            _buttonTitle=buttonView.titleLabel.text;
        }
    }

                [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[QPointAnnotation class]]) {
    
                        QPointAnnotation *pointAnnotation = (QPointAnnotation *)obj;
                        if (view.annotation==pointAnnotation) {
                            NSLog(@"idxxx:%d",idx);
                            _index=idx;
                        }
    //        [_mapView removeAnnotation:_annotation];
    //        [_annotations removeObject:_annotation];
                    }
                }];

//    for (int i=0; i++; i<_annotations.count) {
//        _annotation=[_annotations objectAtIndex:i];
//    }
}
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
       [self.mapView setShowsUserLocation:NO];
    NSLog(@"update location user...... long %f,lat %f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    _userLatitude=userLocation.location.coordinate.latitude;
    _userLongitude=userLocation.location.coordinate.longitude;
    CLLocationCoordinate2D coordinate=userLocation.coordinate;
    QCoordinateSpan span={0.1,0.1};
    QCoordinateRegion region={coordinate,span};
    [self.mapView setRegion:region animated:YES];
//  [self getBusinessInformation];
//    if ([self.delegate respondsToSelector:@selector(selectMapTableViewWithLatitude:withLongitude:withTitle:withAddress:)])  {
//        
//        [self.delegate selectMapTableViewWithLatitude:latitude withLongitude:longitude withTitle:name withAddress:address];
//    }
    if ([self.delegate respondsToSelector:@selector(getWeatherInformation:withUserLongitude:)]) {
        [self.delegate getWeatherInformation:_userLatitude withUserLongitude:_userLongitude];
    }
    if ([self.delegate respondsToSelector:@selector(getBusinessWithLatitude:withUserLongitude:)]) {
        [self.delegate getBusinessWithLatitude:_userLatitude withUserLongitude:_userLongitude];
    }
//       [_annotation setCoordinate:CLLocationCoordinate2DMake(_userLatitude, _userLongitude)];
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
- (void)selectTableViewWithLatitude:(double)latitude withLongitude:(double)longitude withTitle:(NSString *)name withAddress:(NSString *)address{
    NSLog(@"dddd");
    if ([self.delegate respondsToSelector:@selector(selectMapTableViewWithLatitude:withLongitude:withTitle:withAddress:)])  {
        
        [self.delegate selectMapTableViewWithLatitude:latitude withLongitude:longitude withTitle:name withAddress:address];
    }
}
@end
