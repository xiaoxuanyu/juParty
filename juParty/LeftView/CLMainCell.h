//
//  CLMainCell.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/21.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLStatus.h"
// 代理什么时候用，一般自定义控件的时候都用代理
// 为什么？因为一个控件以后可能要扩充新的功能，为了程序的扩展性，一般用代理

@class CLMainCell;

@protocol MainCellCilckDelegate <NSObject>



@optional
/**
 *  点击中间头像
 */
-(void)CenterDidClick:(CLStatus *)status;
/**
 *  点击周围
 */
-(void)OtherDidClick:(CLMainCell *)cell;
@end

@interface CLMainCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UIView *iconBtnView;
@property (weak, nonatomic) IBOutlet UIImageView *LeftView;
//@property (weak, nonatomic) IBOutlet UIImageView *RightView;
@property (strong, nonatomic) IBOutlet UIView *detailBackgroundView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *collectLabel;
@property (strong, nonatomic) IBOutlet UIImageView *locationImageView;
@property (strong, nonatomic) IBOutlet UIImageView *starImageView;


@property (nonatomic,weak) id <MainCellCilckDelegate> delegate;
@property (nonatomic,retain)CLStatus *status;
@end
