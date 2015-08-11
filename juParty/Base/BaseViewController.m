//
//  BaseViewController.m
//  聚派
//
//  Created by yintao on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *viewController=self.navigationController.viewControllers;
    if (self.isBackButton ) {
        UIButton *backButton=[[UIButton alloc] init];
        [backButton setBackgroundImage:[UIImage imageNamed:@"navigation_icon_return.png"] forState:UIControlStateNormal];
        backButton.frame=CGRectMake(0, 0,24, 24);
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
//        UIFont *font=[UIFont boldSystemFontOfSize:11.0f];
//        backButton.titleLabel.font = font;
//        backButton.showsTouchWhenHighlighted=YES;//当按下出现高亮效果
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem=backItem;
    }
    // Do any additional setup after loading the view.
//    self.modalPresentationCapturesStatusBarAppearance = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    
}
- (void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)setTitle:(NSString *)title{
//    [super setTitle:title];
//    UILabel *titleLabel=[[UILabel alloc] init];
//    titleLabel.font=[UIFont boldSystemFontOfSize:16.0f];
//    titleLabel.backgroundColor=[UIColor clearColor];
//    UIColor *titleColor=[Utils colorWithHexString:@"#ffffff"];
//    titleLabel.textColor=titleColor;
//    titleLabel.text=title;
//    [titleLabel sizeToFit];
//    self.navigationItem.titleView=titleLabel;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  获取用户id
 *
 *  @param NSString 用户id
 *
 *  @return 返回用户id
 */
- (NSString *)userId{
    CLAccount *account=[CLAccountTool account];
    NSString *userId=account.unionid;
    NSLog(@"%@",userId);
    return userId;
}
/**
 *  获取授权用户标识openid
 *
 *  @param NSString 用户openId
 *
 *  @return 返回授权用户标识openid
 */
- (NSString *)openId{
    CLAccount *account=[CLAccountTool account];
    NSString *openId=account.openid;
    NSLog(@"%@",openId);
    return openId;
}
/**
 *  获取用户头像地址
 *
 *  @param NSString 用户头像地址
 *
 *  @return 返回用户头像地址
 */
- (NSString *)headimgurl{
    CLUserInfo *userInfo=[CLAccountTool userinfo];
    NSString *headimgurl=userInfo.headimgurl;
    NSLog(@"%@",headimgurl);
    return headimgurl;
}
/**
 *  获取用户昵称
 *
 *  @param NSString 用户昵称
 *
 *  @return 返回用户头像地址
 */
- (NSString *)nikename{
    CLUserInfo *userInfo=[CLAccountTool userinfo];
    NSString *nikename=userInfo.nikename;
    NSLog(@"%@",nikename);
    return nikename;
}
/**
 *  获取授权用户个人信息
 *
 *  @param CLUserInfo 授权用户个人信息
 *
 *  @return 返回授权用户个人信息
 */
- (CLUserInfo *)userInfo{
    CLUserInfo *userInfo=[CLAccountTool userinfo];
    return userInfo;
}
//- (void)navigationController:(UINavigationController *)navigationController
//      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
//        ((UIImagePickerController *)navigationController).sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
////        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    }
//}
@end
