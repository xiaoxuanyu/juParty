//
//  ShareView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/28.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UIButton+UIButtonImageWithLable.h"
/**
 *  分享View
 */
@interface ShareView : UIView
/**
 *  描述label
 */
@property (nonatomic,retain)UILabel *describeLabel;
/**
 *  图片按钮
 */
@property (nonatomic,retain)UIButton *weChat;
@end
