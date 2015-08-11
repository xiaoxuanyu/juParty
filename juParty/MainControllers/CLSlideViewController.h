//
//  CLSlideViewController.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/14.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSlideViewController : UIViewController

@property(nonatomic,strong) UIViewController *leftViewController;
@property(nonatomic,strong) UIViewController *rootViewController;

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController;

@end
