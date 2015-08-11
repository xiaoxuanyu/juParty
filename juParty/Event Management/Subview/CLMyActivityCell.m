//
//  CLMyActivityCell.m
//  ActivityManagement
//
//  Created by 伍晨亮 on 15/5/18.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLMyActivityCell.h"
#import "CLAccountTool.h"
#import "UIImageView+WebCache.h"
@implementation CLMyActivityCell

- (void)awakeFromNib {
    self.userImageView.layer.cornerRadius = 20;
    self.userImageView.layer.masksToBounds = YES;
    [_cellButton.layer setMasksToBounds:YES];
    [_cellButton.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    _themeTextLabel.textColor=GPTextColor;
    _dateTextLabel.textColor=GPTextColor;
    _placeTextLabel.textColor=GPTextColor;
    _Theme.textColor=GPTextColor;
    _Dete.textColor=GPTextColor;
    _Location.textColor=GPTextColor;
    _personCount.textColor=GPTextColor;
    [_cellButton setBackgroundColor:[Utils colorWithHexString:@"#f24747"]];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _Theme.text=_status.title;
    _Dete.text=[Utils dateToString:_status.time formate:@"MM/dd HH:mm"];
    
    _Location.text=[self place];
    _personCount.text=[NSString stringWithFormat:@"%d人参加",_status.count];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_status.picurl] placeholderImage:[UIImage imageNamed:@"image_background.png"]];
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_status.plannerHeadurl]placeholderImage:[UIImage imageNamed:@"image_head.png"]];
}
- (NSString *)place{
    NSString *place=_status.place;
    if (![Utils isNullOfInput:place]) {
        NSMutableString *str1 = [NSMutableString stringWithString:place];
        [str1 insertString:@"," atIndex:0];
        NSLog(@"hhl:%@",[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"]);
        NSArray *placeArray=[Utils separatedString:[Utils stringDeleteString:str1]  charactersInString:@"]"];
        _placeMutableArray= [NSMutableArray array];
        for (int i=0; i<placeArray.count; i++) {
            NSString *place=[Utils stringDeleteString:[placeArray objectAtIndex:i]];
            NSLog(@"dddd%@",[Utils stringDeleteString:[placeArray objectAtIndex:i]]);
            NSLog(@"www:%@", [Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","]);
            NSArray *array=[Utils separatedString:[Utils stringDeleteString:place]  charactersInString:@","];
            [_placeMutableArray addObject:array];
        }
    }
    NSArray *array=[[NSArray alloc] init];
    NSString *positionString=@"";
    if (_placeMutableArray) {
        array=[_placeMutableArray objectAtIndex:0];
    }
    NSLog(@"array:%d",array.count);
    if (array.count==6) {
        
        positionString=[array objectAtIndex:4];
    }
 
    return positionString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(buttonClick:)])  {
        
        [_delegate buttonClick:self.status];
    }
}
@end
