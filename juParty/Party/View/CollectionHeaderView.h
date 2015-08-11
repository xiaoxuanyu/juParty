//
//  CollectionHeaderView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/15.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPImageModel.h"
/**
 *  相册头部View
 */
@interface CollectionHeaderView : UICollectionReusableView
/**
 *  聚会主题照片
 */
@property (nonatomic,retain)UIImageView *imageView;
/**
 *  文字描述label
 */
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)GPImageModel *imageModel;
@property(nonatomic,strong)id userPhoto;
@end
