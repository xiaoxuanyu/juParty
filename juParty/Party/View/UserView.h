//
//  UserView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLStatus.h"
/**
 *  用户头像View
 */
@interface UserView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickLabel;
//数据成员
//@property (nonatomic,copy) NSString *imgString;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *nikename;
/**
 *  用户头像地址
 */
@property (nonatomic,copy) NSString *headimgurl;
@property (nonatomic,retain)CLStatus *userInfo;
- (void)loadData;
@end
