//
//  ShowPlaceCell.h
//  GPCollectionView
//
//  Created by yintao on 15/5/27.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  查看聚会地点Cell
 */
@interface ShowPlaceCell : UITableViewCell
/**
 *  地点序号View
 */
@property (strong, nonatomic) IBOutlet UIView *labelBackgroundView;
/**
 * 地点序号label
 */
@property (strong, nonatomic) IBOutlet UILabel *positionOrderLabel;
/**
 *  地点名称
 */
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
/**
 * 地点详情
 */
@property (strong, nonatomic) IBOutlet UILabel *positionDetailLabel;

@property (nonatomic,retain)NSArray *placeArray;
@end
