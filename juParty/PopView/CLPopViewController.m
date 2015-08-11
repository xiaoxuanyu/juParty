//
//  CLPopViewController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/26.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLPopViewController.h"
#import "GPMessageModel.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
@interface CLPopViewController ()

@end

@implementation CLPopViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     self.title = @"消息";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=[[GPMessageTableView alloc] initWithFrame:CGRectMake(0, 0,fDeviceWidth,fDeviceHeight) style:UITableViewStylePlain];
    self.tableView.deleteMessageDelegate=self;
    [self.view addSubview:_tableView];
//    self.tableView.tableViewdata=[NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    [self _initBarButtonItem];
    [self setupRefresh];
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
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
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
//    self.page=1;
//    _partyArray = [NSMutableArray array];
    [self queryMessage];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}
/**
 * 添加导航栏右侧“编辑”按钮
 */
- (void)_initBarButtonItem{
    _rightButton=[[UIButton alloc] init];
    _rightButton.frame=CGRectMake(0, 0,70, 20);
    [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//   [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    UIFont *font=[UIFont boldSystemFontOfSize:17.0f];
    _rightButton.titleLabel.font = font;
    _rightButton.titleLabel.textAlignment=NSTextAlignmentRight;
    ///当按下出现高亮效果
    //    rightButton.showsTouchWhenHighlighted=YES;
    [_rightButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
}
- (void)editAction:(UIButton *)button{
    if ([_rightButton.titleLabel.text isEqualToString:@"编辑"]) {
        [ self.tableView setEditing:YES animated:YES ];
           [_rightButton setTitle:@"取消编辑" forState:UIControlStateNormal];
    }else if ([_rightButton.titleLabel.text isEqualToString:@"取消编辑"]){
        [ self.tableView setEditing: NO animated: YES ];
         [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
}
#pragma mark - deleteMessageDelegate
- (void)deleteMessageForRowAtIndexPath:(NSIndexPath *)indexPath messageModel:(GPMessageModel *)messgeModel{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"id"]=[NSNumber numberWithInt:messgeModel.messageId];
    [HttpTool getWithURL:Url_deleteMessage params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
             [MBProgressHUD showSuccess:@"删除成功"];
            [self.tableView.tableViewdata removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
            [self.tableView reloadData];
           
            
            //            [self queryJoinPerson];
        }else{
            [MBProgressHUD showError:@"网络错误！"];
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误！"];
        
    }];

}
//- (void)deleteMessageWithindex:(NSInteger)index messageModel:(GPMessageModel *)messgeModel{
//    ///请求参数
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"id"]=[NSNumber numberWithInt:messgeModel.juhuiId];
//    [HttpTool getWithURL:Url_deleteMessage params:params success:^(id json) {
//        //        NSLog(@"json:%@",json);
//        NSDictionary *dic=json;
//        if ([[dic objectForKey:@"success"] boolValue]==1) {
//             [self.tableView.tableViewdata removeObjectAtIndex:index];
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
//            [self reloadData];
//            [MBProgressHUD showSuccess:@"删除成功"];
//           
////            [self queryJoinPerson];
//        }else{
//            [MBProgressHUD showError:@"网络错误！"];
//            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            //            [a show];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"网络错误！"];
//        
//    }];
//}
#pragma mark - 网络请求
- (void)queryMessage{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userId;
    [HttpTool getWithURL:Url_queryMessage params:params success:^(id json) {
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpMessage"];
            
           _messagwArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                GPMessageModel *message=[GPMessageModel objectWithKeyValues:dict];
                [_messagwArray addObject:message];
                //                _userCollectionView.headerView.status=status;
                //                _userCollectionView.headerView.themeText.text=status.title;
                //                [_userCollectionView.headerView setNeedsDisplay];
                //                [_userCollectionView.headerView setNeedsLayout];
                //                NSLog(@"%@",user.joinName);
            }
            self.tableView.tableViewdata=_messagwArray;
            [self.tableView reloadData];
        }else{
            NSLog(@"数据查询失败失败");
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"数据查询失败");
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
