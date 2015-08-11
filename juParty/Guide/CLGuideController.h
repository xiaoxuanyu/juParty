//
//  CLGuideController.h
//  聚派
//
//  Created by 伍晨亮 on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCollectionViewCell.h"



@protocol CLGuideDelegate <NSObject>

-(void)SwitchingControllerToAuthorize;

@end

@interface CLGuideController : UICollectionViewController<CLCollectionCellDelegate>


@property(nonatomic,weak) id <CLGuideDelegate> delegate;

@end
