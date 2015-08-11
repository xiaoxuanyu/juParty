//
//  CLRootTool.h
//  微信开放测试-01
//
//  Created by 伍晨亮 on 15/6/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSlideViewController.h"


@interface CLRootTool : NSObject

@property(nonatomic,strong)CLSlideViewController *slider;
-(void)chooseRootViewController:(UIWindow *)window;

@end
