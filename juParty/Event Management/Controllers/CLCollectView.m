//
//  CLCollectView.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLCollectView.h"
#import "CLStatus.h"
#import "MJExtension.h"
#import "CLMyActivityCell.h"
#import "GPPagerViewController.h"
#import "BasicInformationViewController.h"
@interface CLCollectView ()<UITableViewDelegate,UITableViewDataSource,ActivityCellDelegate>

@property(nonatomic,strong) UITableView *maintable;

@end

@implementation CLCollectView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUptable];
}

-(void)setUptable
{
//    UITableView *table1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-108)style:UITableViewStyleGrouped];
//    _maintable = table1;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self getCollectionParty];
}
/**
 * 当前用户收藏的活动
 */
- (void)getCollectionParty{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userId;
   //http://192.168.20.138:8089/SSM/Front/gp_collection_query?userId=oIYXxjh48WeqFqZ18Tkg6do7j78w
    [HttpTool getWithURL:Url_queryCollection params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpJuhui"];
            NSMutableArray *statusArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                CLStatus *status=[CLStatus objectWithKeyValues:dict];

                [statusArray addObject:status];
                
            }
            self.tableView.tableViewdata=statusArray;
//            self.statuses=statusArray;
            NSLog(@"%@",statusArray);
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
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableView.tableViewdata count];
 }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"CollectView";
    CLMyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CLMyActivityCell" owner:nil options:nil] lastObject];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.status=[self.tableView.tableViewdata objectAtIndex:indexPath.section];
    cell.delegate=self;
    return cell;
}
//- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
//{
//    cell.backgroundColor = indexPath.section % 2?[UIColor colorWithRed: 240.0/255 green: 240.0/255 blue: 240.0/255 alpha: 1.0]: [UIColor yellowColor];
//    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
    
}

///选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///选中cell后立即取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GPPagerViewController *pageCtrl = [[GPPagerViewController alloc]init];
    CLStatus *status=self.tableView.tableViewdata[indexPath.section];
    pageCtrl.partyType=checkParty;
    pageCtrl.partyId=status.ids;
    [self.navigationController pushViewController:pageCtrl animated:YES];
    
}
#pragma mark - ActivityCellDelegate
- (void)buttonClick:(CLStatus *)status{
    NSLog(@"buttonClick%d",status.ids);
    BasicInformationViewController *baisicCtrl=[[BasicInformationViewController alloc] init];
    baisicCtrl.basicView.themeText.text=status.title;
//    baisicCtrl.basicView.themeText.text=status.title;
    [self.navigationController pushViewController:baisicCtrl animated:YES];
    
}
@end
