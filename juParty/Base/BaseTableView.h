//
//  BaseTableView.h
//  聚派
//
//  Created by yintao on 15/6/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTableView;
/**
 *  tableView事件协议
 */
@protocol UITableViewEventdelegate <NSObject>
///可选的
@optional
///下拉
- (void)pullDown:(BaseTableView *)tableView;
///上拉
- (void)pullUp:(BaseTableView *)tableView;
///选中一个cell
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
/**
 * TableView的基类
 */
@interface BaseTableView :UITableView<UITableViewDataSource,UITableViewDelegate>{
    BOOL _reloading;
}
/**
 *  是否需要下拉效果
 */
@property (nonatomic,assign)BOOL refreshHeader;
/**
 *  为tableview提供数据
 */
@property (nonatomic,retain)NSMutableArray *tableViewdata;
/**
 *  声明UITableViewEventdelegate协议
 */
@property (nonatomic,assign)id<UITableViewEventdelegate>eventDelegate;
@end
