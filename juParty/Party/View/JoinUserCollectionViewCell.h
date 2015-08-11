//
//  JoinUserCollectionViewCell.h
//  聚派
//
//  Created by yintao on 15/7/9.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPJoinUserModel.h"
/**
 *  用户头像和昵称Cell
 */
@interface JoinUserCollectionViewCell : UICollectionViewCell
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *nikename;
/**
 *  用户头像地址
 */
@property (nonatomic,copy) NSString *headimgurl;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickLabel;
@property (nonatomic,retain)GPJoinUserModel *userInfo;
@end
