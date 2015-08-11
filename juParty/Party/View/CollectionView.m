//
//  CollectionView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/14.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "CollectionView.h"
#import "ShareView.h"
#import "UIView+Additions.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+WebCache.h"
#define fDeviceWidth [[UIScreen mainScreen] bounds].size.width
#define fDeviceHeight [[UIScreen mainScreen] bounds].size.height
@interface CollectionView (){
UIImage *_addImage;
//    //照片墙图片
//    NSMutableArray *_photosWallArray;
}
@end
@implementation CollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _initView];
          _addImage = [UIImage imageNamed:@"image_photo2.png"];
    }
    return self;
}
/**
 *  自定义initView，添加一些基本属性
 */
- (void)_initView{
    _photosWallArray=[[NSMutableArray alloc] init];
//    if (self.partyType==startParty){
//        for (int i=0; i<=3; i++) {
//            [_photosWallArray addObject:[UIImage imageNamed:@"basicUser.jpg"]];
//        }
//    }
    self.delegate=self;
    self.dataSource=self;
    [self setBackgroundColor:[Utils colorWithHexString:@"#ededed"]];
    ///-----注册cell和HeaderView、FooterView-----
    [self registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

}

#pragma mark - UICollectionViewDataSource
///定义展示的UIcollectionView的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger count=0;

//   if (_photosWallArray.count>0&&_photosWallArray.count<=4) {
//       count=3;
//    }
//    else if (_photosWallArray.count>4&&[_photosWallArray count]!=0)
//    {
        count=[_photosWallArray count]-1;
//    }
    return count;
}
///定义展示的section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
///每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"cell";

    CollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCel时打印，自定义的cell就不可能进来了");
    }
//   if (indexPath.row==[_photosWallArray count]+1) {
//        cell.imageView.image=[UIImage imageNamed:@"basicUser.jpg"];
//   }else{
//       if (_photosWallArray) {

//    cell.imageView.image=[UIImage imageNamed:@"basicUser.jpg"];
    if (self.partyType==startParty){
        NSLog(@"edd:%d",[_photosWallArray count]);
//         cell.imageView.image=[_photosWallArray objectAtIndex:indexPath.row+1];
        cell.addPhotosImage=_addImage;
        cell.userPhoto=[_photosWallArray objectAtIndex:indexPath.row+1];
    }
    else if (self.partyType==checkParty){
        cell.addPhotosImage = _addImage;
        NSLog(@"_photosWallArray:%@",_photosWallArray);
        cell.userPhoto = _photosWallArray[indexPath.row+1];
   
//        cell.addPhotosImage=_addImage;
////         GPImageModel *imageModel=[_photosWallArray objectAtIndex:indexPath.row+1];
//        cell.userPhoto=[_photosWallArray objectAtIndex:indexPath.row+1];
//        if (_photosWallArray.count>0&&_photosWallArray.count<4) {
//            if (indexPath.row+1>=_photosWallArray.count) {
//                
//                cell.imageView.image=[UIImage imageNamed:@"image_photo2.png"];
//            }
//            else{
//                GPImageModel *imageModel=[_photosWallArray objectAtIndex:indexPath.row+1];
//                NSLog(@"imgUrl:%@",imageModel.picurl);
////                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.picurl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
//                cell.userPhoto=imageModel.picurl;
//            }
//            GPImageModel *imageModel=[_photosWallArray objectAtIndex:0];
//            NSLog(@"imgUrl:%@",imageModel.picurl);
//        }
//        else if (_photosWallArray.count>=4){
//                GPImageModel *imageModel=[_photosWallArray objectAtIndex:indexPath.row+1];
//                NSLog(@"imgUrl:%@",imageModel.picurl);
////            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.picurl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
//            cell.userPhoto=imageModel.picurl;
//        }
//     
   
//        NSString *imgUrl=imageModel.picurl;

//     [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
    }
//    else if (self.partyType==checkParty){
//        NSString *imgUrl=[_photosWallArray objectAtIndex:indexPath.row+1];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
//    }
//       }
//
//   }
//    else if (indexPath.row<[_photosWallArray count]){
//        cell.imageView.image=[_photosWallArray objectAtIndex:indexPath.row];
//    }
    
