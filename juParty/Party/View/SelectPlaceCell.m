//
//  SelectPlaceCell.m
//  GPCollectionView
//
//  Created by yintao on 15/5/22.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "SelectPlaceCell.h"

@implementation SelectPlaceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    _positionDetailLabel.textColor=GPTextColor;
    _positionLabel.textColor=GPTextColor;
//    _positionOrderLabel.layer.borderWidth  = 1.0f;
//    _positionOrderLabel.layer.backgroundColor  = [UIColor yellowColor].CGColor;
//    _positionOrderLabel.layer.cornerRadius = CGRectGetWidth(_positionOrderLabel.frame)/2;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _positionImageView.image=[UIImage imageNamed:@"map_icon.png"];
    _positionLabel.text=_business.name;
    _positionDetailLabel.text=_business.address;
}

@end
