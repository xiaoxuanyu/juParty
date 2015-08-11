//
//  BasicView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/18.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "BasicView.h"
#import "Utils.h"
#import "UserView.h"
#import "CLAccountTool.h"
#import "UIImageView+WebCache.h"

@implementation BasicView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _selectedDate=[NSDate date];
        _isCheck=YES;
        self.backgroundColor=[Utils colorWithHexString:@"#ededed"];
        [self _initPartyThemeView];
        [self _initHeaderView];
        [self _initPartyTimeView];
        [self _initPartyContentView];
        [self addCheckJoinParty];
        [self _addTapGesture];
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
    //---时间----
    NSString *dateString=[Utils stringFromFomate:_selectedDate formate:@"MM/dd"];
    _dateLabel.text=dateString;
    NSString *timeString=[Utils stringFromFomate:_selectedDate formate:@"HH:mm"];
    _timeLabel.text=timeString;
    
//    NSTimeInterval time = [_selectedDate timeIntervalSince1970];
//    NSInteger time1 = round(time);
//    _dateString = [NSString stringWithFormat:@"%ld", (long)time1];
    //---要上传的时间字符串-------
    _dateString=[Utils stringFromFomate:_selectedDate formate:@"E MMM dd yyyy HH:mm:ss 'GMT 0800 (CST)'"];
    NSLog(@"_dateString:%@",_dateString);
    ///----倒计时------
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    //-----用户信息-----
    CLUserInfo *userInfo=[CLAccountTool userinfo];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headimgurl] placeholderImage:[UIImage imageNamed:@"image_head.png"]];
    _nickLabel.text=userInfo.nikename;
    //-----天气-------
//    WeatherData *weatherData = _weatherInfo.weather_data[0];
//    NSString *weather = weatherData.weather;
//    NSLog(@"weather:%@  %@",weather,weatherData);
//    [_weatherImageView setImage:[UIImage imageNamed:weather]];
}
- (void)setWeatherInfo:(GPWeatherModel *)weatherInfo
{
    WeatherData *weatherData = weatherInfo.weather_data[0];
    NSString *weather = weatherData.weather;
    NSUInteger strLocation = [weather rangeOfString:@"转"].location;
    if (strLocation != NSNotFound) {
        weather = [weather substringToIndex:strLocation];
    }
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
    _themeText=[[GPTextField alloc] initWithFrame:CGRectMake(32, (CGRectGetHeight(_partyThemeView.frame)-30)/2, fDeviceWidth-64, 30)];
      _themeText.GPTfieldDelegate = self;
    _themeText.placeholder=@"填写聚会主题";
    _themeText.backgroundColor=[UIColor whiteColor];
    ///圆角
    _themeText.borderStyle=UITextBorderStyleRoundedRect;
    ///输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    _themeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _themeText.returnKeyType=UIReturnKeyDone;
  
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
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDate:)];
    [timeView addGestureRecognizer:tapGesture];
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
    _partyContentView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userView.frame), CGRectGetMaxY(_userView.frame)+5,fDeviceWidth                                                                                   -2*10,fDeviceHeight/4)];
    [_partyContentView setBackgroundColor:[UIColor whiteColor]];
    ///将图层的边框设置为圆脚
    _partyContentView.layer.cornerRadius = 3;
    _partyContentView.layer.masksToBounds = YES;
    [self addSubview:_partyContentView];
    NSLog(@"_partyContentView:%f",CGRectGetMaxY(_partyContentView.frame));
    ///---内容输入框，textView----
    _detailTextView=[[GPTextView alloc] initWithFrame:CGRectMake(0, 0, _partyContentView.width, _partyContentView.height)];
    _detailTextView.GPDelegate=self;
    _detailTextView.layer.cornerRadius=3;
    _detailTextView.placeholder = @"请详细的描述活动内容....";
    [_detailTextView setReturnKeyType:UIReturnKeyDone];
    [_detailTextView setBackgroundColor:[UIColor clearColor]];
    [_partyContentView addSubview:_detailTextView];
    
 
