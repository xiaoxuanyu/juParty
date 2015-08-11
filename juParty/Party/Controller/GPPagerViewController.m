//
//  GPPagerViewController.m
//  GPPagerViewController
//
//  Created by yintao on 15/5/14.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "GPPagerViewController.h"
#import "MapNavigationViewController.h"
#import "CLStatus.h"
#import "MJExtension.h"
#import "GPJoinUserModel.h"
#import "MBProgressHUD+MJ.h"
#import "UMSocial.h"
#import "GPImageModel.h"
#import "PhotoBroswerVC.h"
#import "CoreSVP.h"
#import "GPPartyHttpTool.h"
#import "BasicInformationViewController.h"
NSString *const MJTableViewCellIdentifier =@"Cell1";

/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]


@interface GPPagerViewController ()<UMSocialUIDelegate,GPMapDelegate,PhotoBroswerVCDelegate,publishCilckDelegate>

@property (strong,nonatomic) NSMutableArray *fakeData;
@end

@implementation GPPagerViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"活动";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden=YES;
    self.fakeData=[[NSMutableArray alloc]init];
    ///----上方滑动按钮--------
    _btn1=[[UIButton alloc]initWithFrame:CGRectMake(0,64, fDeviceWidth/3,40)];
    _btn1.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    // [_btn1 setBackgroundColor:[UIColor blackColor]];
    [_btn1 setTitleColor:GPTextColor forState:UIControlStateNormal];
    [_btn1 setTitle:@"基本信息" forState:UIControlStateNormal];
    _btn2=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth/3,64, fDeviceWidth/3,40)];
    _btn2.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [_btn2 setTitleColor:GPTextColor forState:UIControlStateNormal];
    [_btn2 setTitle:@"地图导航"forState:UIControlStateNormal];
    _btn3=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth/3*2,64, fDeviceWidth/3,40)];
    _btn3.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
    [_btn3 setTitleColor:GPTextColor forState:UIControlStateNormal];
    [_btn3 setTitle:@"活动相册"forState:UIControlStateNormal];
    ///----下方滑动条--------
    _imageLine=[[UIImageView alloc]initWithFrame:CGRectMake(0,99, fDeviceWidth/3,5)];
    [_imageLine setBackgroundColor:[Utils colorWithHexString:@"#f2cc1a"]];    ///-----添加scrollView-----
    _scrolview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,104, fDeviceWidth, fDeviceHeight-104)];
    _scrolview.delegate=self;
    _scrolview.pagingEnabled=YES;
    _scrolview.showsHorizontalScrollIndicator=NO;
    _scrolview.bounces=NO;
    _scrolview.contentSize=CGSizeMake(fDeviceWidth*3, fDeviceHeight-111);
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, fDeviceWidth, fDeviceHeight-104)];

    ///---添加基本信息界面-----
//    float header_height1=basicHeader_hight;
//    UICollectionViewFlowLayout *flowLayout1=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout1.headerReferenceSize=CGSizeMake(fDeviceWidth, header_height1);//头部
//    self.userCollectionView=[[UserCollectionView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-104) collectionViewLayout:flowLayout1];
//    self.userCollectionView.header_height=header_height1;
    self.pagerBasicView=[[PagerBasicView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-104)];
    self.pagerBasicView.delegate=self;
    [_scrolview addSubview:self.pagerBasicView];
