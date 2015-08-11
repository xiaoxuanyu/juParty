//
//  CLContactUsView.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/22.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLContactUsView.h"

@interface CLContactUsView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CLContactUsView

- (void)viewDidLoad {
    [super viewDidLoad];
    _companyName.textAlignment=NSTextAlignmentCenter;
    _version.textAlignment=NSTextAlignmentCenter;
    self.view.backgroundColor=[Utils colorWithHexString:@"#ededed"];
    self.table.backgroundColor=[Utils colorWithHexString:@"#ededed"];
    _companyName.textColor=GPTextColor;
    _version.textColor=GPTextColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"us";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *labelArray=[[NSArray alloc] initWithObjects:@"官方微信", @"官方微博",nil];
    cell.textLabel.text = [labelArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=GPTextColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///选中cell后立即取消选中
    [self.table deselectRowAtIndexPath:indexPath animated:NO];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"通知设置";
//}


@end
