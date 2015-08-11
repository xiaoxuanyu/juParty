//
//  MapTableView.h
//  GPCollectionView
//
//  Created by yintao on 15/5/22.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
/**
 * publishCilckDelegate协议
 */
@protocol selectTableViewDelegate <NSObject>
@optional
///选好图片
- (void)selectTableViewWithLatitude:(double)latitude withLongitude:(double)longitude withTitle:(NSString *)name withAddress:(NSString *)address;
@end
/**
 *  地图下方地点tableView
 */
@interface MapTableView:BaseTableView<UITableViewDataSource,UITableViewDelegate>{
    NSNumber *_selectIndex;
}
///聚会类型
typedef NS_ENUM(NSInteger, PartyTypeTable){
    startPartyTable, //发起聚会
    checkPartyTable //查看聚会
};
@property (nonatomic,assign)PartyTypeTable partyType;
/**
 *  声明publishCilckDelegate协议
 */
@property (nonatomic,assign) id <selectTableViewDelegate> selectTableViewDelegate;
@end
