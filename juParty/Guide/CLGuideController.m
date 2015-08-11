//
//  CLGuideController.m
//  聚派
//
//  Created by 伍晨亮 on 15/6/10.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLGuideController.h"
#import "CLOAuthController.h"
@interface CLGuideController (){
    NSArray *_colorArray;
}
@property (nonatomic,weak) UIPageControl *control;
@property (nonatomic,strong) CLCollectionViewCell *celltink;
@end

@implementation CLGuideController

static NSString *reuseIdentifier = @"Cell";



-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    layout.minimumLineSpacing = 0;
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[CLCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    UIColor *color1=[Utils colorWithHexString:@"#f2cc1a"];
    UIColor *color2=[Utils colorWithHexString:@"#32ccff"];
    UIColor *color3=[Utils colorWithHexString:@"#f75c79"];
    UIColor *color4=[Utils colorWithHexString:@"#ffae48"];
   _colorArray=[[NSArray alloc] initWithObjects:color1,color2,color3 ,color4,nil];
    [self setUpPageControl];
    
}

-(void)setUpPageControl
{
    UIPageControl *control = [[UIPageControl alloc]init];
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor whiteColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    control.center = CGPointMake(self.view.width * 0.5, self.view.height+10);
    _control = control;
    [self.view addSubview:control];
}

#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}
#pragma mark - UICollectionView代理和数据源
// 返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    self.celltink = cell;
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",indexPath.row + 1];
    
//    cell.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",cell);
    
    cell.image = [UIImage imageNamed:imageName];
    cell.delegate = self;

    [cell setIndexPath:indexPath count:4];
    //cell背景色
    UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
    backgrdView.backgroundColor = [_colorArray objectAtIndex:indexPath.row];
    cell.backgroundView = backgrdView;
    return cell;
}

-(void)SwitchingControllerToAuthorizeArrivals
{
    [UIView animateWithDuration:1.5 animations:^{
        
        CLOAuthController *oaVc = [[CLOAuthController alloc]init];
//        oaVc.delegate = self;
        [self presentViewController:oaVc animated:YES completion:^{
            
        }];
        
    }];
}

@end
