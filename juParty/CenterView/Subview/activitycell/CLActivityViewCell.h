//
//  CLActivityViewCell.h
//  图片放大滚动
//
//  Created by 伍晨亮 on 15/6/1.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLActivityViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *LOGO1;
@property (weak, nonatomic) IBOutlet UIImageView *LOGO2;
@property (weak, nonatomic) IBOutlet UIImageView *LOGO3;
@property (weak, nonatomic) IBOutlet UIImageView *IntroduceView;
@property (weak, nonatomic) IBOutlet UILabel *MotifView;
@property (weak, nonatomic) IBOutlet UILabel *DataView;
@property (weak, nonatomic) IBOutlet UILabel *LocationView;
@property (weak, nonatomic) IBOutlet UILabel *AttachView;

@end