//    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
//    //NSLog(@"userInfo:%@",userInfo.nikename);
//    for (int i=0; i<=10; i++) {
//        
//        // NSLog(@"userInfo:%@",userInfo.nikename);
//        [dataArray addObject:self.userInfo];
//    }
//    self.pagerBasicView.userCollectionView.collectionViewdata=dataArray;
//    [self.pagerBasicView.userCollectionView reloadData];

   ///-----添加地图界面------
   ///发送通知
     NSNumber *partyType=[NSNumber numberWithInteger:self.partyType];
    NSLog(@"partyType:%@",partyType);
    self.mapNavigationView=[[MapNavigationView alloc] initWithFrame:CGRectMake(fDeviceWidth, 0,fDeviceWidth, fDeviceHeight-104)];
    self.mapNavigationView.delegate=self;
    self.mapNavigationView.partyType=checkParty;
     //[self.mapNavigationView setNeedsDisplay];
     [_scrolview addSubview:self.mapNavigationView];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kPartyTpe object:partyType];
    ///--------添加相册界面---------
    float header_height=fDeviceHeight/2;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize=CGSizeMake(fDeviceWidth, header_height+10);//头部
    self.collectionView=[[CollectionView alloc] initWithFrame:CGRectMake(fDeviceWidth*2, 0, fDeviceWidth, fDeviceHeight-104) collectionViewLayout:flowLayout];
    self.collectionView.header_height=header_height;
    self.collectionView.publishDelegate=self;
    self.collectionView.partyType=checkParty;
    //[self.view addSubview:self.collectionView];
    [_scrolview addSubview:self.collectionView];
    
    [self.view addSubview:_btn1];
    [self.view addSubview:_btn2];
    [self.view addSubview:_btn3];
    [self.view addSubview:_scrolview];
    [self.view addSubview:_imageLine];
    [_btn1 setTag:101];
    [_btn2 setTag:102];
    [_btn3 setTag:103];
    [_btn1 addTarget:self action:@selector(btnClicked:)forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btnClicked:)forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(btnClicked:)forControlEvents:UIControlEventTouchUpInside];
       _isJoin=NO;
    [self queryPartyById];
    [self queryJoinPerson];
//    [self getWeatherInformation];
    [self getPartyImage];

}
/**
 *
 *  上方button点击事件
 *  @param sender UIButton对象
 */
