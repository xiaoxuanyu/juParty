//
//  GPWeatherModel.m
//  聚派
//
//  Created by yintao on 15/6/30.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "GPWeatherModel.h"

@implementation GPWeatherModel
- (NSDictionary *)objectClassInArray
{
    return @{@"index":[IndexDetail class],@"weather_data":[WeatherData class]};
}
@end
@implementation IndexDetail
@end
@implementation WeatherData

@end

