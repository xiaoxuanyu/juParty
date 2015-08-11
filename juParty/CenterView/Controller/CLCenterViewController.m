//
//  CLCenterViewController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/27.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLCenterViewController.h"
#import "PhotoBroswerVC.h"
#import "CLPersonalView.h"
#import "CLPhotoView.h"
#import "CLStatus.h"
#import "MJExtension.h"
#import "CLMyActivityCell.h"
#import "MBProgressHUD+MJ.h"
#import "GPImageModel.h"
#import "SDWebImageDownloader.h"
#import "CollectionCell.h"
#import "UIImageView+WebCache.h"
#import "GPImageTool.h"
#import "GPPartyHttpTool.h"
#import "UIViewController+HUD.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CoreSVP.h"
#import "GPPagerViewController.h"
//NSUInteger maxRow = 4;
//NSUInteger distance=4;
//CGFloat width = (self.view.width -((maxRow+1)*distance))/ maxRow;
#define Photo_Width (self.view.width - 20)/4
#define PhotosWall_Sheet 1001
@interface CLCenterViewController ()<UITableViewDataSource,UITableViewDelegate,ActivityCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PhotoBroswerVCDelegate>{
      UIImage *_addImage;
//    //照片墙图片
//    NSMutableArray *_photosWallArray;
}
@property (weak,nonatomic)CLPhotoView *contentView;
@property (weak,nonatomic)CLPersonalView *personDataView;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *imageUrlArray;
//@property (nonatomic,strong) UITableView *mytable;
@property (nonatomic,weak) UILabel *a1c;
@property (nonatomic,retain)CLPersonalView *p2;
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic,retain) GPImageModel *model;
@property (nonatomic,retain)UIView *headerView;
@property (nonatomic,retain)UIView *photoView;
//照片墙图片
@property (nonatomic,retain) NSMutableArray *photosWallArray;
@end

@implementation CLCenterViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _addImage = [UIImage imageNamed:@"image_photo2.png"];
//        self.isBackButton=NO;
    }
    return self;
}

//-(NSMutableArray *)images{
//    
//    if(!_images){
//_images = [NSMutableArray array];
//        }
//    
//    return _images;
//}
- (NSMutableArray *)imageUrlArray{
    if(!_imageUrlArray){
    _imageUrlArray = [NSMutableArray array];
    }
    
    return _imageUrlArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _images = [NSMutableArray array];
     _photosWallArray = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    //    NSLog(@"%@",self.images);
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpPersonDataView];
    [self initWithTableView];
    
//    CLPhotoView *p1 = [[CLPhotoView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(_p2.frame),self.view.frame.size.width, (self.view.frame.size.width -(4+1)*4)/4+4)];
// 
//    self.contentView = p1;
    [self _initPhotosView];
   
    UILabel *activity = [[UILabel alloc]init];
    activity.text = @"活动";
    activity.font = [UIFont boldSystemFontOfSize:17];
    activity.frame = CGRectMake(20,10 + CGRectGetMaxY(_myCollectionView.frame), self.view.frame.size.width, 30);
    activity.textColor = GPTextColor;
    self.a1c = activity;
//    [self.view addSubview:activity];
//    [self.view addSubview:p1];
  
    _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , CGRectGetMaxY(activity.frame))];
    [_headerView addSubview:_p2];
//     [self _initPhotosView];
    [_headerView addSubview:_myCollectionView];
//    [headerView addSubview:p1];
    [_headerView addSubview:activity];
//    [self.view addSubview:headerView];
//    self.mytable.tableHeaderView=headerView;
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:_headerView];
    [self.tableView endUpdates];


//    [self event];
    //分割线
    [self _initSeparatorLine];
    
    [self getJoinParty];
    if ([self.userID isEqualToString:self.userId]) {
     [_photosWallArray addObject:_addImage];
        [self getUserImage:YES];
    }else{
        [self getUserImage:NO];
    }

//    [self getUserImage];
//  [self contentViewDataPrepare];
}
/**
 *  分割线
 */
