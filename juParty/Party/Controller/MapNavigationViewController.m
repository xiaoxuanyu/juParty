//
//  MapNavigationViewController.m
//  GPCollectionView
//
//  Created by yintao on 15/5/26.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "MapNavigationViewController.h"
#import "GPPartyHttpTool.h"
#import "UIViewController+HUD.h"
#import "GPDPHttpTool.h"
#import "MBProgressHUD+MJ.h"
@interface MapNavigationViewController ()<GPMapDelegate>
@property (nonatomic, strong) NSMutableArray *showingBusiness_ids;
@property (nonatomic, copy) NSString *currentBusiness_id;
@end

@implementation MapNavigationViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"选择地点";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _isSelect=NO;
    _annotations=[NSMutableArray array];
    _placeArray=[NSMutableArray array];
    NSLog(@"%@",self.partyTime);
    // Do any additional setup after loading the view.
    ///添加地图View
    self.mapNavigationView=[[MapNavigationView alloc] initWithFrame:CGRectMake(0,64,fDeviceWidth, fDeviceHeight-64)];
    self.mapNavigationView.delegate=self;
//    self.mapNavigationView.mapTableView.delegate=self;
    [self.view addSubview:self.mapNavigationView];
    self.mapNavigationView.mapTableView.partyType=0;
    ///添加导航栏右侧“下一页”按钮
    [self _initBarButtonItem];
//    [self getBusinessInformation];
}
/**
 *  添加导航栏右侧“下一页”按钮
 */
