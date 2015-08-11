//
//  CheckPartyView.m
//  聚派
//
//  Created by yintao on 15/7/6.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CheckPartyView.h"
#import "UIImageView+WebCache.h"
@implementation CheckPartyView
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[Utils colorWithHexString:@"#ededed"];
        [self _initPartyThemeView];
        [self _initHeaderView];
        [self _initPartyTimeView];
        [self _initPartyContentView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //    CLUserInfo *userInfo=[CLAccountTool userinfo];
    //    _userView.userInfo=userInfo;
    //    NSLog(@"userInfo11:%@",_userView.userInfo.nikename);
    
    //异步调用layoutSubView
    //    [_userView setNeedsLayout];
    
    NSString *dateString=[Utils dateToString:_status.time formate:@"MM/dd"];
    _dateLabel.text=dateString;
    NSString *timeString=[Utils dateToString:_status.time formate:@"HH:mm"];
    _timeLabel.text=timeString;
    
    ///倒计时
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    _themeText.text=_status.title;
//    _userView.userInfo=_status;
    NSLog(@"_status:%@",_status);
    _detailText.text=@"老哥哥";
    UIFont *font=[UIFont systemFontOfSize:17.0f];
    CGSize textSize =[ _detailText.text boundingRectWithSize:CGSizeMake(fDeviceWidth                                                                                   -2*10-65, 71) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    _detailText.frame=CGRectMake(55,2,textSize.width, textSize.height);
    NSLog(@"textSize.width:%f",textSize.width);
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_status.plannerHeadurl] placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    _nickLabel.text=_status.plannerName;
    
    _selectedDate=[Utils dateFromFomate:_status.time formate:@"E MMM dd yyyy HH:mm:ss 'GMT 0800 (CST)'"];
//    [_detailText alignTop];

//    for(int i=0; i<1; i++)
//        self.detailText.text =[self.detailText.text stringByAppendingString:@"\n "];
//    WeatherData *weatherData = _weatherInfo.weather_data[0];
//    NSString *weather = weatherData.weather;
//    NSLog(@"weather:%@  %@",weather,weatherData);
//    self.weatherImageView.image = [UIImage imageNamed:weather];
}
- (void)setWeatherInfo:(GPWeatherModel *)weatherInfo
{
    WeatherData *weatherData = weatherInfo.weather_data[0];
    NSString *weather = weatherData.weather;
    NSLog(@"weather:%@  %@",weather,weatherData);
    self.weatherImageView.image = [UIImage imageNamed:weather];
}
/**
 * 主题view
 */
- (void)_initPartyThemeView{
    ///-------聚会主题View-----
    _partyThemeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 60)];
    [self addSubview:_partyThemeView];
    _partyThemeBackgroundImageView = [[UIImageView alloc] initWithFrame:_partyThemeView.frame];
    [_partyThemeBackgroundImageView setImage:[UIImage imageNamed:@"basicUser.jpg"]];
    [_partyThemeView addSubview:_partyThemeBackgroundImageView];
    [_partyThemeView sendSubviewToBack:_partyThemeBackgroundImageView];
    ///-----定义聚会主题输入框-----
    _themeText=[[UILabel alloc] initWithFrame:CGRectMake(32, (CGRectGetHeight(_partyThemeView.frame)-30)/2, fDeviceWidth-64, 30)];
    _themeText.textColor=GPTextColor;
    _themeText.textAlignment=NSTextAlignmentCenter;
    _themeText.backgroundColor=[UIColor whiteColor];
    ///将图层的边框设置为圆脚
    _themeText.layer.cornerRadius = 3;
    _themeText.layer.masksToBounds = YES;
    [_partyThemeView addSubview:_themeText];
    
}
/**
 * 用户头像view
 */