- (void)_initSeparatorLine{
    //ios tableview分割线到顶
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    //ios8 tableview分割线到顶,注意，此方法只能在xcode6上使用，xcode5上会报错
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    [self setExtraCellLineHidden:self.tableView];
}
#pragma mark - 隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}
#pragma mark - initView
-(void)setUpPersonDataView
{
    _p2 = [[CLPersonalView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height / 4)];
    self.personDataView = _p2;
    [_p2 setUpOtherControlsWithImageName:self.imgUrl nametext:self.userName];
//    [self.view addSubview:_p2];
}
//初始化图片集合视图
-(void)_initPhotosView{
//    UILabel *newestPhotos = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.portraitImageView.frame) + 15, 100, 30)];
//    [newestPhotos setText:@"最新照片"];
//    [newestPhotos setBackgroundColor:[UIColor clearColor]];
//    [newestPhotos setFont:[UIFont systemFontOfSize:20]];
//    [newestPhotos setTextColor:[UIColor colorWithRed:237.0f/255.0f green:241.0f/255.0f blue:253.0f/255.0f alpha:1]];
//    [_myScrollView addSubview:newestPhotos];
    //    CLPhotoView *p1 = [[CLPhotoView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(_p2.frame),self.view.frame.size.width, (self.view.frame.size.width -(4+1)*4)/4+4)];
//    _photoView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_p2.frame), self.view.width, Photo_Width+4)];
    
    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionLayout.itemSize = CGSizeMake(Photo_Width, Photo_Width);
    //设置滚动方向
    collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //每行内部cell item的间距
    collectionLayout.minimumLineSpacing = 4;
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_p2.frame), self.view.width, Photo_Width+4) collectionViewLayout:collectionLayout];
    [_myCollectionView setBackgroundColor:[UIColor clearColor]];
    //    _myCollectionView.contentSize = CGSizeMake(280, 70);
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [_myCollectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"myCollection_cell"];
    [_headerView addSubview:_myCollectionView];

    _myCollectionView.backgroundColor=GPTextColor;
//    _photoView.backgroundColor=GPTextColor;
}


/** 展示数据 */
-(void)contentViewDataPrepare{
    NSUInteger count=0;
    if (_imageUrlArray.count<=4) {
        count=[_imageUrlArray count];
    }else if (_imageUrlArray.count>4){
        count=4;
    }
    for (int i=0; i<count; i++) {
        //单独异步下载一个图片
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[_imageUrlArray objectAtIndex:i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //                    NSLog(@"SDWebImageDownloader");
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image) {
                NSLog(@"image:%@",image);
                [_images addObject:image];
                self.contentView.images=_images;
            }
        }];
        
    }
//    _contentView.images =self.images;
}



/** 事件 */
-(void)event{
    
    _contentView.ClickImageBlock = ^(NSUInteger index){
        
        //本地图片展示
       [self localImageShow:index];
        
        //展示网络图片
        //        [self networkImageShow:index];
    };
}


