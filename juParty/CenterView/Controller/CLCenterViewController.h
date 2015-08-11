//
//  CLCenterViewController.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/27.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseTableView.h"
#import "UIImage+FixOrientation.h"

/**
 *  个人信息
 */
@interface CLCenterViewController : BaseViewController
@property (nonatomic,retain) BaseTableView *tableView;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *userName;
@end
