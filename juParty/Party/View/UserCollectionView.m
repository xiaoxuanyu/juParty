//
//  UserCollectionView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/20.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "UserCollectionView.h"
#import "GPJoinUserModel.h"
#import "JoinUserCollectionViewCell.h"
@implementation UserCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _initView];
    }
    return self;
}
/**
 *  自定义initView，添加一些基本属性
 */
- (void)_initView{
    self.delegate=self;
    self.dataSource=self;
//    [self _addTapGesture];
    [self setBackgroundColor:[UIColor clearColor]];
   ///-----注册cell和HeaderView、FooterView-----
    [self registerClass:[JoinUserCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self registerClass:[CheckPartyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    self.backgroundColor=[Utils colorWithHexString:@"#ededed"];
//    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
//    CLUserInfo *userInfo=[CLAccountTool userinfo];
//    //    NSLog(@"userInfo:%@",userInfo.nikename);
//    [dataArray addObject:userInfo];
//    self.collectionViewdatadata=dataArray;
//   [self reloadData];
}
///**
// *  为View添加手势
// */
//- (void)_addTapGesture{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidKeyBord:)];
//    [self addGestureRecognizer:tap];
//}
///**
// *  点击背景隐藏键盘
// *
// *  @param t 点击事件
// */
//- (void)hidKeyBord:(UITapGestureRecognizer *)t{
//    if (_headerView.themeText.isFirstResponder) {
//        [_headerView.themeText resignFirstResponder];
//    }
//    if (_headerView.detailTextView.isFirstResponder) {
//         [_headerView.detailTextView resignFirstResponder];
//    }
//}
#pragma mark - UICollectionViewDataSource
///定义展示的UIcollectionView的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int items=[_collectionViewdata count];
//    if (items%4!=0) {
//        items=items+4-items%4;
//        NSLog(@"%d",items);
//    }
    return items;
}
///定义展示的section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
///每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // Register nib file for the cell
     static NSString *identify=@"reportFilterCell";
    UINib *nib = [UINib nibWithNibName:@"JoinUserCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"reportFilterCell"];
//    JoinUserCollectionViewCell *cell = [[JoinUserCollectionViewCell alloc]init];
//    
//    // Set up the reuse identifier
//    cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"reportFilterCell"
//                                                     forIndexPath:indexPath];
//    static NSString *identify=@"cell";
    JoinUserCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (cell==nil) {
        NSLog(@"无法创建CollectionViewCel时打印，自定义的cell就不可能进来了");
          cell=[[[NSBundle mainBundle] loadNibNamed:@"JoinUserCollectionViewCell" owner:self options:nil] firstObject];
    }
//    ///cell背景色
//    UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
//    backgrdView.backgroundColor = [UIColor whiteColor];
//    cell.backgroundView = backgrdView;
//   [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basicUser.jpg"]]];

     GPJoinUserModel *userInfo=[self.collectionViewdata objectAtIndex:indexPath.row];
    cell.userInfo=userInfo;

  NSLog(@"userInfo:%@",cell);
    return cell;
    
}
///头部和尾部显示内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader){
    reusableview=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        ///解决重用问题
//        _headerView= (CheckPartyView *)[reusableview viewWithTag:1000];

        /*
         ***头部
         */
//        if([_headerView isEqual:[NSNull null]]||_headerView==nil){
            _headerView = [[CheckPartyView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, self.header_height)];
//            _headerView.tag=1000;
//        }
        _headerView.status=_status;
        _headerView.weatherInfo=_weatherInfo;
        NSLog(@"GPWeatherModel:%@",_weatherInfo.weather_data);
        [reusableview addSubview:_headerView];
    }
    ///------尾部------
    if (kind == UICollectionElementKindSectionFooter){
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(70,30,self.footer_height,self.footer_height )];
        [button setImage:[UIImage imageNamed:@"icon_Confirm_bright.png"] forState:UIControlStateNormal];
         [button setImage:[UIImage imageNamed:@"icon_Confirm_grey.png"] forState:UIControlStateSelected];
//            [button addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
            [reusableview addSubview:button];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+2, CGRectGetMinY(button.frame),180 , self.footer_height)];
        label.font=[UIFont boldSystemFontOfSize:20.0f];
        label.text=@"是否接受公开报名";
        label.textColor=[Utils colorWithHexString:@"#cecece"];
        [reusableview addSubview:label];
    }
    return reusableview;
}
#pragma mark - UICollectionViewDelegateFlowLayout
///定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //边距占5*5=25，4个
    //图片为正方形，边长：(fDeviceWidth-20)/4,所以总高(fDeviceWidth-20)/4 边
//    cell.userView.viewWidth=cellWidth;
    return CGSizeMake(cellWidth, cellWidth);
}
///定义每个UICollectionView的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    /*UIEdgeInsets UIEdgeInsetsMake (
     CGFloat top,
     CGFloat left,
     CGFloat bottom,
     CGFloat right
     );*/
    return UIEdgeInsetsMake(0,10, 0,10);
}
///设定指定区内Cell的最小行距，也可以直接设置UICollectionViewFlowLayout的minimumLineSpacing属性
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
        return 0;
}
///设定指定区内Cell的最小间距，也可以直接设置UICollectionViewFlowLayout的minimumInteritemSpacing属性
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
        return 0;
}
#pragma mark - UICollectionViewDelegate
///UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择%d",indexPath.row);
}
///返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


@end