//- (IBAction)showAction:(id)sender {
//
//
//}
#pragma mark -
- (void)rightButtonClick:(PhotoModel *)itemModel{
    NSLog(@"删除按钮");
}
- (void)leftButtonClick:(NSMutableArray *)photosWallArray{
        NSLog(@"返回按钮%@",photosWallArray);
//            NSLog(@"返回_photosWallArray%@",_photosWallArray);
//    if (photosWallArray!=_photosWallArray) {
    
//    }
    if ([_photosWallArray containsObject:_addImage]) {
        [_photosWallArray removeObject:_addImage];
    }
    if (_photosWallArray.count<4&&[self.userID isEqualToString:self.userId]) {
        [_photosWallArray addObject:_addImage];
    }
[_myCollectionView reloadData];
}
/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index{
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:index userID:self.userID photosWallArray:_photosWallArray photoBroswerDelegate:self photoModelBlock:^NSMutableArray *{

        NSArray *localImages = _photosWallArray;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image = localImages[i];
            
//            //源frame
//            UIImageView *imageV =(UIImageView *) weakSelf.myCollectionView.subviews[i];
//            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}


/*
 *  展示网络图片
 */
-(void)networkImageShow:(NSUInteger)index{
    
//  PhotoBroswerVC *photoBroswerVC=[[PhotoBroswerVC alloc] init];
//    photoBroswerVC.userID=self.userID;
    __weak typeof(self) weakSelf=self;
//        NSLog(@"photosWallArray%@",_photosWallArray);
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:index userID:self.userID photosWallArray:_photosWallArray photoBroswerDelegate:self photoModelBlock:^NSMutableArray *{
//        NSMutableArray *photoArray=[_photosWallArray  mutableCopy];
        if ([_photosWallArray containsObject:_addImage]) {
            [_photosWallArray removeObject:_addImage];
        }
        NSArray *networkImages=_photosWallArray;
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
//            //源frame
//            UIImageView *imageV =(UIImageView *) weakSelf.myCollectionView.subviews[i];
//            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

-(void)initWithTableView
{
    CGFloat Ty = CGRectGetMaxY(self.a1c.frame);
    
    
  _tableView= [[BaseTableView alloc]initWithFrame:CGRectMake(0,Ty,self.view.frame.size.width,self.view.frame.size.height - Ty)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    self.mytable = t1;
    [self.view addSubview:_tableView];
    
    
    
}

#pragma mark - UITableViewDataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableView.tableViewdata count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseId = @"ActCell";
    CLMyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CLMyActivityCell" owner:nil options:nil] lastObject];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate=self;
    [cell.cellButton setTitle:@"收藏" forState:UIControlStateNormal];
    
    cell.status=[self.tableView.tableViewdata objectAtIndex:indexPath.row];
    return cell;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
///选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///选中cell后立即取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GPPagerViewController *pageCtrl = [[GPPagerViewController alloc]init];
    CLStatus *status=self.tableView.tableViewdata[indexPath.row];
    pageCtrl.partyType=checkParty;
    pageCtrl.partyId=status.ids;
    [self.navigationController pushViewController:pageCtrl animated:YES];
}
#pragma mark - UICollectionView delegate/datesource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _photosWallArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCollection_cell" forIndexPath:indexPath];
  cell.addPhotosImage = _addImage;
//    NSLog(@"_photosWallArray:%@",_photosWallArray);
    cell.userPhoto = _photosWallArray[indexPath.row];
//    [cell.imageView sd_setImageWithURL:_photosWallArray[indexPath.row]];
    return  cell;
}
///定义每个UICollectionView的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    /*UIEdgeInsets UIEdgeInsetsMake (
     CGFloat top,
     CGFloat left,
     CGFloat bottom,
     CGFloat right
     );*/
    return UIEdgeInsetsMake(2, 4, 2,0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    CollectionCell *cell = (CollectionCell *)[_myCollectionView cellForItemAtIndexPath:indexPath];
    for (UIView *vw in cell.subviews) {
        if ([vw isKindOfClass:[UIImageView class]]) {
            UIImageView *imView = (UIImageView *)vw;
            if (imView.image == _addImage) {//添加照片墙
                UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
                sheet.tag = PhotosWall_Sheet;
                [sheet showInView:self.view];
                
            }else{
//                _myCollectionView.ClickImageBlock = ^(NSUInteger index){
                if ([_photosWallArray[indexPath.row] isKindOfClass:[NSString class]]) {
                    // 展示网络图片
                    [self networkImageShow:indexPath.row];
                }
                else if ([_photosWallArray[indexPath.row] isKindOfClass:[UIImage class]]){
                    //本地图片展示
                        [self localImageShow:indexPath.row];
                    
                }
//
                
                
//                };
//                if (!_showBigImagesView) {
//                    _showBigImagesView = [[LookOverBigImage alloc] initWithFrame:self.view.bounds];
//                    _showBigImagesView.delegate = self;
//                    [self.view insertSubview:_showBigImagesView aboveSubview:_myScrollView];
//                }
//                if (_showBigImagesView.hidden == YES) {
//                    _showBigImagesView.hidden = NO;
//                }
//                [self.view bringSubviewToFront:_showBigImagesView];
//                
//                if ([self.model.userName isEqualToString:[Tools getCurrentUserName]]) {
//                    _showBigImagesView.canDelete = YES;
//                }else{
//                    _showBigImagesView.canDelete = NO;
//                }
//                
//                _showBigImagesView.addImage = _addImage;
//                _showBigImagesView.clickedCurrendImageNumber = indexPath.row;
//                _showBigImagesView.allImageUrlsArray = _photosWallArray;
//                
//                CGFloat startX = indexPath.row * Photo_Width + 5*(indexPath.row + 1);
//                CGFloat startY = _myCollectionView.y;
//                CGRect startFrame = CGRectMake(startX, startY, Photo_Width, Photo_Width);
//                id animotionImage;
//                id urlString = _photosWallArray[indexPath.row];
//                if ([urlString isKindOfClass:[NSString class]]) {
//                    animotionImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:urlString];
//                    if (!animotionImage) {
//                        animotionImage = urlString;
//                    }
//                }else if ([urlString isKindOfClass:[UIImage class]]){
//                    animotionImage = [UIImage imageNamed:Picture_load];
//                }
//                [_showBigImagesView startAnimotion:startFrame withLineSpacing:5.0 withStartimage:animotionImage];
//            }
        }
        }
    }
}

#pragma mark - ActivityCellDelegate
- (void)buttonClick:(CLStatus *)status{
    NSLog(@"buttonClick%d",status.ids);
    
  [self collectionParty:status.ids];
}
#pragma mark -网络请求
/**
 * 当前用户参加收藏的活动
 */
- (void)getJoinParty{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userID;
    NSLog(@"userID:%@",self.userID);
    [HttpTool getWithURL:Url_queryJoin params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpJuhui"];
            NSMutableArray *statusArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                CLStatus *status=[CLStatus objectWithKeyValues:dict];
                //                NSLog(@"status:%@bbb%@",[Utils dateToString:status.time],status.time);
                [statusArray addObject:status];
                
            }
            self.tableView.tableViewdata=statusArray;
            //            self.statuses=statusArray;
            NSLog(@"statusArray:%@",statusArray);
            [self.tableView reloadData];
        }else{
            NSLog(@"数据查询失败失败");
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        NSLog(@"数据查询失败");
    }];
}
- (void)collectionParty:(int)partyId{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userId;
    params[@"userName"]=self.nikename;
    params[@"userHeadurl"]=self.headimgurl;
    params[@"juhuiId"]=[NSNumber numberWithInt:partyId];
    [HttpTool getWithURL:Url_collectionParty params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
    [MBProgressHUD showSuccess:@"收藏成功"];
        }else{
        [MBProgressHUD showError:@"网络错误！"];
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误！"];

    }];
}
- (void)getUserImage{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userID;
    [HttpTool getWithURL:Url_queryImageByUser params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpTupian"];
            NSMutableArray *imageArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                GPImageModel *imageModel=[GPImageModel objectWithKeyValues:dict];
//               NSLog(@"GPImageModel:%@",imageModel.picurl);
                [imageArray addObject:imageModel.picurl];
                           }
            _imageUrlArray=imageArray;
            [self contentViewDataPrepare];
            
//           NSLog(@"imageArray:%@",imageArray);

//            [self.contentView layoutSubviews];
            //            for (int i=0; i<=3; i++) {
            //                [_collectionView.photosWallArray addObject:[UIImage imageNamed:@"basicUser.jpg"]];
            //            }
            //            if (imageArray.count<4) {
            //                [_collectionView.photosWallArray replaceObjectsInRange:NSMakeRange(0, imageArray.count) withObjectsFromArray:imageArray];
            //            }
//            _collectionView.photosWallArray=imageArray;
//            NSLog(@"imageArray:%@",imageArray);
//            [_collectionView reloadData];
        }else{
            [MBProgressHUD showError:@"网络错误！"];
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误！"];
        
    }];
}
- (void)getUserImage:(BOOL)ismyphotosWall{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userId"]=self.userID;
    [HttpTool getWithURL:Url_queryImageByUser params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpTupian"];
            NSMutableArray *imageArray= [NSMutableArray array];
//             [_photosWallArray removeAllObjects];
            for (NSDictionary *dict in array) {
                GPImageModel *imageModel=[GPImageModel objectWithKeyValues:dict];
               NSLog(@"GPImageModel:%@",imageModel.picurl);
                [imageArray addObject:imageModel.picurl];
            }
//            _imageUrlArray=imageArray;
            _photosWallArray=imageArray;
            NSLog(@"_photosWallArray:%@",imageArray);
            if (_photosWallArray.count<4 && ismyphotosWall) {
                [_photosWallArray addObject:_addImage];
            }
            if (!_myCollectionView) {
                [self _initPhotosView];
            }
            [_myCollectionView reloadData];
            
            //           NSLog(@"imageArray:%@",imageArray);
            
            //            [self.contentView layoutSubviews];
            //            for (int i=0; i<=3; i++) {
            //                [_collectionView.photosWallArray addObject:[UIImage imageNamed:@"basicUser.jpg"]];
            //            }
            //            if (imageArray.count<4) {
            //                [_collectionView.photosWallArray replaceObjectsInRange:NSMakeRange(0, imageArray.count) withObjectsFromArray:imageArray];
            //            }
            //            _collectionView.photosWallArray=imageArray;
            //            NSLog(@"imageArray:%@",imageArray);
            //            [_collectionView reloadData];
        }else{
            [MBProgressHUD showError:@"网络错误！"];
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误！"];
        
    }];
}
/**
 *  上传图片
 */
