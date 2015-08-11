//
//  UserCollectionViewCell.h
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "GPJoinUserModel.h"
/**
 *  用户头像和昵称Cell
 */
@interface UserCollectionViewCell : UICollectionViewCell
@property (nonatomic,retain)UserView *userView;
@property (nonatomic,retain)GPJoinUserModel *userInfo;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *nikename;
/**
 *  用户头像地址
 */
@property (nonatomic,copy) NSString *headimgurl;
@end
