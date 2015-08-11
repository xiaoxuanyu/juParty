//
//  CLMainViewController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/14.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLMainViewController.h"
#import "JXBAdPageView.h"
#import "CLMainCell.h"
#import "CLTitleButton.h"
#import "CLPopViewController.h"
#import "CLCenterViewController.h"
#import "BasicInformationViewController.h"
#import "GPPagerViewController.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "CLStatus.h"
#import "CheckPartyViewController.h"
#import "GPPagerViewController.h"

@interface CLMainViewController()<UITableViewDataSource,UITableViewDelegate,MainCellCilckDelegate,JXBAdPageViewDelegate>


@property(nonatomic,weak) CLTitleButton *titleButton;

@property(nonatomic,strong) NSMutableArray *statuses;
@property(nonatomic,strong) NSMutableArray *partyArray;
@property(nonatomic,assign)int page;

@end


@implementation CLMainViewController

//-(NSMutableArray *)statuses
//{
//    if (_statuses == nil) {
//        _statuses = [NSMutableArray array];
//    }
//    return _statuses;
//}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _partyArray = [NSMutableArray array];
    self.page=1;
   // Tue Jul 07 2015 09:42:09 GMT 0800 (CST)
    NSDate *date = [NSDate date];
    
    //时区转换，取得系统时区，取得格林威治时间差秒
   NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    //NSLog(@"%f",timeZoneOffset/60.0/60.0);
    
    date = [date dateByAddingTimeInterval:timeZoneOffset];
    //Tue Jul 07 2015 09:54:48 GMT 0800 (CST)
    NSLog(@"status:%@",[Utils stringFromFomate:[NSDate date] formate:@"E MMM dd YYYY HH:mm:ss 'GMT 0800 (CST)'"]);
      NSLog(@"status:%@",[Utils dateFromFomate:@"2015 09:10:03" formate:@"yyyy HH:mm:ss"]);
    [self.view setBackgroundColor:[Utils colorWithHexString:@"#dddddd"]];
    [self.tableView setBackgroundColor:[Utils colorWithHexString:@"#dddddd"]];
    JXBAdPageView* adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,fDeviceHeight/3)];
    [adView startAdsWithBlock:@[@"m1",@"m2",@"m3",@"m4",@"m5"] block:^(NSInteger clickIndex){
        NSLog(@"%ld",(long)clickIndex);
    }];
    self.tableView.tableHeaderView = adView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self setUpTableView];
    [self setUpNavgationBar];