//    cell.text.text=[NSString stringWithFormat:@"Cell %ld",(long)indexPath.row];
    return cell;
    
}
///头部和尾部显示内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
       reusableview=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        /*
         ***头部
         */
        _headerView = [[CollectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, self.header_height)];
        
        [reusableview addSubview:_headerView];
        _headerView.imageView.userInteractionEnabled = YES;
        _index=0;
//        if (self.partyType==startParty) {
//            for (UIView *vw in reusableview.subviews) {
//                
//                if ([[_photosWallArray objectAtIndex:0] isKindOfClass:[UIImage class]]) {
//                    
//                    UIImageView *imView = (UIImageView *)vw;
//                    NSLog(@"VM%@",imView.image);
//                    NSLog(@"_addImage%@",_addImage);
//                    if (imView.image == _addImage) {
//                        _headerView.image=[_photosWallArray objectAtIndex:0];
//
//                    }
//                    ///添加点击事件
//                    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
//                    [_headerView.image addGestureRecognizer:tapGesturRecognizer ];
//                }else if ([[_photosWallArray objectAtIndex:0] isKindOfClass:[NSString class]]) {
//             [_headerView.image sd_setImageWithURL:[NSURL URLWithString:[_photosWallArray objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"image_photo1.png"]];
//                    ///添加点击事件
//                    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
//                    [_headerView.image addGestureRecognizer:tapGesturRecognizer ];
//                }
//            }
//         
//            
//           
// 
//        }
//        else if (self.partyType==checkParty){
//            if (_photosWallArray.count>0) {
//                GPImageModel *imageModel=[_photosWallArray objectAtIndex:0];
//                      NSLog(@"imgUrl:%@",imageModel.picurl);
//                [_headerView.image sd_setImageWithURL:[NSURL URLWithString:imageModel.picurl] placeholderImage:[UIImage imageNamed:@"image_photo1.png"]];
//                       cell.userPhoto = _photosWallArray[indexPath.row+1];
//            }
            if (_photosWallArray.count>0) {
                _headerView.userPhoto=_photosWallArray[0];
//                        [_headerView.imageView sd_setImageWithURL:_photosWallArray[0]];
            if ([[_photosWallArray objectAtIndex:0] isKindOfClass:[UIImage class]]) {
                NSLog(@"_addImage%@",_addImage);
                
                
                ///添加点击事件
                UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
                [_headerView.imageView addGestureRecognizer:tapGesturRecognizer];
                _headerView.imageView=[_photosWallArray objectAtIndex:0];
            }else if ([[_photosWallArray objectAtIndex:0] isKindOfClass:[NSString class]]) {
        
               //添加点击事件
                UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
                [_headerView.imageView addGestureRecognizer:tapGesturRecognizer];
            }
            }else if (_photosWallArray.count==0){
                  [_headerView removeFromSuperview];
            }
    
//             NSString *imgUrl=[_photosWallArray objectAtIndex:0];
//             [_headerView.image sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
//            if (_photosWallArray!=nil) {
//                GPImageModel *imageModel=[_photosWallArray objectAtIndex:0];
//                NSLog(@"imgUrl:%@",imageModel.picurl);
////                [_headerView.image sd_setImageWithURL:[NSURL URLWithString:imageModel.picurl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
////                  _headerView.imageModel=[_photosWallArray objectAtIndex:0];
//            }
//
        }
//    }
   ///------尾部------
    if (kind == UICollectionElementKindSectionFooter){
        if (self.partyType==startParty) {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(0, 0,fDeviceWidth,self.footer_height )];
            [button setBackgroundColor:[Utils colorWithHexString:@"f2cc1a"]];
            [button setTitle:@"发布" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
            [reusableview addSubview:button];
        }
        
    }
    
    return reusableview;
}

#pragma mark - UICollectionViewDelegateFlowLayout
///定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  边距占5*4=20，3个
     *  图片为正方形，边长：(fDeviceWidth-20)/3,所以总高(fDeviceWidth-20)/3 边
     */

    return CGSizeMake((fDeviceWidth-20)/3, (fDeviceWidth-20)/3);

