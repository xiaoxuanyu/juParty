//
//  PagerBasicViewController.m
//  juParty
//
//  Created by yintao on 15/8/7.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "PagerBasicViewController.h"
#import "UMSocial.h"
#import "BasicInformationViewController.h"
#import "MBProgressHUD+MJ.h"
#import "GPJoinUserModel.h"
#import "MJExtension.h"
@interface PagerBasicViewController ()<partyButtonDelegate,UMSocialUIDelegate>{
        BOOL _isJoin;
}

@end

@implementation PagerBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pagerBasicView=[[PagerBasicView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-108)];
    self.pagerBasicView.delegate=self;
    [self.view addSubview:self.pagerBasicView];
    _isJoin=NO;
//    [self queryPartyById];
//    _pagerBasicView.userCollectionView.status=_status;
//    NSLog(@"status.title:%@",_status.title);
//    [_pagerBasicView layoutSubviews];
    [self queryJoinPerson];
     _pagerBasicView.userCollectionView.status=_status;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

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
//                _mapNavigationView.mapTableView.tableViewdata=_placeMutableArray;
//                [_mapNavigationView.mapTableView reloadData];
//                [self addAnnotations];
            }
            _pagerBasicView.userCollectionView.status=_status;
            NSLog(@"status.title:%@",_status.title);
            [_pagerBasicView layoutSubviews];
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
///报名
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