- (void)_initHeaderView{
   _userView=[[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_partyThemeView.frame)+5,100,100)];
    [_userView setBackgroundColor:[UIColor whiteColor]];
    
    ///将图层的边框设置为圆脚
    _userView.layer.cornerRadius = 3;
    _userView.layer.masksToBounds = YES;
    [self addSubview:_userView];
    
    _headImageView=[[UIImageView alloc] initWithFrame:CGRectMake((_userView.width-50)/2, 10, 50, 50)];
    [self.nickLabel setFont:[UIFont systemFontOfSize:13.0f]];
   
    _headImageView.layer.masksToBounds = YES;
    //设置layer的圆角,刚好是自身宽度的一半，这样就成了圆形
    _headImageView.layer.cornerRadius =CGRectGetWidth(_headImageView.frame) * 0.5;
    [_userView addSubview:_headImageView];
    
    _nickLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImageView.frame), _userView.width, 20)];
    _nickLabel.textAlignment=NSTextAlignmentCenter;
     _nickLabel.textColor=GPTextColor;
    [_userView addSubview:_nickLabel];
}
/**
 *  聚会时间view
 */
- (void)_initPartyTimeView{
    /*---底部partyTimeView----*/
    UIView *partryTimeView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userView.frame)+10,CGRectGetMinY(_userView.frame) ,fDeviceWidth-10*3-CGRectGetWidth(_userView.frame) ,CGRectGetHeight(_userView.frame) )];
    [partryTimeView setBackgroundColor:[UIColor whiteColor]];
    ///将图层的边框设置为圆脚
    partryTimeView.layer.cornerRadius = 3;
    partryTimeView.layer.masksToBounds = YES;
    [self addSubview:partryTimeView];
    /*----时间view-------*/
    UIView *timeView=[[UIView alloc] initWithFrame:CGRectMake(3, 3, (CGRectGetWidth(partryTimeView.frame)*2)/5, CGRectGetHeight(partryTimeView.frame)-6)];
    ///为View添加点击事件
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDate:)];
//    [timeView addGestureRecognizer:tapGesture];
    [timeView setBackgroundColor:[Utils colorWithHexString:@"#f7a121"]];
    ///将图层的边框设置为圆脚
    timeView.layer.cornerRadius = 3;
    timeView.layer.masksToBounds = YES;
    [partryTimeView addSubview:timeView];
    ///----聚会时间文字label----
    UILabel *timeTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(timeView.frame), 20)];
    timeTextLabel.text=@"聚会时间";
    timeTextLabel.textAlignment=NSTextAlignmentCenter;
    timeTextLabel.textColor=[UIColor whiteColor];
    timeTextLabel.backgroundColor=[UIColor clearColor];
    timeTextLabel.font=[UIFont systemFontOfSize:15.0f];
    [timeView addSubview:timeTextLabel];
    ///----聚会日期label----
    _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeTextLabel.frame)+5, CGRectGetWidth(timeView.frame),20)];
    _dateLabel.backgroundColor=[UIColor clearColor];
    ///文字居中显示
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    
    _dateLabel.textColor=[UIColor whiteColor];
    _dateLabel.font=[UIFont systemFontOfSize:22.0f];
    [timeView addSubview:_dateLabel];
    ///----聚会时间label-----
    _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateLabel.frame)+5, CGRectGetWidth(timeView.frame), 20)];
    _timeLabel.backgroundColor=[UIColor clearColor];
    ///文字居中显示
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor=[UIColor whiteColor];
    _timeLabel.font=[UIFont systemFontOfSize:22.0f];
    [timeView addSubview:_timeLabel];
    /*----天气view------*/
    UIView *weatherView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeView.frame)+3, CGRectGetMinY(timeView.frame),(CGRectGetWidth(partryTimeView.frame)*3)/5-9 , CGRectGetHeight(timeView.frame))];
    [weatherView setBackgroundColor:[UIColor clearColor]];
    [partryTimeView addSubview:weatherView];
    ///------天气文字label----
    UILabel *weatherTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 30, 40)];
    weatherTextLabel.backgroundColor=[UIColor clearColor];
    weatherTextLabel.textAlignment = NSTextAlignmentCenter;
    weatherTextLabel.numberOfLines=0;
    weatherTextLabel.lineBreakMode=NSLineBreakByWordWrapping;
    weatherTextLabel.text=@"当日天气";
    weatherTextLabel.textColor=GPTextColor;
    weatherTextLabel.font=[UIFont systemFontOfSize:14.0f];
    [weatherView addSubview:weatherTextLabel];
    ///----天气图片-------
    _weatherImageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(weatherView.frame)/2, CGRectGetMinY(weatherTextLabel.frame), 40, 40)];
    [_weatherImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _weatherImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _weatherImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _weatherImageView.clipsToBounds  = YES;
    _weatherImageView.backgroundColor=[UIColor clearColor];
    _weatherImageView.image=[UIImage imageNamed:@"w3.png"];
    [weatherView addSubview:_weatherImageView];
    ///-----倒计时文字label------
    UILabel *countDownTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(weatherTextLabel.frame)+5 ,CGRectGetWidth(weatherView.frame) ,20 )];
    countDownTextLabel.backgroundColor=[UIColor clearColor];
    countDownTextLabel.textAlignment = NSTextAlignmentCenter;
    countDownTextLabel.text=@"倒计时";
    countDownTextLabel.textColor=GPTextColor;
    countDownTextLabel.font=[UIFont systemFontOfSize:14.0f];
    [weatherView addSubview:countDownTextLabel];
    ///-----倒计时label--------
    _countDownLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(countDownTextLabel.frame) ,CGRectGetWidth(weatherView.frame) ,20 )];
    _countDownLabel.backgroundColor=[UIColor clearColor];
    _countDownLabel.textAlignment = NSTextAlignmentCenter;
    _countDownLabel.text=@"倒计时";
    _countDownLabel.textColor=[Utils colorWithHexString:@"#cecece"];
    _countDownLabel.font=[UIFont systemFontOfSize:14.0f];
    [weatherView addSubview:_countDownLabel];
}
/**
 *  聚会详情View
 */
