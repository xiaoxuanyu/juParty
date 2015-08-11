//
//  CLLeftCell.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLLeftCell.h"

@implementation CLLeftCell

- (void)awakeFromNib {
    // Initialization code
    _titleView.textColor=[Utils colorWithHexString:@"#4b4646"];
    _titleView.backgroundColor=[UIColor clearColor];
    [_imgView setContentMode:UIViewContentModeScaleAspectFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
