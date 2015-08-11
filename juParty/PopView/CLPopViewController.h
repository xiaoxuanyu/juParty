//
//  CLPopViewController.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/26.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPMessageTableView.h"
#import "BaseViewController.h"
/**
 *  消息界面
 */
@interface CLPopViewController : BaseViewController<deleteMessageDelegate>
@property (nonatomic,retain)GPMessageTableView *tableView;
@property (nonatomic,retain) UIButton *rightButton;
@property (nonatomic,retain) NSMutableArray *messagwArray;
@end