//    CGFloat height=0;
//    CGFloat width=0;
//    if (indexPath.row==0) {
//        width=fDeviceWidth-10;
//        height=fDeviceHeight/2;
//    }else{
//        width=(fDeviceWidth-20)/3;
//        height=(fDeviceWidth-20)/3;
//    }
//
//    return CGSizeMake(width, height);
}
///定义每个UICollectionView的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    /*UIEdgeInsets UIEdgeInsetsMake (
                                   CGFloat top,
                                   CGFloat left,
                                   CGFloat bottom, 
                                   CGFloat right 
                                   );*/
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
///设定指定区内Cell的最小行距，也可以直接设置UICollectionViewFlowLayout的minimumLineSpacing属性
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
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
    _index=indexPath.row+1;
    CollectionCell *cell = (CollectionCell *)[self cellForItemAtIndexPath:indexPath];
    for (UIView *vw in cell.subviews) {
        
        if ([vw isKindOfClass:[UIImageView class]]) {
          
            UIImageView *imView = (UIImageView *)vw;
              NSLog(@"VM%@",imView.image);
               NSLog(@"_addImage%@",_addImage);
            if (imView.image == _addImage) {//添加照片墙
//                UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
//                sheet.tag = PhotosWall_Sheet;
//                [sheet showInView:self.view];
                [self editPortrait];
                
            }else{
                //                _myCollectionView.ClickImageBlock = ^(NSUInteger index){
               
                NSLog(@"FWEIJ");
                if ([self.publishDelegate respondsToSelector:@selector(selectImage:photosWallArray:)]) {
                    [self.publishDelegate selectImage:_index photosWallArray:_photosWallArray];
                }
            }
        }
    }
//    if (self.partyType==startParty) {
//        [self editPortrait];
//    }
}
///返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
#pragma mark - ImageClick
- (void)selectImage{
    if ([self.publishDelegate respondsToSelector:@selector(selectImage:photosWallArray:)]) {
        [self.publishDelegate selectImage:0 photosWallArray:_photosWallArray];
    }
}
#pragma mark - sheet
///从底部弹出choiceSheet,设置图片
- (void)editPortrait{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    choiceSheet.tag=50;
    [choiceSheet showInView:self];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case 50:{
            if (buttonIndex == 0) {
                ///拍照
                if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    ///设置类型
                    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                    if ([self isFrontCameraAvailable]) {
                        controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    }
                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                    ///设置所支持的类型，设置只能拍照
                    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];                    controller.mediaTypes = mediaTypes;
                    controller.delegate = self;
                    controller.allowsEditing = YES;
                    [self.viewController presentViewController:controller
                                       animated:YES
                                     completion:^(void){
                                         NSLog(@"Picker View Controller is presented");
                                     }];
                    
                }
                
            } else if (buttonIndex == 1) {
                ///从相册中选取
                if ([self isPhotoLibraryAvailable]) {
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
                        [self.viewController presentViewController:controller
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
        
        [self saveImage:image withName:@"currentImage.png"];
        
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//        // 保存图片到相册中
//        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
//        UIImageWriteToSavedPhotosAlbum(savedImage, self,selectorToCall, NULL);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"_photosWallArray:%@",_photosWallArray);
//            [_photosWallArray replaceObjectAtIndex:_index withObject:savedImage];
//             [_photosWallArray addObject:savedImage];
//            [self reloadData];
          
//           if (_selectImageBlock) {
//                _selectImageBlock(savedImage);
//                 NSLog(@"ss%@",self.selectImageBlock);
            
//          }
            if ([_publishDelegate respondsToSelector:@selector(uploadImage:index:)])  {
         
                [_publishDelegate uploadImage:savedImage index:_index];
            }
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
    [self.viewController dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - 摄像头和相册相关的公共类
///判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
///后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
///前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
// 检查摄像头是否支持拍照
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
#pragma mark - 相册文件选取相关
///相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
///是否可以在相册中选择视频
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
///是否可以在相册中选择图片
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark - action
/**
 *  点击发布按钮
 *
 *  @param button 点击发布按钮
 */
- (void)publishAction:(UIButton *)button{
//    [UIView animateWithDuration:0.3 animations:^{
//        ShareView *shareView=[[ShareView alloc] initWithFrame:CGRectMake(0, 100, fDeviceWidth, 200)];
//        [self addSubview:shareView];
//    }completion:^(BOOL finished){
//        
//    }];
    if ([_publishDelegate respondsToSelector:@selector(publishClick:)])  {
        
        [_publishDelegate publishClick:button];
    }
   
}
@end
