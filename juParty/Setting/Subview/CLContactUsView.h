//
//  CLContactUsView.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/22.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface CLContactUsView : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *LOGOView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *version;

@end
