//
//  CLCleanCell.m
//  清理缓存
//
//  Created by 伍晨亮 on 15/5/28.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLCleanCell.h"

@implementation CLCleanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth - 70, 0,60, self.frame.size.height)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15];
        self.cache = lab;
        [self.contentView addSubview:lab];
    }
    
    return self;

}

@end
