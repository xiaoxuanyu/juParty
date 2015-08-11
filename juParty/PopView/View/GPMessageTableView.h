//
//  GPMessageTableView.h
//  聚派
//
//  Created by yintao on 15/7/4.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "GPMessageModel.h"
/**
 * deleteMessageDelegate协议
 */
@protocol deleteMessageDelegate <NSObject>
@optional
///点击发布按钮
-(void)deleteMessageForRowAtIndexPath:(NSIndexPath *)indexPath messageModel:(GPMessageModel *)messgeModel;
@end
@interface GPMessageTableView : BaseTableView<UITableViewDataSource,UITableViewDelegate>
/**
 *  声明deleteMessageDelegate协议
 */
@property (nonatomic,assign) id <deleteMessageDelegate> deleteMessageDelegate;
@end