- (void)_initBarButtonItem{
    UIButton *rightButton=[[UIButton alloc] init];
    rightButton.frame=CGRectMake(0, 0,60, 20);
    [rightButton setTitle:@"下一页" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    UIFont *font=[UIFont boldSystemFontOfSize:17.0f];
    rightButton.titleLabel.font = font;
    ///当按下出现高亮效果
    rightButton.showsTouchWhenHighlighted=YES;
    [rightButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
}
///**
// *  为View添加手势
// */
//- (void)_addTapGesture{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidKeyBord:)];
//    [self.view addGestureRecognizer:tap];
//}
///**
// *  点击背景隐藏键盘
// *
// *  @param t 点击事件
// */
//- (void)hidKeyBord:(UITapGestureRecognizer *)t{
//    if (self.mapNavigationView.searchBar.isFirstResponder) {
//        [self.mapNavigationView.searchBar resignFirstResponder];
//    }
//}
/**
 *  点击“下一页”跳转到旋转地址页面
 *
 *  @param button UIButton对象
 */
- (void)nextAction:(UIButton *)button{
    _imageAlbumCtrl=[[ImageAlbumViewController alloc] init];
    _imageAlbumCtrl.collectionView.partyType=startParty;
    NSLog(@"%@",self.partyTime);
    NSLog(@"%@",self.partyTitle);

    [self _initPlace];
    if ([Utils isNullOfInput:_partyPlace]) {
       [self showHint:@"请选择聚会地点"];
    }else{
          [self postPartyInformation];
         [self.navigationController pushViewController:_imageAlbumCtrl animated:NO];
    }
}
/**
 *  把地址实例化字符串
 */
- (void)_initPlace{
    for (GPPlaceModel *placeModel in _placeArray) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSInteger time1 = round(time)/100;
        NSString *timeString= [NSString stringWithFormat:@"%ld", (long)time1];
        NSString *placeString=[NSString stringWithFormat:@"['%@','%f','%f','%@','%@']",placeModel.positionString,placeModel.placeLatitude,placeModel.placeLongitude,placeModel.positionDetailString,timeString];
        if ([Utils isNullOfInput:_partyPlace]) {
            _partyPlace=[NSString stringWithFormat:@"[%@]",placeString];
            _partyPlace1=[NSString stringWithFormat:@"%@",placeString];
        }else{
            _partyPlace=[NSString stringWithFormat:@"[%@,%@]",_partyPlace1,placeString];
            _partyPlace1=[NSString stringWithFormat:@"%@,%@",_partyPlace1,placeString];
        }
    }
    NSLog(@"partyPlace:%@",self.partyPlace);
}
/**
 *  发送聚会信息
 */
- (void)postPartyInformation{
//    self.partyPlace=@"武汉万达广场汉街店";
    NSLog(@"placeArray%@",self.placeArray);

    [GPPartyHttpTool postPartyInformation:self.userId userName:self.nikename userHeadurl:self.headimgurl title:self.partyTitle time:self.partyTime place:self.partyPlace success:^(id json) {
        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        _partyId=dic[@"id"];
        NSLog(@"partyId:%@",_partyId);
        self.imageAlbumCtrl.partyId=self.partyId;
    } failure:^(NSError *error) {
        [self showHint:@"信息发送失败"];
    }];
}
#pragma mark - GPMapDelegate
- (void)mapButtonClick{
    NSLog(@"enjrwoinh");
//    if(self.mapNavigationView.mapView.selectedAnnotations.count>0){
//        if ([_mapNavigationView.annotationViewButton.titleLabel.text isEqualToString:@"删除"]){
////            [_mapNavigationView.annotationViewButton setTitle:@"确定" forState:UIControlStateNormal];
//            _mapNavigationView.isSelect=NO;
//        }
//    }
//    for (UIView *vw in _mapNavigationView.annotationView.rightCalloutAccessoryView.subviews) {
//        
//        if ([vw isKindOfClass:[UIButton class]]) {
//            
//            UIButton *imView = (UIButton *)vw;
//            NSLog(@"VM%@",imView.titleLabel.text);
//        }
//    }
//        for (UIButton *button in _mapNavigationView.annotationView.rightCalloutAccessoryView.subviews) {
//            NSLog(@"enjrwoinh确定%@",button.tit);
//        }
  if ([_mapNavigationView.buttonTitle isEqualToString:@"确定"]) {
        NSLog(@"enjrwoinh确定");
        if (_mapNavigationView.annotations.count>3) {
            [MBProgressHUD showError:@"聚会地点超过三个"];
            [_mapNavigationView.annotations removeObjectAtIndex:_mapNavigationView.index];
//             [_mapNavigationView.mapView removeAnnotation:_mapNavigationView.annotation];
        }else{
            //        NSLog(@"gbb5%d",[_mapView.selectedAnnotations count]);
            //
            //        for (int i=0; i<[_annotations count]; i++) {
            //            if ([[_annotations objectAtIndex:i] isEqualToString:_positionString]) {
            //                NSLog(@"已添加过该地点");
            //                [_mapNavigationView.mapView removeAnnotation:_annotation];
            //            }
            //            [_annotations addObject:_annotation.title];
            //
            //        }
            //
            //        //        ['晶靓亮蒸虾','30.59382','114.30377','江岸区中山大道公安路口','14684199']
            
//            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//            NSInteger time1 = round(time)/100;
//            NSString *timeString= [NSString stringWithFormat:@"%ld", (long)time1];
//            NSString *placeString=[NSString stringWithFormat:@"['%@','%f','%f','%@','%@']",_positionString,_placeLatitude,_placeLongitude,_positionDetailString,timeString];
//            if ([Utils isNullOfInput:_partyPlace]) {
//                _partyPlace=[NSString stringWithFormat:@"[%@]",placeString];
//                _partyPlace1=[NSString stringWithFormat:@"%@",placeString];
//            }else{
//                _partyPlace=[NSString stringWithFormat:@"[%@,%@]",_partyPlace1,placeString];
//                _partyPlace1=[NSString stringWithFormat:@"%@,%@",_partyPlace1,placeString];
//            }
            
            GPPlaceModel *placeModel=[[GPPlaceModel alloc] init];
            placeModel.positionString=_positionString;
             placeModel.placeLatitude=_placeLatitude;
             placeModel.placeLongitude=_placeLongitude;
             placeModel.positionDetailString=_positionDetailString;
            [_placeArray addObject:placeModel];
            NSLog(@"_placeArray:%@",_placeArray);
            //        NSArray *labelArray=[[NSArray alloc] initWithObjects:@"11", @"bb",nil];
            //        [_placeArray addObjectsFromArray:labelArray];
            //           NSLog(@"fwkfkk%@",_placeArray);
            _mapNavigationView.isSelect=YES;
            [_mapNavigationView.annotationViewButton setTitle:@"删除" forState:UIControlStateNormal];
            _mapNavigationView.buttonTitle=@"删除";
                [_mapNavigationView.annotationView setSelected:NO];
        }
  
        
    }else if ([_mapNavigationView.buttonTitle isEqualToString:@"删除"]){
        NSLog(@"enjrwoinh删除");
        _mapNavigationView.isSelect=NO;
//        [_mapNavigationView.annotationViewButton setTitle:@"确定" forState:UIControlStateNormal];
        NSLog(@"_annotationtitle:%@",_mapNavigationView.annotation.title);
        _mapNavigationView.buttonTitle=@"确定";
         [_mapNavigationView removeAnnotation];
          [_placeArray removeObjectAtIndex:_mapNavigationView.index];
    }
}

- (void)selectMapTableViewWithLatitude:(double)latitude withLongitude:(double)longitude withTitle:(NSString *)name withAddress:(NSString *)address{
    NSLog(@"u long %f,lat %f",longitude,latitude);
        NSLog(@"selectedAnnotations:%@",self.mapNavigationView.mapView.selectedAnnotations);
//    [self.mapNavigationView.mapView.selectedAnnotations removeAllObjects];
    _isAdd=NO;
    [_mapNavigationView.annotationView setSelected:NO];
//    _mapNavigationView.isSelect=NO;
    if ([_mapNavigationView.buttonTitle isEqualToString:@"确定"]) {
         [_mapNavigationView.annotations removeObject:_mapNavigationView.annotation];
        [_mapNavigationView.mapView removeAnnotation:_mapNavigationView.annotation];
    }
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
        _positionString=name;
        _positionDetailString=address;
    _placeLatitude=latitude;
    _placeLongitude=longitude;
}
- (void)getBusinessWithLatitude:(double)userLatitude withUserLongitude:(double)userLongitude{
    [[GPDPHttpTool sharedGPDPHttpTool] businessesWithLatitude:userLatitude longitude:userLongitude success:^(NSArray *businesses, int totalCount) {
                NSLog(@"userLatitude:%f",userLatitude);
                self.mapNavigationView.mapTableView.tableViewdata=[businesses mutableCopy];
                [self.mapNavigationView.mapTableView reloadData];
          } error:^(NSError *error) {
              
          }];

}
- (void)searchBusiness:(double)userLatitude withUserLongitude:(double)userLongitude keyword:(NSString *)keyword{
    [[GPDPHttpTool sharedGPDPHttpTool] businessesWithLatitude:userLatitude longitude:userLongitude keyword:keyword success:^(NSArray *businesses, int totalCount) {
        NSLog(@"userLatitudeBusiness:%f",userLatitude);
        if (businesses.count==0) {
            [MBProgressHUD showError:@"没有相关店铺"];
        }
            self.mapNavigationView.mapTableView.tableViewdata=[businesses mutableCopy];
            [self.mapNavigationView.mapTableView reloadData];
//        }
//        if (self.mapNavigationView.searchBar.isFirstResponder) {
//            [self.mapNavigationView.searchBar resignFirstResponder];
//        }
    
    } error:^(NSError *error) {
        
    }];
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
