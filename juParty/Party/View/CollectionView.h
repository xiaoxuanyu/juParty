//
//  CollectionView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/14.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCell.h"
#import "CollectionHeaderView.h"

/**
 * publishCilckDelegate协议
 */
@protocol publishCilckDelegate <NSObject>
@optional
///点击发布按钮
-(void)publishClick:(UIButton *)button;
///选好图片
- (void)uploadImage:(UIImage *)image index:(NSInteger)index;
- (void)selectImage:(NSUInteger)index photosWallArray:(NSMutableArray *)photosWallArray;
@end
/**
 *  相册View
 */
@interface CollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
///聚会类型
typedef NS_ENUM(NSInteger, PartyType){
    startParty, //发起聚会
    checkParty //查看聚会
};
@property (nonatomic,assign)PartyType partyType;
@property (nonatomic,retain)CollectionHeaderView *headerView;
/**
 *  声明publishCilckDelegate协议
 */
@property (nonatomic,assign) id <publishCilckDelegate> publishDelegate;
/**
 *  照片墙图片
 */
@property (nonatomic,retain) NSMutableArray *photosWallArray;
/**
 *  选中的cell的序号
 */
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)float header_height;
@property (nonatomic,assign)float footer_height;
@property (nonatomic,retain)UIImage *addImage;
@end