-(void)btnClicked:(UIButton*)sender{
    int tag=[sender tag];
    if (tag==101) {
        [UIView animateWithDuration:0.5f animations:^{
            _imageLine.center=CGPointMake(self.view.bounds.size.width/6,_imageLine.center.y);
            _scrolview.contentOffset=CGPointMake(0,0);
        }];
        
    }
    else if (tag==102){
        [UIView animateWithDuration:0.5f animations:^{
            _imageLine.center=CGPointMake(self.view.bounds.size.width/2,_imageLine.center.y);
            _scrolview.contentOffset=CGPointMake(self.view.bounds.size.width,0);
        }];
    }
    else{
        [UIView animateWithDuration:0.5f animations:^{
            _imageLine.center=CGPointMake(self.view.bounds.size.width/6*5, _imageLine.center.y);
            _scrolview.contentOffset=CGPointMake(self.view.bounds.size.width*2,0);
        }];
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView*)scrollView{
    _imageLine.center=CGPointMake(scrollView.contentOffset.x/3+self.view.bounds.size.width/6, _imageLine.center.y);
}

#pragma mark - publishCilckDelegate
/**
 *  浏览图片
 *
 *  @param index 图片位置
 */
- (void)selectImage:(NSUInteger)index photosWallArray:(NSMutableArray *)photosWallArray{
    __weak typeof(self) weakSelf=self;
    
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:index userID:self.userID photosWallArray:photosWallArray photoBroswerDelegate:self photoModelBlock:^NSMutableArray *{
        NSLog(@"photosWallArray%@ index:%lu",photosWallArray,(unsigned long)index);
        NSMutableArray *photoArray=[photosWallArray  mutableCopy];
        if ([photoArray containsObject:self.collectionView.addImage]) {
            [photoArray removeObject:self.collectionView.addImage];
        }
//        NSArray *array=@[ @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg",
//                          @"http://www.netbian.com/d/file/20150505/5a760278eb985d8da2455e3334ad0c0f.jpg",
//                          @"http://www.netbian.com/d/file/20141006/e9d6f04046d483843d353d7a301d36f8.jpg",
//                          @"http://www.netbian.com/d/file/20130906/134dca4108f3f0ed10a4cc3f78848856.jpg",
//                          @"http://www.netbian.com/d/file/20121111/a03b9adb18a982f6a49aa7bfa7b82371.jpg",
//                          @"http://www.netbian.com/d/file/20130421/e0dabeee4e1e62fe114799bc7e4ccd66.jpg",
//                          @"http://www.netbian.com/d/file/20121012/c890c1da17bb5b4291e9733fad8efb42.jpg",
//                          @"http://www.netbian.com/d/file/20150318/c5c68492a4d6998229d1b6068c77951e.jpg0",
//                          @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg",
//                            @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg"];
        NSArray *networkImages=photoArray;
        NSLog(@"networkImages%@ index:%lu",networkImages,(unsigned long)index);
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];

        for (NSUInteger i = 0; i< networkImages.count; i++) {
               NSLog(@"networkImages%@ index:%d",networkImages[i],i);
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
//            //源frame
//            UIImageView *imageV =(UIImageView *) weakSelf.collectionView.subviews[i-1];
//            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
    
}
/**
 *  上传图片
 */
- (void)uploadImage:(UIImage *)image index:(NSInteger)index{
    
    //    UIImage *image;
    //    self.collectionView.selectImageBlock=^(UIImage *image){
    //        NSLog(@"dfdfdf");
    //    };
    //    self.collectionView.selectImageBlock=^(UIImage *image){
    //展示提示框
    [CoreSVP showSVPWithType:CoreSVPTypeLoadingInterface Msg:@"上传中" duration:0 allowEdit:NO beginBlock:nil completeBlock:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HttpTool uploadImageWithURL:Url_uploadImg1 params:nil image:image success:^(id json) {
            NSLog(@"json:%@",json);
            NSDictionary *dic=json;
            if ([[dic objectForKey:@"success"] boolValue]==1) {
                NSLog(@"上传照片墙图片成功");
                NSString  *url=dic[@"ossUrl"];
                NSLog(@"ossUrl:%@",url);
                
                            if ([_collectionView.photosWallArray containsObject:self.collectionView.addImage]) {
                            [_collectionView.photosWallArray removeObject:self.collectionView.addImage];
                            }
                           [_collectionView.photosWallArray addObject:url];
                
                             [_collectionView.photosWallArray addObject:_collectionView.addImage];
                
                //                if ([_collectionView.photosWallArray containsObject:self.collectionView.addImage]) {
                //                    [_collectionView.photosWallArray removeObject:self.collectionView.addImage];
                //                }
                //                      UIImage *image = [Utils image:savedImage rotation:UIImageOrientationDown];
                //                [_collectionView.photosWallArray addObject:url];
                //            [updataImageArray addObject:savedImage];
                //                if (_collectionView.photosWallArray.count < 4) {
                //                    for (int i=_collectionView.photosWallArray.count; i<4; i++) {
                //                              [_collectionView.photosWallArray addObject:_collectionView.addImage];
                //                    }
                
                //                }
                
//                [ _collectionView.photosWallArray replaceObjectAtIndex:index withObject:url];
                
                [self.collectionView reloadData];
                [self uplodeImageToAlbum:url];
                
            }else{
                //                NSLog(@"上传照片墙图片失败");
                //                UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                //                [a show];
                [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
            }
        } failure:^(NSError *error) {
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"上传照片墙图片失败" message:@"服务器无法连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
            //            NSLog(@"上传照片墙图片，服务器连接失败:%@",error);
            [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
        }];
    });
    //    };
}

#pragma mark - 网络请求
/**
 *  上传图片到相册service
 */
- (void)uplodeImageToAlbum:(NSString *)imgUrl{
    // http://112.124.12.201:8181/guangpai/home/api/tupian_add?juhui_id=1440&openid=oIYXxjpXKPtbDqnAFhA1-vsn6zkg&pic_url=http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/20150715-066758100d794.jpg
    NSLog(@"%@额外人口我惹我肉味儿苦命人胃口人民网%@",[NSString stringWithFormat:@"%d",self.partyId],self.userId);
    [GPPartyHttpTool postPartyImageWithId:[NSString stringWithFormat:@"%d",self.partyId] openId:self.userId imageUrl:(NSString *)imgUrl success:^(id json) {
        NSData *data = json;
        NSError *error;
        NSString *shabi =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"json:%@",shabi);
        //        NSLog(@"json:%@",shabi);
        //        NSDictionary *dic=json;
        //        NSLog(@"dic:%@",dic);
        [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"上传成功" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
    } failure:^(NSError *error) {
        [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
    }];
}

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
                        _pagerBasicView.userCollectionView.status=_status;
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

/**
 *  根据聚会id查询活动报名人员
 */
- (void)queryJoinPerson{
 
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"juhuiId"]=[NSNumber numberWithInt:self.partyId];
    [HttpTool getWithURL:Url_queryJoinPerson params:params success:^(id json) {
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpBaoming"];
            
            _userArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                GPJoinUserModel *user=[GPJoinUserModel objectWithKeyValues:dict];
                if ([user.joinId isEqualToString:self.userId]) {
                    _isJoin=YES;
                }
                [_userArray addObject:user];
                //                _userCollectionView.headerView.status=status;
                //                _userCollectionView.headerView.themeText.text=status.title;
                //                [_userCollectionView.headerView setNeedsDisplay];
                //                [_userCollectionView.headerView setNeedsLayout];
//                NSLog(@"%@",user.joinName);
            }
            _pagerBasicView.userCollectionView.collectionViewdata=_userArray;
            [_pagerBasicView.userCollectionView reloadData];
        }else{
            NSLog(@"数据查询失败失败");
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        NSLog(@"数据查询失败");
    }];
}
- (void)joinParty{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userId;
    params[@"userName"]=self.nikename;
    params[@"userHeadurl"]=self.headimgurl;
    params[@"juhuiId"]=[NSNumber numberWithInt:self.partyId];
    [HttpTool getWithURL:Url_joinParty params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            [MBProgressHUD showSuccess:@"报名成功"];
            [self queryJoinPerson];
        }else{
            [MBProgressHUD showError:@"网络错误！"];
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误！"];
        
    }];

}
//- (void)getWeatherInformation{
//    //    http://api.map.baidu.com/telematics/v3/weather?lat=30.479679&lng=114.417329&ak=s1ix8uDooeZENEbGwwkZzj2b&output=json
//    //    http://api.map.baidu.com/telematics/v3/weather?location=114.417329,30.479679&ak=s1ix8uDooeZENEbGwwkZzj2b&output=json
//    ///请求参数
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"lat"]=[NSNumber numberWithDouble:30.479679];
//    params[@"lng"]=[NSNumber numberWithDouble:114.417329];
//    params[@"location"]=[NSString stringWithFormat:@"%lf,%lf",114.417329,30.479679];
//    params[@"ak"]=baidukey;
//    params[@"output"]=@"json";
//    [HttpTool getWeatherDataWithparams:params success:^(id json) {
//        if ([json[@"status"] isEqualToString:@"success"]) {
//            NSArray *weatherInfo = [GPWeatherModel objectArrayWithKeyValuesArray:json[@"results"]];
//                 NSLog(@"%@",weatherInfo);
//            _weatherInfo = weatherInfo[0];
//            
//            //实例化一个NSDateFormatter对象
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            //设定时间格式,这里可以设置成自己需要的格式
//            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
//            //用[NSDate date]可以获取系统当前时间
//            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//            NSLog(@"currentDateStr:%@",currentDateStr);
//            _weatherInfo.date = currentDateStr;
//            self.pagerBasicView.userCollectionView.weatherInfo = _weatherInfo;
////            _pagerBasicView.userCollectionView
//        }else{
//            NSLog(@"加载天气失败!%@",json[@"status"]);
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"加载天气失败!");
//    }];
//}
- (void)getPartyImage{
    //http://192.168.20.138:8089/SSM/Front/gp_tupian_query_byjuhui?juhuiId=1440
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"juhuiId"]=[NSNumber numberWithInt:self.partyId];
    [HttpTool getWithURL:Url_queryImage params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
             NSArray *array=dic[@"GpTupian"];
            NSMutableArray *imageArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                GPImageModel *imageModel=[GPImageModel objectWithKeyValues:dict];
                 NSLog(@"GPImageModel:%@",imageModel);
                NSString *url=(NSString *)imageModel.picurl;
                [imageArray addObject:url];
            }
