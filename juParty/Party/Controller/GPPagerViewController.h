//
//  GPPagerViewController.h
//  GPPagerViewController
//
//  Created by yintao on 15/5/14.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionView.h"
#import "UserCollectionView.h"
#import "MapNavigationView.h"
#import "BaseViewController.h"
#import "PagerBasicView.h"
#import "GPWeatherModel.h"
/**
 *  三屏滑动，查看聚会页面
 */
@interface GPPagerViewController : BaseViewController<UIScrollViewDelegate,partyButtonDelegate>{
    BOOL _isJoin;
}
///聚会类型
typedef NS_ENUM(NSInteger, PartyTypeMap){
    startPartyMap, //发起聚会
    checkPartyMap //查看聚会
};
@property (nonatomic,assign)PartyTypeMap partyType;
@property(nonatomic,strong)UIScrollView* scrolview;
@property(nonatomic,strong)UIButton* btn1;
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)UIButton* btn3;
@property(nonatomic,strong)UIImageView* imageLine;
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, assign) int partyId;
@property (nonatomic,retain) CollectionView *collectionView;
@property (nonatomic,retain)UserCollectionView *userCollectionView;
@property (nonatomic,retain)PagerBasicView *pagerBasicView;
//@property (nonatomic,retain)BasicView *basicView;
@property (nonatomic,retain)MapNavigationView *mapNavigationView;
@property (nonatomic,retain)NSMutableArray *userArray;
@property (nonatomic,strong)GPWeatherModel *weatherInfo;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,retain)CLStatus *status;
@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,retain)NSMutableArray *placeMutableArray;
//@property (nonatomic,assign)NSInteger partyType;
@end
