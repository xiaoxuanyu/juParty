//
//  UserCollectionView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckPartyView.h"

#import "CLStatus.h"
@class GPWeatherModel;
/**
 *  基本信息页面下方用户列表
 */
@interface UserCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,retain)CheckPartyView *headerView;
@property (nonatomic,assign)float header_height;
@property (nonatomic,assign)float footer_height;
/**
 * 为collectionView提供数据,存储用户列表
 */
@property (nonatomic,retain)NSArray *collectionViewdata;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic, strong) GPWeatherModel *weatherInfo;
@end
