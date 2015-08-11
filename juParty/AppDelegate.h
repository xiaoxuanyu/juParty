//
//  AppDelegate.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/14.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSlideViewController.h"
#import "WXApi.h"
#import "CLOAuthController.h"
#import "CLGuideController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)CLSlideViewController *slider;


@end

