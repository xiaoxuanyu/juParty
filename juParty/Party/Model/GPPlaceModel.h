//
//  GPPlaceModel.h
//  聚派
//
//  Created by yintao on 15/8/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <Foundation/Foundation.h>
/*_positionString,_placeLatitude,_placeLongitude,_positionDetailString*/
@interface GPPlaceModel : NSObject
@property (nonatomic,copy)NSString *positionString;
@property (nonatomic,copy)NSString *positionDetailString;
/**
 * 地点纬度
 */
@property (nonatomic,assign) double placeLatitude;
/**
 *  地点经度
 */
@property (nonatomic,assign) double placeLongitude;
@property (nonatomic,assign)BOOL isSelect;
@end
