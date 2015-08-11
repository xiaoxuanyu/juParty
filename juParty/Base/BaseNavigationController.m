//
//  BaseNavigationController.m
//  聚派
//
//  Created by yintao on 15/7/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end
// 判断是否为iOS7
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
@implementation BaseNavigationController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    if (IOS_VERSION<7) {
//        [[UINavigationBar appearance] setTintColor:[Utils colorWithHexString:@"#f2cc1a"]];
//    }else{
//        [[UINavigationBar appearance] setBarTintColor:[Utils colorWithHexString:@"#f2cc1a"]];
//    }
//    [[UINavigationBar appearance] setTranslucent:NO];
//}
#pragma mark 一个类只会调用一次
+ (void)initialize
{
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[BaseNavigationController class], nil];
    
    // 2.设置导航栏的背景图片
    NSString *navBarBg = nil;
    if (iOS7) { // iOS7
        navBarBg = @"NavBar64";
        [navBar setBarTintColor:[Utils colorWithHexString:@"#f2cc1a"]];
//        navBar.tintColor = [Utils colorWithHexString:@"#f2cc1a"];
//        [[UINavigationBar appearance] setBarTintColor:[Utils colorWithHexString:@"#f2cc1a"]];
    } else { // 非iOS7
        navBarBg = @"NavBar";
        [navBar setTintColor:[Utils colorWithHexString:@"#f2cc1a"]];
    }
//    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    
    // 3.标题
#ifdef __IPHONE_7_0
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
#else
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
#endif
}

#pragma mark 控制状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