- (void)uploadImage:(UIImage *)image{
    
    //    UIImage *image;
    //    self.collectionView.selectImageBlock=^(UIImage *image){
    //        NSLog(@"dfdfdf");
    //    };
    //    self.collectionView.selectImageBlock=^(UIImage *image){
    
    [HttpTool uploadImageWithURL:Url_uploadImg1 params:nil image:image success:^(id json) {
        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
     
            NSLog(@"上传照片墙图片成功");
            NSString  *url=dic[@"ossUrl"];
            NSLog(@"ossUrl:%@",url);
            
                        if ([_photosWallArray containsObject:_addImage]) {
                            [_photosWallArray removeObject:_addImage];
                        }
//                      UIImage *image = [Utils image:savedImage rotation:UIImageOrientationDown];
                        [_photosWallArray addObject:url];
            //            [updataImageArray addObject:savedImage];
                        if (_photosWallArray.count < 4) {
                            [_photosWallArray addObject:_addImage];
                        }
                          [_myCollectionView reloadData];
                            NSLog(@"_photosWallArray11:%@",_photosWallArray);

            [self uplodeImageToAlbum:url];
            
        }else{
//            NSLog(@"上传照片墙图片失败");
//            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [a show];
             [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
        }
    } failure:^(NSError *error) {
//        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"上传照片墙图片失败" message:@"服务器无法连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [a show];
//        NSLog(@"上传照片墙图片，服务器连接失败:%@",error);
            [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
    }];
    
    //    };
}
/**
 *  上传图片到个人界面，juhui_id为0时是上传到个人界面
 */
- (void)uplodeImageToAlbum:(NSString *)imgUrl{
    // http://112.124.12.201:8181/guangpai/home/api/tupian_add?juhui_id=1440&openid=oIYXxjpXKPtbDqnAFhA1-vsn6zkg&pic_url=http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/20150715-066758100d794.jpg

    [GPPartyHttpTool postPartyImageWithId:@"0" openId:self.userId imageUrl:(NSString *)imgUrl success:^(id json) {
        NSData *data = json;
        NSError *error;
        NSString *shabi =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"json:%@",shabi);
        //        NSLog(@"json:%@",shabi);
        //        NSDictionary *dic=json;
        //        NSLog(@"dic:%@",dic);
          [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"上传成功" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
    } failure:^(NSError *error) {
           [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
    }];
}

#pragma arguments
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case PhotosWall_Sheet:{
            if (buttonIndex == 0) {
                ///拍照
                if ([GPImageTool isCameraAvailable] && [GPImageTool doesCameraSupportTakingPhotos]) {
                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    ///设置类型
                    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                    if ([GPImageTool isFrontCameraAvailable]) {
                        controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    }
                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                    ///设置所支持的类型，设置只能拍照
                    [mediaTypes addObject:(__bridge NSString *) kUTTypeImage];                    controller.mediaTypes = mediaTypes;
                    controller.delegate = self;
                    controller.allowsEditing = YES;
                    [self presentViewController:controller
                                                      animated:YES
                                                    completion:^(void){
                                                        NSLog(@"Picker View Controller is presented");
                                                    }];
                    
                }
                
            } else if (buttonIndex == 1) {
                ///从相册中选取
                if ([GPImageTool isPhotoLibraryAvailable]) {
                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                    controller.mediaTypes = mediaTypes;
                    ///设置代理
                    controller.delegate = self;
                    ///设置是否可以管理已经存在的图片或者视频
                    controller.allowsEditing = YES;
                    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                        [self presentViewController:controller
                                                          animated:YES
                                                        completion:^(void){
                                                            NSLog(@"Picker View Controller is presented");
                                                        }];
                    });
                }
                
            }
            break;
        }
            
        default:
            break;
    }
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    ///获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    ///将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - UIImagePickerControllerDelegate 代理方法
///保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}
///当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(imageQueue, ^{
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//          image = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(self.view.width, self.view.height)];
//       [self saveImage:image withName:@"currentImage.png"];
//        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//        
//        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//          UIImage *image1 = [Utils image:savedImage rotation:UIImageOrientationRight];
        NSLog(@"%f %f %fimageOrientation %d", [image fixOrientation].size.width, [image fixOrientation].size.height, [image fixOrientation].scale, image.imageOrientation);
        //        // 保存图片到相册中
        //        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        //        UIImageWriteToSavedPhotosAlbum(savedImage, self,selectorToCall, NULL);
        dispatch_async(dispatch_get_main_queue(), ^{
//        [_photosWallArray removeObjectAtIndex:0];
//            [_photosWallArray addObject:savedImage];
//            [_photosWallArray replaceObjectAtIndex:_index withObject:savedImage];
            //             [_photosWallArray addObject:savedImage];
        
//            NSMutableArray *updataImageArray =[NSMutableArray array];
            
            
//            if ([_photosWallArray containsObject:_addImage]) {
//                [_photosWallArray removeObject:_addImage];
//            }
       
//            [_photosWallArray addObject:savedImage];
////            [updataImageArray addObject:savedImage];
//            if (_photosWallArray.count < 4) {
//                [_photosWallArray addObject:_addImage];
//            }
//              [_myCollectionView reloadData];
//                NSLog(@"_photosWallArray11:%@",_photosWallArray);
         
        
            //展示提示框
            [CoreSVP showSVPWithType:CoreSVPTypeLoadingInterface Msg:@"上传中" duration:0 allowEdit:NO beginBlock:nil completeBlock:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //           [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"删除成功" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
                 [self uploadImage:image];
            });
            //           if (_selectImageBlock) {
            //                _selectImageBlock(savedImage);
            //                 NSLog(@"ss%@",self.selectImageBlock);
            
            //          }
//            if ([_publishDelegate respondsToSelector:@selector(uploadImage:)])  {
//                
//                [_publishDelegate uploadImage:savedImage];
//            }
            //            [_headerView.image setImage:savedImage];
            //            [_userHeadImage setImage:savedImage];
            //
            //            _userHeadImage.tag = 100;//UIKit必须在主线程执行
        });
    });
}
///当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
////第三方api - 截取图片
//- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
//{
//    CGSize rect;
//    if (asize.width/asize.height > image.size.width/image.size.height) {
//        rect.width = asize.height*image.size.width/image.size.height;
//        rect.height = asize.height;
//    }else{
//        rect.width = asize.width;
//        rect.height = asize.width*image.size.height/image.size.width;
//    }
//    return [self imageByScalingAndCroppingForSourceImage:image targetSize:rect];;
//}
//#pragma mark image scale utility
//- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
//    UIImage *newImage = nil;
//    CGSize imageSize = sourceImage.size;
//    CGFloat width = imageSize.width;
//    CGFloat height = imageSize.height;
//    CGFloat targetWidth = targetSize.width;
//    CGFloat targetHeight = targetSize.height;
//    CGFloat scaleFactor = 0.0;
//    CGFloat scaledWidth = targetWidth;
//    CGFloat scaledHeight = targetHeight;
//    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
//    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
//    {
//        CGFloat widthFactor = targetWidth / width;
//        CGFloat heightFactor = targetHeight / height;
//        
//        if (widthFactor > heightFactor)
//            scaleFactor = widthFactor; // scale to fit height
//        else
//            scaleFactor = heightFactor; // scale to fit width
//        scaledWidth  = width * scaleFactor;
//        scaledHeight = height * scaleFactor;
//        
//        // center the image
//        if (widthFactor > heightFactor)
//        {
//            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//        }
//        else
//            if (widthFactor < heightFactor)
//            {
//                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//            }
//    }
//    UIGraphicsBeginImageContext(targetSize); // this will crop
//    CGRect thumbnailRect = CGRectZero;
//    thumbnailRect.origin = thumbnailPoint;
//    thumbnailRect.size.width  = scaledWidth;
//    thumbnailRect.size.height = scaledHeight;
//    
//    [sourceImage drawInRect:thumbnailRect];
//    
//    newImage = UIGraphicsGetImageFromCurrentImageContext();
//    if(newImage == nil) NSLog(@"could not scale image");
//    
//    //pop the context to get back to the default
//    UIGraphicsEndImageContext();
//    return newImage;
//}

@end
