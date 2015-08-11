//
//  CollectionCell.h
//  GPCollectionView
//
//  Created by yintao on 15/5/14.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPImageModel.h"
/**
 *  相册Cell
 */
@interface CollectionCell : UICollectionViewCell
/**
 *  相册图片
 */
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,strong)UILabel *text;
@property (nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)id userPhoto;
@property(nonatomic,strong)UIImage *addPhotosImage;
@property (nonatomic,retain)GPImageModel *imageModel;
@end
