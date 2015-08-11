//
//  BaseTableView.m
//  聚派
//
//  Created by yintao on 15/6/15.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
/**
 *  init方法，定义View的frame和style
 *
 *  @param frame tableview的frame
 *  @param style tableview的样式
 *
 *  @return 返回tableView对象
 */
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    return self;
}
/**
 *  使用xib加载view
 *
 *  @return 返回tableView对象
 */
- (void)awakeFromNib{
    [self _initView];
}
/**
 *  自定义init方法，添加协议和一些基础属性
 */
- (void)_initView{

    self.dataSource=self;
    self.delegate=self;
    self.refreshHeader=YES;
//    //ios tableview分割线到顶
//    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [self setSeparatorInset:UIEdgeInsetsZero];
//        
//    }
//    //ios8 tableview分割线到顶,注意，此方法只能在xcode6上使用，xcode5上会报错
//    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
//        
//        [self setLayoutMargins:UIEdgeInsetsZero];
//        
//    }
//     [self setExtraCellLineHidden:self];
}
//#pragma mark - 隐藏多余的分割线
//- (void)setExtraCellLineHidden: (UITableView *)tableView
//
//{
//    
//    UIView *view = [UIView new];
//    
//    view.backgroundColor = [UIColor clearColor];
//    
//    [tableView setTableFooterView:view];
//    
//}
/**
 *  tableView的reloadData方法
 */
- (void)reloadData{
    [super reloadData];
}

#pragma mark - UItableView delegate
/**
 *  定义tableView的组数
 *
 *  @param NSInteger 需要返回的tableview分组个数
 *
 *  @return 返回分组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/**
 *  定义每组行数
 *
 *  @param tableView tableView对象
 *  @param section tableView的组数
 *
 *  @return 返回每组行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableViewdata count];
}
/**
 *  定义tableView的cell显示内容
 *
 *  @param tableView tableView对象
 *  @param indexPath
 *
 *  @return 返回每行的单元格
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}
/**
 *  选中Cell响应事件
 *
 *  @param tableView tableView对象
 *  @param indexPath  
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//        
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//        
//    }
//    
//}
@end
