//
//  CLSettingController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/22.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLSettingController.h"
#import "CLSettingItem.h"
#import "CLContactUsView.h"
#import "UMSocial.h"
#import "MBProgressHUD+Extend.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "CLCleanCell.h"
#import "CLOAuthController.h"
#import "CLAccountTool.h"
@interface CLSettingController ()<UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray *cellData;

@end

@implementation CLSettingController



-(instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

-(NSMutableArray *)cellData
{
    if (_cellData == nil) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    CLSettingItem *item1 = [CLSettingItem itemWithIcon:nil title:@"清理缓存"];
    item1.operation = ^()
    {
    
        [MBProgressHUD showMessage:@"正在帮您清理..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self clearCache];
//            NSLog(@"%@",[self getCachePath]);
            [MBProgressHUD showSuccess:@"清除成功啦╭(╯3╰)╮"];
        });

    
    };
    

    
    NSArray *group1 = @[item1];
    [self.cellData addObject:group1];
    
    CLSettingItem *item2 = [CLSettingItem itemWithIcon:nil title:@"分享APP给好友"];
    CLSettingItem *item3 = [CLSettingItem itemWithIcon:nil title:@"联系我们" vcClass:[CLContactUsView class]];
    NSArray *group2 = @[item2,item3];
    [self.cellData addObject:group2];
   self.navigationItem.title = @"设置";
    self.view.backgroundColor=[Utils colorWithHexString:@"#ededed"];
    self.tableView.backgroundColor=[Utils colorWithHexString:@"#ededed"];
    [self addExitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.cellData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    NSArray *group = self.cellData[section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"setting";
    CLCleanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.section<=self.cellData.count) {
     
        if (cell == nil) {
            
            cell = [[CLCleanCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
        }
        //    if (indexPath.section>self.cellData.count) {
        //        [self addExitButton];
        //    }
        
        cell.backgroundColor=[Utils colorWithHexString:@"#ffffff"];
        NSArray *group = self.cellData[indexPath.section];
        CLSettingItem *item = group[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = item.title;
        cell.textLabel.textColor=GPTextColor;
        if ([cell.textLabel.text isEqualToString:@"清理缓存"])
        {
            NSString *stringFloat = [NSString stringWithFormat:@"%.2fM",[self checkTmpSize]];
            cell.cache.text = stringFloat;
        }
        if ([cell.textLabel.text isEqualToString:@"联系我们"])
        {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

    }
       return cell;
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(15.0, 0.0, self.tableView.width, 40)];
    
    // create the button object
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = GPTextColor;
//    headerLabel.highlightedTextColor = [UIColor whiteColor];
//    headerLabel.font = [UIFont systemFontOfSize:20];
     headerLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
    headerLabel.frame = CGRectMake(15.0, 10, self.tableView.width, 20.0);
    
    // If you want to align the header text as centered
    // headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
    
    if (section==0) {
        headerLabel.text = @"系统设置"; // i.e. array element
            }else if(section==1){
             headerLabel.text = @"支持我们";
            }

    [customView addSubview:headerLabel];
    
    return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{ return 40; }
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{ return 0.00001; }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *group = self.cellData[indexPath.section];
    CLSettingItem *item = group[indexPath.row];
    if (item.operation) {

        item.operation();
        
    }else if(item.vcClass) {
        id vc = [[item.vcClass alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item.title isEqualToString:@"分享APP给好友"]) {
        [self Share];
    }

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
#pragma mark - 清理缓存

- (float)checkTmpSize
{
    float totalSize = 0;
    NSString *path = [self getCachePath];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath: path];
    
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath  = [path stringByAppendingPathComponent: fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath: filePath error: nil];
        unsigned long long length = [attrs fileSize];
        
        if([[[fileName componentsSeparatedByString: @"/"] objectAtIndex: 0] isEqualToString: @"URLCACHE"])
            continue;
        
        totalSize += length / 1024.0 / 1024.0;
    }
    if (totalSize < 3) {
        return 0;
    }
    return  totalSize;
}

-(NSString *)getCachePath
{
    //获取Cache路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}
- (void)clearCache
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager.imageCache clearDisk];
    [manager.imageCache clearMemory];
    //    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *base_path = [self getCachePath];
    //    NSString *path = [NSString stringWithFormat: @"%@/%@", base_path, identifier];
    [fileManager removeItemAtPath:base_path error: nil];
    
    //    tmpSize = [self checkTmpSize];
    [self.tableView reloadData];
}
#pragma mark - addButton
- (void)addExitButton{
    UIButton *exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame=CGRectMake((fDeviceWidth-170)/2,200+100 ,170 ,55 );
    [exitButton.layer setMasksToBounds:YES];
    [exitButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//    [exitButton.layer setBorderWidth:1.0]; //边框宽度
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//    [exitButton.layer setBorderColor:colorref];//边框颜色
    [exitButton setBackgroundColor:[Utils colorWithHexString:@"#f2cc1a"]];
    [exitButton setTitle:@"退出当前账户" forState:UIControlStateNormal];
   exitButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//title color
    [exitButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.view addSubview:exitButton];
}
- (void)buttonAction:(UIButton *)button{
    NSLog(@"buttonAction%d",self.navigationController.viewControllers.count);
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"是否退出登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", @"取消",nil];
    a.delegate=self;
    [a show];
    //    [self.navigationController popToRootViewControllerAnimated:YES];

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [CLAccountTool removeAccount];
        [UIView animateWithDuration:1.5 animations:^{
            
            CLOAuthController *oaVc = [[CLOAuthController alloc]init];
            oaVc.delegate = self;
            [self presentViewController:oaVc animated:YES completion:^{
                
            }];
        }];
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            NSLog(@"controller%@",controller);
//            if ([controller isKindOfClass:[CLSettingController class]]) {
//                [self.navigationController popToViewController:controller animated:YES];
//            }
//        }
    }
}
//-(void)SwitchRootViewController
//{
//    [self chooseRootViewController];
//}
//
//-(void)chooseRootViewController
//{
//    CLMainViewController *mainVc = [[CLMainViewController alloc]init];
//    CLLeftViewController *leftVc = [[CLLeftViewController alloc]initWithNibName:@"CLLeftViewController" bundle:nil];
//    BaseNavigationController *nav=[[BaseNavigationController alloc] initWithRootViewController:mainVc];
//    CLSlideViewController *slideZoomMenu = [[CLSlideViewController alloc]initWithRootViewController:nav];
//    //    UINavigationController *lnav = [[UINavigationController alloc]initWithRootViewController:leftVc];
//    slideZoomMenu.leftViewController = leftVc;
//    self.slider = slideZoomMenu;
//    [self presentViewController:slideZoomMenu animated:YES completion:^{
//        
//    }];
//    
//}
@end
