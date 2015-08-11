//
//  ShowPlaceCell.m
//  GPCollectionView
//
//  Created by yintao on 15/5/27.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "ShowPlaceCell.h"

@implementation ShowPlaceCell

- (void)awakeFromNib {
    // Initialization code
    _positionDetailLabel.textColor=GPTextColor;
    _positionLabel.textColor=GPTextColor;
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    _positionLabel.text=@"武汉万达广场汉街店";
//    _positionDetailLabel.text=@"楚河汉街";
  
    _labelBackgroundView.layer.backgroundColor=[UIColor yellowColor].CGColor;
    
    _positionOrderLabel.textColor=[UIColor whiteColor];
    //把地点序号view画成圆形
    _labelBackgroundView.layer.cornerRadius =CGRectGetWidth(_labelBackgroundView.frame)/2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
