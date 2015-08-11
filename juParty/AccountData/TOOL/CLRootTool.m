//
//  CLRootTool.m
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLRootTool.h"
#import "CLLeftViewController.h"
#import "CLMainViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#define CLVersionKey @"version"


@interface CLRootTool()


@end

@implementation CLRootTool

-(void)chooseRootViewController:(UIWindow *)window
{
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:CLVersionKey];
//    AppDelegate *app = [UIApplication sharedApplication].delegate;

    CLMainViewController *mainVc = [[CLMainViewController alloc]init];
    CLLeftViewController *leftVc = [[CLLeftViewController alloc]initWithNibName:@"CLLeftViewController" bundle:nil];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:mainVc];
    
        CLSlideViewController *slideZoomMenu = [[CLSlideViewController alloc]initWithRootViewController:nav];
        slideZoomMenu.leftViewController = leftVc;
        self.slider = slideZoomMenu;
        window.rootViewController = slideZoomMenu;
    
    
    
    }


@end
