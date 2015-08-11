//
//  ImageAlbumViewController.h
//  GPCollectionView
//
//  Created by yintao on 15/5/26.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionView.h"
#import "BaseViewController.h"
/**
 *  相册类
 */
@interface ImageAlbumViewController : BaseViewController<publishCilckDelegate>
@property (nonatomic,retain) CollectionView *collectionView;
/**
 *  聚会id
 */
@property (nonatomic,copy)NSString *partyId;

@end
