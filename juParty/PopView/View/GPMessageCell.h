//
//  GPMessageCell.h
//  聚派
//
//  Created by yintao on 15/7/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPMessageModel.h"
@interface GPMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *partyImageView;
@property (strong, nonatomic) IBOutlet UILabel *partyTitle;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,retain)GPMessageModel *messageModel;
@end