//            for (int i=0; i<=3; i++) {
//                [_collectionView.photosWallArray addObject:[UIImage imageNamed:@"basicUser.jpg"]];
//            }
//            if (imageArray.count<4) {
//                [_collectionView.photosWallArray replaceObjectsInRange:NSMakeRange(0, imageArray.count) withObjectsFromArray:imageArray];
//            }
            if (_isJoin) {
                [imageArray addObject:_collectionView.addImage];
            }
           _collectionView.photosWallArray=imageArray;
   
            NSLog(@"imageArray:%@",imageArray);
            [_collectionView reloadData];
        }else{
            [MBProgressHUD showError:@"网络错误！"];
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误！"];
        
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
- (void)getWeatherInformation:(double)userLatitude withUserLongitude:(double)userLongitude{
    //    http://api.map.baidu.com/telematics/v3/weather?lat=30.479679&lng=114.417329&ak=s1ix8uDooeZENEbGwwkZzj2b&output=json
    //    http://api.map.baidu.com/telematics/v3/weather?location=114.417329,30.479679&ak=s1ix8uDooeZENEbGwwkZzj2b&output=json
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"lat"]=[NSNumber numberWithDouble:30.479679];
//    params[@"lng"]=[NSNumber numberWithDouble:114.417329];
    params[@"location"]=[NSString stringWithFormat:@"%lf,%lf",userLongitude,userLatitude];
    params[@"ak"]=baidukey;
    params[@"output"]=@"json";
    [HttpTool getWeatherDataWithparams:params success:^(id json) {
        if ([json[@"status"] isEqualToString:@"success"]) {
            NSArray *weatherInfo = [GPWeatherModel objectArrayWithKeyValuesArray:json[@"results"]];
            NSLog(@"%@",weatherInfo);
            _weatherInfo = weatherInfo[0];
            
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            //用[NSDate date]可以获取系统当前时间
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"currentDateStr:%@",currentDateStr);
            _weatherInfo.date = currentDateStr;
            self.pagerBasicView.userCollectionView.weatherInfo = _weatherInfo;
            //            _pagerBasicView.userCollectionView
            [self.pagerBasicView.userCollectionView reloadData];
            
        }else{
            NSLog(@"加载天气失败!%@",json[@"status"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"加载天气失败!");
    }];

}
#pragma mark - partyButtonDelegate
/**
 *  点击套用按钮
 */
- (void)applyButtonClick{
    NSLog(@"fefmk");
    BasicInformationViewController *baisicCtrl=[[BasicInformationViewController alloc] init];
    baisicCtrl.basicView.themeText.text=_status.title;
    //    baisicCtrl.basicView.themeText.text=status.title;
    [self.navigationController pushViewController:baisicCtrl animated:YES];
}
/**
 *  点击报名按钮
 */
- (void)registrationButtonClick{
     NSLog(@"fefmk");
    if (_isJoin) {
        [MBProgressHUD showSuccess:@"你已经参加过此活动"];
    }else{
          [self joinParty];
    }
  
}
/**
 *  点击分享按钮
 */
- (void)shareButtonClick{
     NSLog(@"fefmk");
    [self Share];
}
#pragma mark - 分享
-(void)Share
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMSocialKey
                                      shareText:@"欢迎使用聚派!"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:self];
}
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
