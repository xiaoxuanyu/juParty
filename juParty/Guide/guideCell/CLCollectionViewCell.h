//
//  CLCollectionViewCell.h
//  聚派
//
//  Created by 伍晨亮 on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol  CLCollectionCellDelegate <NSObject>

/**
 *  切换到OAUTH控制器
 */
-(void)SwitchingControllerToAuthorizeArrivals;

@end
@interface CLCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImage *image;

@property(nonatomic,weak) id<CLCollectionCellDelegate> delegate;
/**
 *  判断是否是最后一页
 */
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
