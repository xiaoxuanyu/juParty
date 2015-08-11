//
//  CLMyActivityCell.h
//  ActivityManagement
//
//  Created by 伍晨亮 on 15/5/18.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLStatus.h"
@protocol ActivityCellDelegate <NSObject>



@optional
/**
 *  点击按钮
 */
-(void)buttonClick:(CLStatus *)status;
@end
@interface CLMyActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *themeTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *placeTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *Theme;
@property (weak, nonatomic) IBOutlet UILabel *Dete;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (strong, nonatomic) IBOutlet UILabel *personCount;

@property (strong, nonatomic) IBOutlet UIButton *cellButton;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
- (IBAction)buttonClick:(id)sender;

@property (nonatomic,weak) id <ActivityCellDelegate> delegate;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic,retain) NSMutableArray *placeMutableArray;
@end