//    UIImageView *addPartyImageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userView.frame),CGRectGetMaxY(partyContentView.frame)+5, 100,20)];
//    addPartyImageView.image=[UIImage imageNamed:@"Joinparty_icon.png"];
//    [self addSubview:addPartyImageView];
 
}
- (void)addCheckJoinParty{
    UIView *checkJoinPartyView=[[UIView alloc] init];
    checkJoinPartyView.backgroundColor=[UIColor clearColor];
    [self addSubview:checkJoinPartyView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0,0,30,30 )];
    if (_isCheck) {
        [button setImage:[UIImage imageNamed:@"icon_Confirm_bright.png"] forState:UIControlStateNormal];
    }else if (!_isCheck){
        [button setImage:[UIImage imageNamed:@"icon_Confirm_grey.png"] forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [checkJoinPartyView addSubview:button];
//    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+2, CGRectGetMinY(button.frame),175 , 30)];
//    label.font=[UIFont boldSystemFontOfSize:20.0f];
//    label.text=@"是否接受公开报名";
//    label.textColor=[Utils colorWithHexString:@"#cecece"];
//    [checkJoinPartyView addSubview:label];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,0 , 0)];//这个frame是初设的，没关系，后面还会重新设置其size。
  [label setNumberOfLines:0];
NSString *text= @"是否接受公开报名";
  label.text=text;
   UIFont *font=[UIFont fontWithName:@"Arial" size:20];
    label.textColor=[Utils colorWithHexString:@"#cecece"];
 [checkJoinPartyView addSubview:label];
 CGSize textSize =[text boundingRectWithSize:CGSizeMake(fDeviceWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    label.frame=CGRectMake(CGRectGetMaxX(button.frame)+2,CGRectGetMinY(button.frame),textSize.width, 30);
    NSLog(@"textSize.width:%f",textSize.width);
    checkJoinPartyView.frame=CGRectMake((fDeviceWidth-170)/2, CGRectGetMaxY(_partyContentView.frame)+15, 170, 30);
}
/**
 *  把时间选择器View添加到对话框中
 */
- (void)_initDatePickerView{
    ///CustomIOSAlertView用于ios7后自定义对话框
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    /**
     *  把时间选择器View添加到定义的对话框中
     */
    [alertView setContainerView:[self datePickerView]];
    ///Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定", @"取消", nil]];
    [alertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        if (buttonIndex==0) {
            NSDate *date=[_pickerView dateWithSelectedTime];
            NSLog(@"Date picked %@", date);
            self.selectedDate = date;
            [self setNeedsLayout];
        }
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    [alertView show];
}
/**
 *  初始化时间选择器View
 *
 *  @return 时间选择器View
 */
- (UIView *)datePickerView
{
    
    _pickerView = [[GPDatePickerView alloc] initWithFrame:CGRectMake(0, 0,294, 180)];
    _pickerView.backgroundColor=[UIColor clearColor];
    if (self.selectedDate) {
        _pickerView.date = self.selectedDate;
    }
    return _pickerView;
}
#pragma mark - GPTextField delegate
-(void)textFieldKeybordShow:(UITextField *)textField withKeybordRect:(CGRect)endKeybordRect withAnimationDuration:(CGFloat)animationDuration{
    CGFloat Y = CGRectGetMaxY(_themeText.frame);
    NSLog(@"textFieldY:%f",Y);
    NSLog(@"endKeybordRect:%f",CGRectGetMinY(endKeybordRect));
    if (Y >CGRectGetMinY(endKeybordRect)) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -(Y - CGRectGetMinY(endKeybordRect)));
        }];
    }
}
-(void)textFieldKeybordHidden:(UITextField *)textField{
    self.transform = CGAffineTransformMakeTranslation(0, 0);
}

-(void)textFieldInputText:(NSString *)inputText{

}
#pragma mark - GPtextView delegate
-(void)textViewKeybordShow:(CGRect)endKeybordRect withAnimationDuration:(CGFloat)animationDuration{
//    CGFloat Y = CGRectGetMaxY(_detailTextView.frame);
//    NSLog(@"Y:%f",Y);
//    NSLog(@"endKeybordRectTextView:%f",CGRectGetMinY(endKeybordRect));
//    if (Y >CGRectGetMinY(endKeybordRect)) {
//        [UIView animateWithDuration:animationDuration animations:^{
//            self.transform = CGAffineTransformMakeTranslation(0, -(Y - CGRectGetMinY(endKeybordRect)));
//        }];
//    }
//     for (UIView *aView in _partyContentView.subviews) {
//         if ([aView isKindOfClass:[UITextView class]]) {
             NSLog(@"_partyContentView:%f",CGRectGetMaxY(_partyContentView.frame));
             CGFloat Y = CGRectGetMaxY(_partyContentView.frame);
             NSLog(@"Y:%f",Y);
             NSLog(@"endKeybordRectTextView:%f",endKeybordRect.origin.y);
             if (Y > CGRectGetMinY(endKeybordRect)) {
                 __weak typeof(self) weakSelf = self;
                 [UIView animateKeyframesWithDuration:animationDuration delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                     weakSelf.transform = CGAffineTransformMakeTranslation(0, -(Y - endKeybordRect.origin.y));
                 } completion:nil];
             }

//         }
//     }

}
-(void)textViewKeybordHidden{
    self.transform = CGAffineTransformMakeTranslation(0, 0);
}
#pragma mark - actions
/**
 *   点击时间View，跳出时间选择器
 *
 *  @param view UIView对象
 */
- (void)selectDate:(UITapGestureRecognizer *)tapGesture {
    [self _initDatePickerView];
}
#pragma mark - CustomIOSAlertViewDelegate
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
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
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:self.selectedDate options:0];
    
    // NSLog(@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]);
    NSString *countDown=[NSString stringWithFormat:@"%ld日 %ld:%ld:%ld",(long)[d day],(long)[d hour],(long)[d minute],(long)[d second]];
    [_countDownLabel setText:countDown];
}
/**
 *  为View添加手势
 */
- (void)_addTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidKeyBord:)];
    [self addGestureRecognizer:tap];
}
/**
 *  点击背景隐藏键盘
 *
 *  @param t 点击事件
 */
- (void)hidKeyBord:(UITapGestureRecognizer *)t{
    if (self.themeText.isFirstResponder) {
        [self.themeText resignFirstResponder];
    }
    if (self.detailTextView.isFirstResponder) {
         [self.detailTextView resignFirstResponder];
    }
}
#pragma mark - actions
- (void)checkButtonAction:(UIButton *)button{
    NSLog(@"UIbuttonClick");
    if (_isCheck) {
        [button setImage:[UIImage imageNamed:@"icon_Confirm_grey.png"] forState:UIControlStateNormal];
        _isCheck=NO;
    }else if (!_isCheck){
        [button setImage:[UIImage imageNamed:@"icon_Confirm_bright.png"] forState:UIControlStateNormal];
        _isCheck=YES;
    }
}
@end
