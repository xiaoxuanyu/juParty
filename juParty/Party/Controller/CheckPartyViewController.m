//
//  CheckPartyViewController.m
//  juParty
//
//  Created by yintao on 15/8/7.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CheckPartyViewController.h"

#import "MJExtension.h"
@interface CheckPartyViewController ()

@end

@implementation CheckPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabedSlideView=[[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight-64)];
    self.tabedSlideView.delegate=self;
    [self.view addSubview:_tabedSlideView];
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = GPTextColor;
    self.tabedSlideView.tabItemSelectedColor = GPTextColor;
    self.tabedSlideView.tabbarTrackColor = [Utils colorWithHexString:@"#f2cc1a"];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    //    self.tabedSlideView.tabbarHeight=44;
    //    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"基本信息" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"地图导航" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"活动相册" image:nil selectedImage:nil];
    
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
//      [self queryPartyById];
    
}
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
      
        case 0:
        {
          
            _pagerCtrl=[[PagerBasicViewController alloc] init];
            _pagerCtrl.partyId=self.partyId;
            _pagerCtrl.status=self.status;
            return _pagerCtrl;
        }
        case 1:
        {
           _mapCtrl=[[MapViewController alloc] init];
            //[self.mapNavigationView setNeedsDisplay];
             _mapCtrl.partyId=self.partyId;
            _mapCtrl.status=self.status;
  NSLog(@"ctrl1.status:%@",self.status);
            return _mapCtrl;
        }
        case 2:
        {
           _imageCtrl=[[ImageViewController alloc] init];
             _imageCtrl.partyId=self.partyId;
            _imageCtrl.status=self.status;
            return _imageCtrl;
        }
            
        default:
            return nil;
    }
}
///**
// *  根据聚会id查询聚会信息
// */
//- (void)queryPartyById{
//    ///请求参数
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"id"]=[NSNumber numberWithInt:self.partyId];
//    [HttpTool getWithURL:Url_queryPartyById params:params success:^(id json) {
//        //        NSLog(@"json:%@",json);
//        NSDictionary *dic=json;
//        if ([[dic objectForKey:@"success"] boolValue]==1) {
//            NSArray *array=dic[@"GpJuhui"];
//            
//            NSMutableArray *statusArray= [NSMutableArray array];
//            _status=[[CLStatus alloc] init];
//            for (NSDictionary *dict in array) {
//                _status=[CLStatus objectWithKeyValues:dict];
//                self.userID= _status.plannerId;
//                [statusArray addObject:_status];
//                //                _userCollectionView.headerView.status=status;
//                //                _userCollectionView.headerView.themeText.text=status.title;
//                //                [_userCollectionView.headerView setNeedsDisplay];
//                //                [_userCollectionView.headerView setNeedsLayout];
//            }
//            //            NSString *tt=@"[[川霸味道(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...),30.477997,114.41118,洪山区关山大道光谷天地2楼,5505744]]";
//            //            NSString *ww=@"[['秀玉红茶坊(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)','30.47805','114.4108','洪山区关山大道519号光谷天地','6055791'],['川霸味道(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)','30.477997','114.41118','洪山区关山大道光谷天地2楼','5505744'],['老村长私募菜(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)','30.47747','114.41092','洪山区关山大道光谷天地F3区29号','5601249']]";
//            NSString *place=_status.place;
//            if (![Utils isNullOfInput:place]) {
//                NSMutableString *str1 = [NSMutableString stringWithString:place];
//                [str1 insertString:@"," atIndex:0];
//                NSLog(@"hhl:%@",[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"]);
//                NSArray *placeArray=[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"];
//                _placeMutableArray= [NSMutableArray array];
//                for (int i=0; i<placeArray.count; i++) {
//                    NSString *place=[Utils stringDeleteString:[placeArray objectAtIndex:i]];
//                    NSLog(@"dddd%@",[Utils stringDeleteString:[placeArray objectAtIndex:i]]);
//                    NSLog(@"www:%@", [Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","]);
//                    NSArray *array=[Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","];
//                    [_placeMutableArray addObject:array];
//                }
////               _mapCtrl.mapNavigationView.mapTableView.tableViewdata=_placeMutableArray;
////                [_mapCtrl.mapNavigationView.mapTableView reloadData];
//////                [self addAnnotations];
//            }
//             _pagerCtrl.pagerBasicView.userCollectionView.status=_status;
//            _pagerCtrl.status=self.status;
//            NSLog(@"ctrl1.status:%@",self.status);
////            _pagerBasicView.userCollectionView.status=_status;
////            NSLog(@"status.title:%@",_status.title);
//            //             NSMutableArray *statusArray= [NSMutableArray array];
//            //           [_pagerBasicView.userCollectionView reloadData];
//        }else{
//            NSLog(@"数据查询失败失败");
//            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            //            [a show];
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"数据查询失败");
//    }];
//}

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
