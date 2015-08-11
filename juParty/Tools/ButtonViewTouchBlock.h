//
//  ButtonViewTouchBlock.h
//  聚派
//
//  Created by yintao on 15/7/6.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonViewBlock)(void);
@interface ButtonViewTouchBlock : UIView{
    UITapGestureRecognizer *_tapGestureRecognizer;
}
@property (nonatomic,copy)ButtonViewBlock touchBlock;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain)UILabel *label;
@property (nonatomic,copy)NSString *buttonImageName;
@property (nonatomic,copy)NSString *buttonTitle;
@end
