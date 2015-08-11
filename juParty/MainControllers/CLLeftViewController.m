//
//  CLLeftViewController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLLeftViewController.h"
#import "CLLeftCell.h"
#import "CLSettingItem.h"
#import "CLSettingController.h"
#import "CLFeedBackView.h"
#import "AppDelegate.h"
#import "CLActivityController.h"
#import "CLMainViewController.h"
#import "CLSlideViewController.h"
#import "CLAccount.h"
#import "CLAccountTool.h"
#import "CLUserInfo.h"
#import "BaseNavigationController.h"
#import "CLCenterViewController.h"
@interface CLLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *titles;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic ,strong) NSMutableArray *cellData;

@property(nonatomic,strong) CLSlideViewController *slider;

@end

@implementation CLLeftViewController

-(NSMutableArray *)cellData
{
    if (!_cellData) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _viewWidth=fDeviceWidth/2;
    self.titles = @[@"首页",@"活动管理",@"意见反馈",@"设置"];
    self.images = @[@"silding_ic_home",@"silding_icon_activity-management",@"silding_icon_feedback",@"silding_ic_setting"];
    
    CLSettingItem *item1 = [CLSettingItem itemWithIcon:nil title:nil vcClass:nil];
    CLSettingItem *item2 = [CLSettingItem itemWithIcon:nil title:nil vcClass:nil];
    CLSettingItem *item3 = [CLSettingItem itemWithIcon:nil title:nil vcClass:[CLSettingController class]];
    NSArray *group = @[item1,item2,item3];
    [self.cellData addObject:group];
    
    self.bgView.backgroundColor = [UIColor clearColor];
    self.picImgView.layer.cornerRadius = 30;
    self.picImgView.layer.masksToBounds = YES;
    //设置边框颜色
    self.picImgView.layer.borderColor=[UIColor whiteColor].CGColor;
    //设置边框宽度
    self.picImgView.layer.borderWidth=1.5f;
    self.picImgView.backgroundColor = [UIColor clearColor];
    self.picImgView.userInteractionEnabled=YES;
    [self.picImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picImgViewClick:)]];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor=[UIColor whiteColor];
    self.picImgView.image = CLIconImage;
    self.username.text = CLUserName;
    [self.username setTextColor:[Utils colorWithHexString:@"#4b4646"]];
    [self.username setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[Utils colorWithHexString:@"#dddddd"]];
    [self.tableView setBackgroundColor:[Utils colorWithHexString:@"#dddddd"]];
    [self.backgroundView setBackgroundColor:[Utils colorWithHexString:@"#dddddd"]];
//    [self.tableView registerNib:[UINib nibWithNibName:@"CLLeftCell" bundle:nil] forCellReuseIdentifier:@"CLLeftCell"];
    //设置tableView不能滚动
    self.tableView.scrollEnabled=NO;
    //ios tableview分割线到顶
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    //ios8 tableview分割线到顶,注意，此方法只能在xcode6上使用，xcode5上会报错
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    [self setExtraCellLineHidden:self.tableView];
    
}
#pragma mark - 隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CLLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CLLeftCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.titleView.text = [NSString stringWithFormat: @"%@",self.titles[indexPath.row]];
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[indexPath.row]]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      [self.separatorView setBackgroundColor:[UIColor whiteColor]];
//    cell.imageView.image = [UIImage imageNamed:@"LAMBORGHINI.jpg"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///选中cell后立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(CLLeftViewControllerDidChange)]) {
        [self.delegate CLLeftViewControllerDidChange];
    }
        AppDelegate *app = (AppDelegate*) [UIApplication sharedApplication].delegate;
  

    if (indexPath.row == 3) {
        CLSettingController *SttingVc = [[CLSettingController alloc]init];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:SttingVc];
        
//        [UIView animateWithDuration:0.5 animations:^{
        
            
            
            app.slider.rootViewController = nav;
//            
//        }];

    }else if (indexPath.row == 2)
    {
        CLFeedBackView *feedback = [[CLFeedBackView alloc]init];
        
        BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:feedback];
        
//        [UIView animateWithDuration:0.5 animations:^{
        

            
            app.slider.rootViewController = nav2;
//        }];
    }else if (indexPath.row == 1)
    {
        CLActivityController *activity = [[CLActivityController alloc]init];
        BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:activity];
//        [UIView animateWithDuration:0.5 animations:^{

            app.slider.rootViewController = nav3;
//        }];
    
    }else if (indexPath.row == 0)
    {
        CLMainViewController *mainview = [[CLMainViewController alloc]init];
        BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:mainview];
//        [UIView animateWithDuration:0.5 animations:^{
        

            
            app.slider.rootViewController = nav4;
//        }];
    
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
#pragma mark - actions
- (void)picImgViewClick:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"mmdkvm");
    if ([self.delegate respondsToSelector:@selector(CLLeftViewControllerDidChange)]) {
        [self.delegate CLLeftViewControllerDidChange];
    }
      AppDelegate *app =(AppDelegate *) [UIApplication sharedApplication].delegate;
    CLCenterViewController *centerCtrl=[[CLCenterViewController alloc] init];
    centerCtrl.isBackButton=NO;
    centerCtrl.userID=self.userId;
//    centerCtrl.userID=status.plannerId;
    centerCtrl.imgUrl=self.headimgurl;
     centerCtrl.userName=self.nikename;
    BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:centerCtrl];
    //        [UIView animateWithDuration:0.5 animations:^{
    
//    app.slider.isShow=NO;
    
    app.slider.rootViewController = nav4;
}

@end
