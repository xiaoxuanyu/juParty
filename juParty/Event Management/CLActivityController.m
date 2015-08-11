//
//  CLActivityController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLActivityController.h"
#import "DLFixedTabbarView.h"
#import "CLCollectView.h"
#import "CLPartakeView.h"
#import "CLFoundView.h"

@interface CLActivityController ()
@end

@implementation CLActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动管理";
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = GPTextColor;
   self.tabedSlideView.tabItemSelectedColor = GPTextColor;
    self.tabedSlideView.tabbarTrackColor = [Utils colorWithHexString:@"#f2cc1a"];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
//    self.tabedSlideView.tabbarHeight=44;
//    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"我收藏的" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"我参加的" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"我创建的" image:nil selectedImage:nil];
    
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            CLCollectView *ctrl = [[CLCollectView alloc] init];
            return ctrl;
        }
        case 1:
        {
            CLPartakeView *ctrl = [[CLPartakeView alloc] init];
            return ctrl;
        }
        case 2:
        {
            CLFoundView *ctrl = [[CLFoundView alloc] init];
            return ctrl;
        }
            
        default:
            return nil;
    }
}

@end