- (void)_initPartyContentView{
    UIView *partyContentView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userView.frame), CGRectGetMaxY(_userView.frame)+5,fDeviceWidth                                                                                   -2*10,75)];
    [partyContentView setBackgroundColor:[UIColor whiteColor]];
    ///将图层的边框设置为圆脚
    partyContentView.layer.cornerRadius = 3;
    partyContentView.layer.masksToBounds = YES;
    [self addSubview:partyContentView];
    ///---内容输入框，textView----
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 45, 30)];
    label.text=@"内容:";
    label.textColor=GPTextColor;
//    label.verticalAlignment=VerticalAlignmentTop;
//    [label sizeToFit];
    [partyContentView addSubview:label];
    _detailText=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame),2, partyContentView.width-62, partyContentView.height-4)];
    _detailText.font=[UIFont systemFontOfSize:17.0f];
    _detailText.textColor=GPTextColor;
    _detailText.numberOfLines=0;
    _detailText.lineBreakMode=NSLineBreakByTruncatingTail;
//    _detailText.verticalAlignment=VerticalAlignmentTop;
    //    _detailTextView.GPDelegate=self;
//    _detailText.layer.cornerRadius=3;
    [_detailText setBackgroundColor:[UIColor clearColor]];
    [partyContentView addSubview:_detailText];

 
    
    //    UIImageView *addPartyImageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userView.frame),CGRectGetMaxY(partyContentView.frame)+5, 100,20)];
    //    addPartyImageView.image=[UIImage imageNamed:@"Joinparty_icon.png"];
    //    [self addSubview:addPartyImageView];
    
}
#pragma mark - 倒计时
- (void)timerFireMethod:(NSTimer*)theTimer
{
    ///定义一个NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    ///得到当前时间
    NSDate *today = [NSDate date];
    ///用来得到具体的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSLog(@"dateFromFomate:%@",[Utils dateFromFomate:_status.time formate:@"E MMM dd yyyy HH:mm:ss 'GMT 0800 (CST)'"]);
//      NSLog(@"dateFromFomate:%@",_status.time);
    if (_selectedDate) {
            NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:_selectedDate options:0];
        NSString *countDown=[NSString stringWithFormat:@"%ld日 %ld:%ld:%ld",(long)[d day],(long)[d hour],(long)[d minute],(long)[d second]];
        [_countDownLabel setText:countDown];
    }

    
    // NSLog(@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]);

}

@end
