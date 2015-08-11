//
//  GPMessageCell.m
//  聚派
//
//  Created by yintao on 15/7/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "GPMessageCell.h"
#import "UIImageView+WebCache.h"
@implementation GPMessageCell

- (void)awakeFromNib {
    // Initialization code
    _userName.textColor=[Utils colorWithHexString:@"#f24747"];
    _timeLabel.textColor=[Utils colorWithHexString:@"#f24747"];
    _partyTitle.textColor=GPTextColor;
    _eventLabel.textColor=GPTextColor;
    _timeLabel.textAlignment=NSTextAlignmentRight;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_partyImageView sd_setImageWithURL:[NSURL URLWithString:_messageModel.picurl] placeholderImage:[UIImage imageNamed:@"image_background.png"]];
    _partyTitle.text=_messageModel.juhuiTitle;
    _userName.text=_messageModel.messageContents;
    _eventLabel.text=@"了你的活动";
    _timeLabel.text=[self timePartOfshouldShow:_messageModel.createTime];
    
}
- (NSString *)timePartOfshouldShow:(NSString *)dataString{
    NSString *showPart;
    NSDate *dateA = [NSDate date];
    
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"GMT"];
//    [formater setTimeZone:timeZone];
//    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *dateB = [formater dateFromString:dataString];
    NSString *formate1 = @"E MMM dd HH:mm:ss 'CST' yyyy";
    NSDate *createDate = [Utils dateFromFomate1:dataString formate:formate1];
    NSLog(@"createDate:%@",createDate);
    NSString *text = [Utils stringFromFomate1:createDate formate:@"yyyy-MM-dd HH:mm"];
    NSLog(@"%@",text);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:dateA toDate:createDate options:0];
    
    if (components.year != 0) {
        NSArray *a = [text componentsSeparatedByString:@" "];
        showPart = a[0];
//        showPart = text;
    }else if (components.day != 0 || components.month != 0){
        if (components.month == 0 && components.day >= -2 && components.day < 0) {
            if (components.day == -2) {
                showPart = @"前天";
            }else if(components.day == -1){
                showPart = @"昨天";
            }
        }else{
            NSArray *a1 = [text componentsSeparatedByString:@" "];
            NSString *ym = a1[0];
            NSArray *a2 = [ym componentsSeparatedByString:@"-"];
            showPart = [NSString stringWithFormat:@"%@-%@",a2[1],a2[2]];
        }
    }else{
        NSArray *a = [text componentsSeparatedByString:@" "];
        showPart = a[1];
    }
    return showPart;
}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
