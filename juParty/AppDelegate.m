//
//  AppDelegate.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/14.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "AppDelegate.h"
#import "CLLeftViewController.h"
#import "CLMainViewController.h"
#import "CLSlideViewController.h"
#import "UMSocial.h"
#import <QMapKit/QMapKit.h>
#import "CLAccountTool.h"
#import "CLAccount.h"
#import "CLRootTool.h"
#import "BaseNavigationController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self _initMap];
    
      self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [WXApi registerApp:kWXAPP_ID];
    [UMSocialData setAppKey:UMSocialKey];
    [UMSocialWechatHandler setWXAppId:kWXAPP_ID appSecret:kWXAPP_SECRET url:@"http://www.umeng.com/social"];
    [UMSocialSinaHandler openSSOWithRedirectURL:GPSinaCallbackUrl];
      [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:GPQQAppId appKey:GPQQAppKey url:@"http://www.umeng.com/social"];
//        [UMSocialConfig hiddenNotInstallPlatforms:[NSArray arrayWithObjects:UMShareToQQ,nil]];
    
    NSMutableArray *platforms = [[NSMutableArray alloc] initWithObjects:nil];
    if (![TencentOAuth iphoneQQInstalled]) {
        [platforms addObjectsFromArray:@[UMShareToQQ]];
    }
    if (![WXApi isWXAppInstalled] && ![WXApi isWXAppSupportApi]) {
        [platforms addObjectsFromArray:@[UMShareToWechatSession, UMShareToWechatTimeline]];
    }
    [UMSocialConfig hiddenNotInstallPlatforms:platforms];
//    if ([CLAccountTool account]) {
//        
//        [self chooseRootViewController];
//        
//    }else {
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        if([userDefaults objectForKey:@"FirstLoad"] == nil) {
            [userDefaults setBool:NO forKey:@"FirstLoad"];
            CLGuideController *guideVc = [[CLGuideController alloc]init];
            
            self.window.rootViewController = guideVc;
        }else if ([CLAccountTool account]){
              [self chooseRootViewController];
        }else{
                
                CLOAuthController *oaVc = [[CLOAuthController alloc]init];
                self.window.rootViewController = oaVc;
                
        }

//    }
    [self.window makeKeyAndVisible];

    [HttpTool checkedNetWork];
    return YES;
}

//-(void)SwitchingControllerToAuthorize
//{
//    [UIView animateWithDuration:1.5 animations:^{
//        
//        CLOAuthController *oaVc = [[CLOAuthController alloc]init];
//        oaVc.delegate = self;
//        self.window.rootViewController = oaVc;
//        
//    }];
//   
//}
//
//
//-(void)SwitchRootViewController
//{
//    [self chooseRootViewController];
//}

-(void)chooseRootViewController
{
            CLMainViewController *mainVc = [[CLMainViewController alloc]init];
            CLLeftViewController *leftVc = [[CLLeftViewController alloc]initWithNibName:@"CLLeftViewController" bundle:nil];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:mainVc];
    
            CLSlideViewController *slideZoomMenu = [[CLSlideViewController alloc]initWithRootViewController:nav];
            //    UINavigationController *lnav = [[UINavigationController alloc]initWithRootViewController:leftVc];
            slideZoomMenu.leftViewController = leftVc;
            self.slider = slideZoomMenu;
            self.window.rootViewController = slideZoomMenu;
    
}

-(void) onReq:(BaseReq*)req
{
    
    
    
}
-(void) onResp:(BaseResp*)resp
{
    
    /*
     
     ErrCode	ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code	用户换取access_token的code，仅在ErrCode为0时有效
     state	第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang	微信客户端当前语言
     country	微信用户当前国家信息
     */
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode == 0) {
        NSString *code = aresp.code;
        
        NSDictionary *dic = @{@"code":code};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_CODE" object:nil userInfo:dic];
    }
    
}


- (void)_initMap{
    [QMapServices sharedServices].apiKey = @"TXCBZ-OU5KO-VGQWC-S5HO2-3Y365-XUBQ6";
    //        if([[UIDevice currentDevice].systemVersion floatValue] > 8)
    //
    //        {
    //            self.locationManager =[ [CLLocationManager alloc] init];
    //
    //            [self.locationManager requestAlwaysAuthorization];
    //
    //            [self.locationManager requestWhenInUseAuthorization];
    //            [self.locationManager startUpdatingLocation];
    //        }
    
    //    // 判斷是否 iOS 8
    //    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //         self.locationManager = [[CLLocationManager alloc] init];
    //        [self.locationManager requestAlwaysAuthorization]; // 永久授权
    //        [self.locationManager requestWhenInUseAuthorization]; //使用中授权
    //    }
    //    [self.locationManager startUpdatingLocation];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *string =[url absoluteString];
    NSLog(@"string:%@",string);
    if ([string hasPrefix:@"sina"])
    {
        return [UMSocialSnsService handleOpenURL:url];
    }
    else if ([string hasPrefix:@"wx"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
      return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *string =[url absoluteString];
       NSLog(@"string:%@",string);
    if ([string hasPrefix:@"sina"])
    {
        return [UMSocialSnsService handleOpenURL:url];
    }
    else if ([string hasPrefix:@"wx"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}




@end
