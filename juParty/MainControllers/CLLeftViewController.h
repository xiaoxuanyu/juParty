//
//  CLLeftViewController.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "BaseViewController.h"
@protocol CLLeftViewControllerDelegate <NSObject>

@optional
- (void)CLLeftViewControllerDidChange;

@end

@interface CLLeftViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *picImgView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIView *separatorView;

@property(nonatomic,assign) BOOL didSelectInitialViewController;

@property(nonatomic, assign) int selectedIndex;

@property(nonatomic, weak) id<CLLeftViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@end