//    [self loadNewStatus];
//    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
//    [self.tableView headerBeginRefreshing];
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self setupRefresh];
//
}
/**
 * 集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    [self.tableView.header setTitle:@"Pull down to refresh" forState:MJRefreshHeaderStateIdle];
//    [self.tableView.header setTitle:@"松开马上刷新了" forState:MJRefreshHeaderStatePulling];
//    [self.tableView.header setTitle:@"正在刷新中。。。" forState:MJRefreshHeaderStateRefreshing];
//    [self.tableView.footer setTitle:@"上拉可以加载更多数据了" forState:MJRefreshFooterStateIdle];
////    [self.tableView.footer setTitle:@"松开马上加载更多数据了" forState:footerReleaseToRefreshText];
//    [self.tableView.footer setTitle:@"正在加载中。。。" forState:MJRefreshFooterStateRefreshing];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
//    // 1.添加假数据
//    for (int i =0; i<5; i++) {
//        [self.fakeData insertObject:MJRandomData atIndex:0];
//    }
    self.page=1;
      _partyArray = [NSMutableArray array];
      [self loadNewStatus];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
//    // 1.添加假数据
//    for (int i =0; i<5; i++) {
//        [self.fakeData addObject:MJRandomData];
//    }
     self.page=self.page+1;
    [self loadNewStatus];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}
-(void)loadNewStatus
{
//    String dateStr = "Fri, 02-Jan-2020 00:00:00 GMT"; Tue Jul 07 2015 09:42:09 GMT 0800 (CST)
//_statuses = [NSMutableArray array];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"page"]=[NSNumber numberWithDouble:self.page];
    params[@"size"]=[NSNumber numberWithInt:5];
    [HttpTool getWithURL:Url_qureyMianParty params:params success:^(id json) {
//        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
 [self.tableView headerEndRefreshing];
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpJuhui"];
            NSMutableArray *statusArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                CLStatus *status=[CLStatus objectWithKeyValues:dict];
                [statusArray addObject:status];
               
            }
            
             [self.partyArray addObjectsFromArray:statusArray];//把weiboArray追加到weibos上
//            self.partyArray=statusArray;
          
            self.statuses=self.partyArray;
//            self.partyArray=statusArray;//把获取的微博传给weiboArray
//            if (statusArray.count>0) {
//                //获取最新微博的id
//                CLStatus *topWeibo= [statusArray objectAtIndex:0];
//                self.topWeiboId=[topWeibo.weiboId stringValue];
//                WeiboModel *lastWeibo= [weibos lastObject];
//                self.lastWeiboId=[lastWeibo.weiboId stringValue];
//            }
//            NSLog(@"%@",statusArray);
            [self.tableView reloadData];
        }else{
            NSLog(@"数据查询失败失败");
//            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [a show];
        }
    } failure:^(NSError *error) {
          NSLog(@"数据查询失败");
    }];
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//
////    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [mgr GET:@"http://192.168.20.138:8089/SSM/Front/gp_juhui_query?page=1&size=5" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self.tableView headerEndRefreshing];
//        
//        NSArray *dicArr = responseObject[@"GpJuhui"];
//        
//        NSLog(@"%@",dicArr);
//
//        NSArray *GpJuhui = (NSMutableArray *)[CLStatus objectArrayWithKeyValuesArray:dicArr];
//        
////        NSLog(@"%lu",(unsigned long)self.statuses.count);
//         NSIndexSet *indeSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, GpJuhui.count)];
//        
//        [self.statuses insertObjects:GpJuhui atIndexes:indeSet];
//
////        NSLog(@"%lu",(unsigned long)self.statuses.count);
//        
//        [self.tableView reloadData];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    
    
    
    
    
    
}

-(void)setUpNavgationBar
{
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigation__icon_release"] highImage:[UIImage imageNamed:@"navigation__icon_release_grey"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
     //titleView
    CLTitleButton *titleButton = [CLTitleButton buttonWithType:UIButtonTypeCustom];
//    titleButton.frame=CGRectMake(fDeviceWidth-30/2, 10, 30, 20);
//    _titleButton = titleButton;
    
    [titleButton setTitle:@"聚派" forState:UIControlStateNormal];
   [titleButton setImage:[UIImage imageNamed:@"Remind_icon_reddot"] forState:UIControlStateNormal];
   
    //高亮时候不需要调整图片
     titleButton.adjustsImageWhenHighlighted = NO;
     [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.titleView = titleButton;
    

}
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    NSLog(@"Click");
    CLPopViewController *popvc = [[CLPopViewController alloc] init];
    
    [self.navigationController pushViewController:popvc animated:YES];
    
}
- (void)pop
{
    BasicInformationViewController *baisicCtrl=[[BasicInformationViewController alloc] init];
    [self.navigationController pushViewController:baisicCtrl animated:YES];
    //接入 发起聚会
    NSLog(@"right");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    NSLog(@"%lu",(unsigned long)self.statuses.count);
    return self.statuses.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Main";
    CLMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CLMainCell" owner:nil options:nil] firstObject];
        
    }
    CLStatus *status = self.statuses[indexPath.section];
    
   

    cell.backgroundColor = [UIColor lightGrayColor];
    cell.delegate = self;
    cell.status=status;

    return cell;


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckPartyViewController *pageCtrl = [[CheckPartyViewController alloc]init];
    CLStatus *status=self.statuses[indexPath.section];
    pageCtrl.status=status;
//    pageCtrl.partyType=checkParty;
    pageCtrl.partyId=status.ids;
    [self.navigationController pushViewController:pageCtrl animated:YES];
}
/**
 *  实现MainCell的代理方法
 */
- (void)CenterDidClick:(CLStatus *)status{
    CLCenterViewController *centervc = [[CLCenterViewController alloc]init];
    centervc.userID=status.plannerId;
    centervc.imgUrl=status.plannerHeadurl;
    centervc.userName=status.plannerName;
    [self.navigationController pushViewController:centervc animated:YES];
}

@end
