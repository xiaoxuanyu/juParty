//
//  BasicInformationViewController.m
//  GPCollectionView
//
//  Created by yintao on 15/5/26.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "MapNavigationViewController.h"
#import "UIViewController+HUD.h"
#import "CLAccountTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
@interface BasicInformationViewController ()

@end

@implementation BasicInformationViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"基本信息";
        self.view.backgroundColor=[Utils colorWithHexString:@"#ededed"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    ///添加collectionView
//    float header_height=basicHeader_hight;
//    float fotter_height=30;
//    UICollectionViewFlowLayout *flowLayout1=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
//    ///头部
//    flowLayout1.headerReferenceSize=CGSizeMake(fDeviceWidth, header_height);
//    ///尾部
//    flowLayout1.footerReferenceSize=CGSizeMake(50, fotter_height+10);
//    self.userCollectionView=[[UserCollectionView alloc] initWithFrame:CGRectMake(0,0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout1];
//    self.userCollectionView.header_height=header_height;
//    self.userCollectionView.footer_height=fotter_height;
//    [self.view addSubview:self.userCollectionView];
    self.basicView=[[BasicView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight)];
    [self.view addSubview:self.basicView];
    
    ///添加导航栏右侧“下一页”按钮
    [self _initBarButtonItem];
    ///添加数据
    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
    for (int i=0; i<=3; i++) {

        // NSLog(@"userInfo:%@",userInfo.nikename);
        [dataArray addObject:self.userInfo];
    }
 
//    self.userCollectionView.collectionViewdatadata=dataArray;
//    [self.userCollectionView reloadData];
//    [self getWeatherInformation];
    //设置MapView的委托为自己
    self.mapView=[[QMapView alloc] init];
    [self.mapView setDelegate:self];
    
    //标注自身位置
    [self.mapView setShowsUserLocation:YES];
    
}
/**
 * 添加导航栏右侧“下一页”按钮
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
//    rightButton.showsTouchWhenHighlighted=YES;
    [rightButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
}
/**
 *  点击“下一页”跳转到旋转地址页面
 *
 *  @param button UIButton对象
 */
- (void)nextAction:(UIButton *)button{
    MapNavigationViewController *mapCtrl=[[MapNavigationViewController alloc] init];
    NSString *themeText=self.basicView.themeText.text;
    NSString *detailText=self.basicView.detailTextView.text;
    mapCtrl.partyTitle=themeText;
    mapCtrl.partyContent=detailText;
    mapCtrl.partyTime=self.basicView.dateString;
    NSLog(@"self.basicView.dateString:%@",self.basicView.dateString);
    if([Utils isNullOfInput:themeText]){
        NSLog(@"主题不能为空");
        [self showHint:@"主题不能为空"];
    }
    else if ([Utils isNullOfInput:detailText]){
          NSLog(@"聚会内容不能为空");
         [self showHint:@"聚会内容不能为空"];
    }else{
         [self.navigationController pushViewController:mapCtrl animated:YES];
    }
}
- (void)getWeatherInformation:(double)userLatitude withUserLongitude:(double)userLongitude{
//    http://api.map.baidu.com/telematics/v3/weather?lat=30.479679&lng=114.417329&ak=s1ix8uDooeZENEbGwwkZzj2b&output=json
//    http://api.map.baidu.com/telematics/v3/weather?location=114.417329,30.479679&ak=s1ix8uDooeZENEbGwwkZzj2b&output=json
       NSLog(@"...... long %f,lat %f",userLongitude,userLatitude);
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"lat"]=[NSNumber numberWithDouble:userLatitude];
//    params[@"lng"]=[NSNumber numberWithDouble:userLongitude];
    params[@"location"]=[NSString stringWithFormat:@"%lf,%lf",userLongitude,userLatitude];
    params[@"ak"]=baidukey;
    params[@"output"]=@"json";
    [HttpTool getWeatherDataWithparams:params success:^(id json) {
        if ([json[@"status"] isEqualToString:@"success"]) {
            NSArray *weatherInfo = [GPWeatherModel objectArrayWithKeyValuesArray:json[@"results"]];
            //        NSLog(@"%@",weatherInfo);
            _weatherInfo = weatherInfo[0];
            
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            //用[NSDate date]可以获取系统当前时间
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"currentDateStr:%@",currentDateStr);
            _weatherInfo.date = currentDateStr;
            self.basicView.weatherInfo = _weatherInfo;
        }else{
            NSLog(@"加载天气失败!%@",json[@"status"]);
        }
    } failure:^(NSError *error) {
  NSLog(@"加载天气失败!");
    }];
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
    [self getWeatherInformation:_userLatitude withUserLongitude:_userLongitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
