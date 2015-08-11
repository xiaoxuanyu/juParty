//
//  MapTableView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/22.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "MapTableView.h"
#import "SelectPlaceCell.h"
#import "ShowPlaceCell.h"
@implementation MapTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    return self;
}
/**
 *  自定义init方法，添加协议和一些基础属性
 */
- (void)_initView{
    self.dataSource=self;
    self.delegate=self;
    _selectIndex=[NSNumber numberWithInt:-1];
//    UIView *tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth,5)];
//    self.tableFooterView=tableFooterView;
    //ios tableview分割线到顶
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self setSeparatorInset:UIEdgeInsetsZero];
        
    }
    //ios8 tableview分割线到顶,注意，此方法只能在xcode6上使用，xcode5上会报错
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self setLayoutMargins:UIEdgeInsetsZero];
        
    }
    [self setExtraCellLineHidden:self];
}
#pragma mark - 隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}

#pragma mark - tableView data source
/////Customize the number of sections in the table view.
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//
///Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count=0;
    if (self.partyType==startPartyTable) {
        count=self.tableViewdata.count;
    }
    NSLog(@"self.partyType%d",self.partyType);
    if (self.partyType==checkPartyTable) {
        count=self.tableViewdata.count-2;
    }
    return count;
}
///定义tableView的cell显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify1=@"SelectPlaceCell";
     static NSString *identify2=@"ShowPlaceCell";
    SelectPlaceCell  *cell1=[tableView dequeueReusableCellWithIdentifier:identify1];
     ShowPlaceCell  *cell2=[tableView dequeueReusableCellWithIdentifier:identify2];
    ///----发起聚会选择地点的情况下，调用SelectPlaceCell---
    if (self.partyType==startPartyTable) {
        if (cell1==nil) {
            cell1=[[[NSBundle mainBundle] loadNibNamed:@"SelectPlaceCell" owner:self options:nil] firstObject];
             cell1.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
        }
        cell1.backgroundColor=[UIColor whiteColor];
        cell1.business=[self.tableViewdata objectAtIndex:indexPath.row];
        if (_selectIndex==[NSNumber numberWithInteger:indexPath.row])
        {
            cell1.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell1.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell1;
    }
    ///----查看聚会查看地点的情况下，调用ShowPlaceCell---
    if (self.partyType==checkPartyTable) {
//        /_positionString,_placeLatitude,_placeLongitude,_positionDetailString,timeString
      /*  (
         "",
         "秀玉红茶坊(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)",
         "30.477810",
         "114.422790",
         "洪山区关山大道519号光谷天地",
         14369614
         )*/
        if (cell2==nil) {
            cell2=[[[NSBundle mainBundle] loadNibNamed:@"ShowPlaceCell" owner:self options:nil] firstObject];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
        }
        cell2.backgroundColor=[UIColor whiteColor];
        cell2.positionOrderLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        NSArray *placeArray=[self.tableViewdata objectAtIndex:indexPath.row];
        NSLog(@"placeArray:%@",[placeArray objectAtIndex:1]);
        cell2.positionLabel.text=[placeArray objectAtIndex:1];
        cell2.positionDetailLabel.text=[placeArray objectAtIndex:4];
        if (_selectIndex==[NSNumber numberWithInteger:indexPath.row])
        {
            cell2.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell2.accessoryType = UITableViewCellAccessoryNone;
        }
         return cell2;
    }

    return nil;
   
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
#pragma mark- UITableViewDelegate
///设置行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
///选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///选中cell后立即取消选中
    [self deselectRowAtIndexPath:indexPath animated:NO];

    if ([_selectTableViewDelegate respondsToSelector:@selector(selectTableViewWithLatitude:withLongitude:withTitle:withAddress:)])  {

        if (self.partyType==startPartyTable) {
                GPBusinessModel *business=[self.tableViewdata objectAtIndex:indexPath.row];
                  [_selectTableViewDelegate selectTableViewWithLatitude:business.latitude withLongitude:business.longitude withTitle:business.name withAddress:business.address];
        }
       else if (self.partyType==checkPartyTable) {
              NSArray *placeArray=[self.tableViewdata objectAtIndex:indexPath.row];
           double userLatitude=[[placeArray objectAtIndex:2] doubleValue];
           double userLongitude=[[placeArray objectAtIndex:3] doubleValue];
           NSString *positionString=[placeArray objectAtIndex:1];
           NSString *positionDetailString=[placeArray objectAtIndex:4];
           //        /_positionString,_placeLatitude,_placeLongitude,_positionDetailString,timeString
           /*  (
            "",
            "秀玉红茶坊(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)",
            "30.477810",
            "114.422790",
            "洪山区关山大道519号光谷天地",
            14369614
            )*/
               [_selectTableViewDelegate selectTableViewWithLatitude:userLatitude withLongitude:userLongitude withTitle:positionString withAddress:positionDetailString];
        }
  
    }
    _selectIndex=[NSNumber numberWithInteger:indexPath.row];
    [tableView reloadData];
}

@end
