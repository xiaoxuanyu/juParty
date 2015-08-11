//
//  ImageAlbumViewController.m
//  GPCollectionView
//
//  Created by yintao on 15/5/26.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "ImageAlbumViewController.h"
#import "GPPartyHttpTool.h"
#import "UIViewController+HUD.h"
#import "HttpTool.h"
#import "CoreSVP.h"
#import "PhotoBroswerVC.h"
@interface ImageAlbumViewController ()<PhotoBroswerVCDelegate>{
//    UIImage *_addImage;
    //    //照片墙图片
    //    NSMutableArray *_photosWallArray;
}

@end

@implementation ImageAlbumViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"相册";
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //------添加相册------

//
    
    
    float header_height=fDeviceHeight/2;
    float fotter_height=40;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    ///头部
    flowLayout.headerReferenceSize=CGSizeMake(fDeviceWidth, header_height+10);
    ///尾部
    flowLayout.footerReferenceSize=CGSizeMake(fDeviceWidth, fotter_height+10);
    self.collectionView=[[CollectionView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];
    self.collectionView.header_height=header_height;
    self.collectionView.footer_height=fotter_height;
    self.collectionView.partyType=0;
    self.collectionView.publishDelegate=self;
    [self.view addSubview:self.collectionView];
    
    NSMutableArray *imageArray= [NSMutableArray array];
//   self.collectionView.addImage = [UIImage imageNamed:@"image_photo2.png"];
    for (int i=0; i<=3; i++) {
        [imageArray addObject:self.collectionView.addImage];
        //        [_collectionView.photosWallArray addObject:[UIImage imageNamed:@"basicUser.jpg"]];
    }
    NSLog(@"[imageArray count]:%d",[imageArray count]);
    _collectionView.photosWallArray=imageArray;
 [self.collectionView reloadData];
    }
#pragma mark - publishCilckDelegate
/**
 *  点击发布按钮
 *
 *  @param button UIButton 对象
 */
-(void)publishClick:(UIButton *)button{
    NSLog(@"发布");
    [self publishParty];
    NSLog(@"sss:%@",self.partyId);
}
/**
 *  浏览图片
 *
 *  @param index 图片位置
 */
- (void)selectImage:(NSUInteger)index photosWallArray:(NSMutableArray *)photosWallArray{
    __weak typeof(self) weakSelf=self;


    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:0 userID:self.userId photosWallArray:photosWallArray photoBroswerDelegate:self photoModelBlock:^NSMutableArray *{
            NSLog(@"photosWallArray%@ index:%lu",photosWallArray,(unsigned long)index);
             NSMutableArray *photoArray=[photosWallArray  mutableCopy];
        if ([photoArray containsObject:self.collectionView.addImage]) {
            [photoArray removeObject:self.collectionView.addImage];
        }
                NSLog(@"photosWallArray%@ index:%lu",photosWallArray,(unsigned long)index);
        NSArray *networkImages=photoArray;
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
//            //源frame
//            UIImageView *imageV =(UIImageView *) weakSelf.collectionView.subviews[i];
//            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];

}
/**
 *  上传图片
 */
- (void)uploadImage:(UIImage *)image index:(NSInteger)index{

//    UIImage *image;
//    self.collectionView.selectImageBlock=^(UIImage *image){
//        NSLog(@"dfdfdf");
//    };
//    self.collectionView.selectImageBlock=^(UIImage *image){
    //展示提示框
    [CoreSVP showSVPWithType:CoreSVPTypeLoadingInterface Msg:@"上传中" duration:0 allowEdit:NO beginBlock:nil completeBlock:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HttpTool uploadImageWithURL:Url_uploadImg1 params:nil image:image success:^(id json) {
            NSLog(@"json:%@",json);
            NSDictionary *dic=json;
            if ([[dic objectForKey:@"success"] boolValue]==1) {
                NSLog(@"上传照片墙图片成功");
                NSString  *url=dic[@"ossUrl"];
                NSLog(@"ossUrl:%@",url);
                
//            if ([_collectionView.photosWallArray containsObject:self.collectionView.addImage]) {
//            [_collectionView.photosWallArray removeObject:self.collectionView.addImage];
//            }
//           [_collectionView.photosWallArray addObject:url];
//
//         if (_collectionView.photosWallArray.count < 4) {
//             [_collectionView.photosWallArray addObject:_collectionView.addImage];
//             
//                
//           }
             
//                if ([_collectionView.photosWallArray containsObject:self.collectionView.addImage]) {
//                    [_collectionView.photosWallArray removeObject:self.collectionView.addImage];
//                }
                //                      UIImage *image = [Utils image:savedImage rotation:UIImageOrientationDown];
//                [_collectionView.photosWallArray addObject:url];
                //            [updataImageArray addObject:savedImage];
//                if (_collectionView.photosWallArray.count < 4) {
//                    for (int i=_collectionView.photosWallArray.count; i<4; i++) {
//                              [_collectionView.photosWallArray addObject:_collectionView.addImage];
//                    }
              
//                }

              [ _collectionView.photosWallArray replaceObjectAtIndex:index withObject:url];

                [self.collectionView reloadData];
                [self uplodeImageToAlbum:url];
              
            }else{
//                NSLog(@"上传照片墙图片失败");
//                UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                [a show];
                    [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
            }
        } failure:^(NSError *error) {
//            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"上传照片墙图片失败" message:@"服务器无法连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [a show];
//            NSLog(@"上传照片墙图片，服务器连接失败:%@",error);
                       [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"上传失败" duration:1.0f allowEdit:NO beginBlock:nil completeBlock:nil];
        }];
    });
//    };
}
#pragma mark - 网络请求
/**
 *  发布聚会
 */
- (void)publishParty{
    [GPPartyHttpTool postPartyFinishWithId:self.partyId success:^(id json) {
        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        NSLog(@"dic:%@",dic);
        [self showHint:@"聚会发布成功"];
    } failure:^(NSError *error) {
  [self showHint:@"聚会发布失败"];
    }];
}
/**
 *  上传图片到相册service
 */
- (void)uplodeImageToAlbum:(NSString *)imgUrl{
   // http://112.124.12.201:8181/guangpai/home/api/tupian_add?juhui_id=1440&openid=oIYXxjpXKPtbDqnAFhA1-vsn6zkg&pic_url=http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/20150715-066758100d794.jpg
    NSLog(@"%@额外人口我惹我肉味儿苦命人胃口人民网%@",self.partyId,self.userId);
    [GPPartyHttpTool postPartyImageWithId:self.partyId openId:self.userId imageUrl:(NSString *)imgUrl success:^(id json) {
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
//http://oss-cn-qingdao.aliyuncs.com/guangpaiwx/20150630-55920326ba717.jpg
//http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/20150630-eb739174f6e54.jpg
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
