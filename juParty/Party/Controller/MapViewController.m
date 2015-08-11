//
//  MapViewController.m
//  juParty
//
//  Created by yintao on 15/8/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "MapViewController.h"
#import "MJExtension.h"
@interface MapViewController ()<GPMapDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapNavigationView=[[MapNavigationView alloc] initWithFrame:CGRectMake(0, 0,fDeviceWidth, fDeviceHeight-108)];
    self.mapNavigationView.delegate=self;
    self.mapNavigationView.partyType=checkPartyMapView;
    //[self.mapNavigationView setNeedsDisplay];
    [self.view addSubview:self.mapNavigationView];
//  [self queryPartyById];
      [NSThread detachNewThreadSelector:@selector(_initplace) toTarget:self withObject:nil];
//    [self addAnnotations];
//  [self place];
//    _mapNavigationView.mapTableView.tableViewdata=[self placeMutableArray];
//    [_mapNavigationView.mapTableView reloadData];
    //        [self addAnnotations];
}

#pragma mark - 网络请求
/**
 *  根据聚会id查询聚会信息
 */
- (void)queryPartyById{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"id"]=[NSNumber numberWithInt:self.partyId];
    [HttpTool getWithURL:Url_queryPartyById params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpJuhui"];
            
            NSMutableArray *statusArray= [NSMutableArray array];
            _status=[[CLStatus alloc] init];
            for (NSDictionary *dict in array) {
                _status=[CLStatus objectWithKeyValues:dict];
                self.userID= _status.plannerId;
                [statusArray addObject:_status];
                //                _userCollectionView.headerView.status=status;
                //                _userCollectionView.headerView.themeText.text=status.title;
                //                [_userCollectionView.headerView setNeedsDisplay];
                //                [_userCollectionView.headerView setNeedsLayout];
            }
            //            NSString *tt=@"[[川霸味道(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...),30.477997,114.41118,洪山区关山大道光谷天地2楼,5505744]]";
            //            NSString *ww=@"[['秀玉红茶坊(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)','30.47805','114.4108','洪山区关山大道519号光谷天地','6055791'],['川霸味道(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)','30.477997','114.41118','洪山区关山大道光谷天地2楼','5505744'],['老村长私募菜(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)','30.47747','114.41092','洪山区关山大道光谷天地F3区29号','5601249']]";
            NSString *place=_status.place;
            if (![Utils isNullOfInput:place]) {
                NSMutableString *str1 = [NSMutableString stringWithString:place];
                [str1 insertString:@"," atIndex:0];
                NSLog(@"hhl:%@",[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"]);
                NSArray *placeArray=[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"];
                _placeMutableArray= [NSMutableArray array];
                for (int i=0; i<placeArray.count; i++) {
                    NSString *place=[Utils stringDeleteString:[placeArray objectAtIndex:i]];
                    NSLog(@"dddd%@",[Utils stringDeleteString:[placeArray objectAtIndex:i]]);
                    NSLog(@"www:%@", [Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","]);
                    NSArray *array=[Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","];
                    [_placeMutableArray addObject:array];
                }
                _mapNavigationView.mapTableView.tableViewdata=_placeMutableArray;
                [_mapNavigationView.mapTableView reloadData];
                [self addAnnotations];
            }
            NSLog(@"status.title:%@",_status.title);
            //             NSMutableArray *statusArray= [NSMutableArray array];
            //           [_pagerBasicView.userCollectionView reloadData];
        }else{
            NSLog(@"数据查询失败失败");
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        NSLog(@"数据查询失败");
    }];
}
#pragma mark - GPMapDelegate
- (void)mapButtonClick{
    
}
- (void)selectMapTableViewWithLatitude:(double)latitude withLongitude:(double)longitude withTitle:(NSString *)name withAddress:(NSString *)address{
    NSLog(@"u long %f,lat %f",longitude,latitude);
    //    if ([_mapNavigationView.annotationViewButton.titleLabel.text isEqualToString:@"确定"]) {
    //        [_mapNavigationView.mapView removeAnnotation:_mapNavigationView.annotation];
    //    }
    //    _mapNavigationView.buttonTitle=@"导航";
    //    [_mapNavigationView addAnnotation];
    //    CLLocationCoordinate2D coordinate={latitude,longitude};
    //    QCoordinateSpan span={0.1,0.1};
    //    QCoordinateRegion region={coordinate,span};
    //    [_mapNavigationView.mapView setRegion:region animated:YES];
    //    [_mapNavigationView.annotation setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
    //    [_mapNavigationView.annotation setTitle:name];
    //    [_mapNavigationView.mapView setCenterCoordinate:CLLocationCoordinate2DMake(latitude, longitude) zoomLevel:15 animated:YES];
    NSLog(@"u long %f,lat %f",longitude,latitude);
    NSLog(@"selectedAnnotations:%@",self.mapNavigationView.mapView.selectedAnnotations);
    //    [self.mapNavigationView.mapView.selectedAnnotations removeAllObjects];
    _isAdd=NO;
    //    [_mapNavigationView.annotationView setSelected:NO];
    //    //    _mapNavigationView.isSelect=NO;
    //    if ([_mapNavigationView.buttonTitle isEqualToString:@"确定"]) {
    //        [_mapNavigationView.annotations removeObject:_mapNavigationView.annotation];
    //        [_mapNavigationView.mapView removeAnnotation:_mapNavigationView.annotation];
    //    }
    //    if (!_mapNavigationView.isSelect) {
    //        [_mapNavigationView removeAnnotation];
    //    }
    if (_mapNavigationView.annotations.count==0) {
        //           [_mapNavigationView addAnnotation];
        _isAdd=YES;
        
    }else{
        for (QPointAnnotation *annotation in _mapNavigationView.annotations) {
            //         QPointAnnotation *annotation =[_mapNavigationView.annotations objectAtIndex:i];
            NSLog(@"annotation:%@",annotation.title);
            if (![annotation.title isEqualToString:name]) {
                
                _isAdd=YES;
            }
        }
    }
    if (_isAdd) {
        [_mapNavigationView addAnnotation];
    }
    
    //    if (_mapNavigationView.annotation.title isEqualToString:name) {
    //        [_mapNavigationView addAnnotation];
    //    }
    
    CLLocationCoordinate2D coordinate={latitude,longitude};
    QCoordinateSpan span={0.1,0.1};
    QCoordinateRegion region={coordinate,span};
    [_mapNavigationView.mapView setRegion:region animated:YES];
    [_mapNavigationView.annotation setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
    [_mapNavigationView.annotation setTitle:name];
    [_mapNavigationView.mapView setCenterCoordinate:CLLocationCoordinate2DMake(latitude, longitude) zoomLevel:15 animated:YES];
}
#pragma mark - 添加标注数组
- (void)addAnnotations{
    for (int i=0; i<_placeMutableArray.count-2; i++) {
        //        /_positionString,_placeLatitude,_placeLongitude,_positionDetailString,timeString
        /*  (
         "",
         "秀玉红茶坊(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)",
         "30.477810",
         "114.422790",
         "洪山区关山大道519号光谷天地",
         14369614
         )*/
        [_mapNavigationView addAnnotation];
        NSArray *placeArray=[_placeMutableArray objectAtIndex:i];
        double userLatitude=[[placeArray objectAtIndex:2] doubleValue];
        double userLongitude=[[placeArray objectAtIndex:3] doubleValue];
        NSString *positionString=[placeArray objectAtIndex:1];
        NSString *positionDetailString=[placeArray objectAtIndex:4];
        CLLocationCoordinate2D coordinate={userLatitude,userLongitude};
        QCoordinateSpan span={0.1,0.1};
        QCoordinateRegion region={coordinate,span};
        [_mapNavigationView.mapView setRegion:region animated:YES];
        [_mapNavigationView.annotation setCoordinate:CLLocationCoordinate2DMake(userLatitude, userLongitude)];
        [_mapNavigationView.annotation setTitle:positionString];
        [_mapNavigationView.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLatitude, userLongitude) zoomLevel:15 animated:YES];
    }
}
#pragma mark - 地址转换
- (void)_initplace{
    //[self.mapNavigationView setNeedsDisplay];

    NSLog(@"place.status:%@",self.status);
    NSString *place=_status.place;
    if (![Utils isNullOfInput:place]) {
        NSMutableString *str1 = [NSMutableString stringWithString:place];
        [str1 insertString:@"," atIndex:0];
        NSLog(@"hhl:%@",[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"]);
        NSArray *placeArray=[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"];
        _placeMutableArray= [NSMutableArray array];
        for (int i=0; i<placeArray.count; i++) {
            NSString *place=[Utils stringDeleteString:[placeArray objectAtIndex:i]];
            NSLog(@"dddd%@",[Utils stringDeleteString:[placeArray objectAtIndex:i]]);
            NSLog(@"www:%@", [Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","]);
            NSArray *array=[Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","];
            [_placeMutableArray addObject:array];
        }
        NSLog(@"_placeMutableArray:%@",_placeMutableArray);
        _mapNavigationView.mapTableView.tableViewdata=_placeMutableArray;
        [_mapNavigationView.mapTableView reloadData];
//     [self addAnnotations];
    }

}
- (NSMutableArray *)placeMutableArray{
    NSLog(@"place.status:%@",self.status);
    NSString *place=_status.place;
    if (![Utils isNullOfInput:place]) {
        NSMutableString *str1 = [NSMutableString stringWithString:place];
        [str1 insertString:@"," atIndex:0];
        NSLog(@"hhl:%@",[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"]);
        NSArray *placeArray=[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"];
        _placeMutableArray= [NSMutableArray array];
        for (int i=0; i<placeArray.count; i++) {
            NSString *place=[Utils stringDeleteString:[placeArray objectAtIndex:i]];
            NSLog(@"dddd%@",[Utils stringDeleteString:[placeArray objectAtIndex:i]]);
            NSLog(@"www:%@", [Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","]);
            NSArray *array=[Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","];
            [_placeMutableArray addObject:array];
        }
    }
        return _placeMutableArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
