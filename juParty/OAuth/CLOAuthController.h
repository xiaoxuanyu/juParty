//
//  CLOAuthController.h
//  聚派
//
//  Created by 伍晨亮 on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSlideViewController.h"

@protocol CLOAuthDelegate <NSObject>

/**
 *  切换控制器
 */
-(void)SwitchRootViewController;



@end

@interface CLOAuthController : UIViewController

@property (nonatomic,weak) id <CLOAuthDelegate> delegate;
@property(nonatomic,strong)CLSlideViewController *slider;
@end
