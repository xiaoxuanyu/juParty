//
//  CLActivityController.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/25.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"

@interface CLActivityController : UIViewController<DLTabedSlideViewDelegate>
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;

@end