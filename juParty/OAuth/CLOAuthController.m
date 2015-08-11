//
//  CLOAuthController.m
//  聚派
//
//  Created by 伍晨亮 on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLOAuthController.h"
#import "WXApi.h"
#import "CLRootTool.h"
#import "CLAccountTool.h"
#import "CLUserInfo.h"
#import "CLAccount.h"
#import "CLMainViewController.h"
#import "CLLeftViewController.h"
#import "BaseNavigationController.h"
#include "AppDelegate.h"
@interface CLOAuthController ()
@property (nonatomic,strong) NSMutableArray *account;
@property (nonatomic,strong) NSMutableArray *codeArr;
@end

@implementation CLOAuthController
-(NSMutableArray *)account
{
    if (_account == nil) {
        _account = [NSMutableArray array];
    }
    return _account;
}

-(NSMutableArray *)codeArr
{
    if (_codeArr == nil) {
        _codeArr = [NSMutableArray array];
    }
    return _codeArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveWX:) name:@"WX_CODE" object:nil];
    [self setUpBackGround];
}



-(void)setUpBackGround
{
    UIImageView *background = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    background.image = [UIImage imageNamed:@"login_background_image"];
    [self.view addSubview:background];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat x = self.view.bounds.size.width / 2 - 85;
    CGFloat y = (self.view.bounds.size.height / 4) * 3;
    
    
    login.frame = CGRectMake(x,y,180,50);
    [login setBackgroundImage:[UIImage imageNamed:@"icon_Sigin_weixin"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(WeChatLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
}

-(void)WeChatLogin
{
    [self sendAuthRequest];
}

-(void)sendAuthRequest

{
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"7788" ;
    [WXApi sendReq:req];
}

-(void)didReceiveWX:(NSNotification *)notication
{
    NSDictionary *info = notication.userInfo;
    
    NSString *code = [info objectForKey:@"code"];
    [self.codeArr addObject:code];
    
    
    /** wangmm
     *	第二步获取接入token
     */
    [self getAccess_token];
}

-(void)getAccess_token
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *code = [self.codeArr lastObject];
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                //                NSLog(@"%@",dic);
                
                //                self.access_token.text = [dic objectForKey:@"access_token"];
                //
                //                self.openid.text = [dic objectForKey:@"openid"];
                
                CLAccount *account = [CLAccount accountWithDict:dic];
                
                [CLAccountTool saveAccount:account];
                //                NSString *path = NSHomeDirectory();
                //                NSLog(@"%@",path);
                NSString *token = [dic objectForKey:@"access_token"];
                NSString *openid = [dic objectForKey:@"openid"];
                
                [self.account addObject:token];
                [self.account addObject:openid];
                
                /** wangmm
                 *	第三步获取用户信息
                 */
                [self getUserInfo];
            }
        });
    });
}
-(void)getUserInfo
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *access_token = [self.account firstObject];
    NSString *openid = [self.account lastObject];
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 }
                 */
                
//                                NSLog(@"%@",dic);
                
                CLUserInfo *user = [CLUserInfo userinfoWithDict:dic];
                
                [CLAccountTool saveUserInfo:user];
                
                [self start];
                
                
            }
        });
        
    });
}

-(void)start
{
    [self chooseRootViewController];
}

-(void)chooseRootViewController
{
 AppDelegate *app =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    CLMainViewController *mainVc = [[CLMainViewController alloc]init];
    CLLeftViewController *leftVc = [[CLLeftViewController alloc]initWithNibName:@"CLLeftViewController" bundle:nil];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:mainVc];
    
    CLSlideViewController *slideZoomMenu = [[CLSlideViewController alloc]initWithRootViewController:nav];
    //    UINavigationController *lnav = [[UINavigationController alloc]initWithRootViewController:leftVc];
    slideZoomMenu.leftViewController = leftVc;
    app.slider = slideZoomMenu;
    [self presentViewController:slideZoomMenu animated:YES completion:^{
        
    }];
    
}




@end
