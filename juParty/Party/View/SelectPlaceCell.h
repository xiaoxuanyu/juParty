//
//  SelectPlaceCell.h
//  GPCollectionView
//
//  Created by yintao on 15/5/22.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPBusinessModel.h"
/**
 *  发起聚会地点Cell
 */
@interface SelectPlaceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *positionImageView;
/**
 *  地点名称
 */
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
/**
 * 地点详情
 */
@property (strong, nonatomic) IBOutlet UILabel *positionDetailLabel;

@property (nonatomic,retain)GPBusinessModel *business;
@end
