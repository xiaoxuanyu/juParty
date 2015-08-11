//
//  ImageViewController.m
//  juParty
//
//  Created by yintao on 15/8/8.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "ImageViewController.h"
#import "CollectionView.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "CoreSVP.h"
#import "PhotoBroswerVC.h"
#import "GPPartyHttpTool.h"
@interface ImageViewController ()<publishCilckDelegate,PhotoBroswerVCDelegate>

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float header_height=fDeviceHeight/2;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize=CGSizeMake(fDeviceWidth, header_height+10);//头部
    self.collectionView=[[CollectionView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-108) collectionViewLayout:flowLayout];
    self.collectionView.header_height=header_height;
    self.collectionView.publishDelegate=self;
    self.collectionView.partyType=checkParty;
    //[self.view addSubview:self.collectionView];
    [self.view addSubview:self.collectionView];
       self.userID= _status.plannerId;
      _isJoin=NO;
    [self getPartyImage];
//    [self queryPartyById];
}
#pragma mark - 网络请求
/**
 *  根据聚会id查询聚会信息
 */
- (void)queryPartyById{
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"id"]=[NSNumber numberWithInt:self.partyId];
    [HttpTool getWithURL:Url_queryPartyById params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpJuhui"];
            
            NSMutableArray *statusArray= [NSMutableArray array];
            _status=[[CLStatus alloc] init];
            for (NSDictionary *dict in array) {
                _status=[CLStatus objectWithKeyValues:dict];
                NSLog(@"plannerId:%@",_status.plannerId);
                self.userID= _status.plannerId;
                [statusArray addObject:_status];
                //                _userCollectionView.headerView.status=status;
                //                _userCollectionView.headerView.themeText.text=status.title;
                //                [_userCollectionView.headerView setNeedsDisplay];
                //                [_userCollectionView.headerView setNeedsLayout];
            }
            //             NSMutableArray *statusArray= [NSMutableArray array];
            //           [_pagerBasicView.userCollectionView reloadData];
        }else{
            NSLog(@"数据查询失败失败");
            //            UIAlertView *a = [[UIAlertView alloc] initWithTitle:nil message:@"上传照片墙图片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            //            [a show];
        }
    } failure:^(NSError *error) {
        NSLog(@"数据查询失败");
    }];
}

- (void)getPartyImage{
    //http://192.168.20.138:8089/SSM/Front/gp_tupian_query_byjuhui?juhuiId=1440
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"juhuiId"]=[NSNumber numberWithInt:self.partyId];
    [HttpTool getWithURL:Url_queryImage params:params success:^(id json) {
        //        NSLog(@"json:%@",json);
        NSDictionary *dic=json;
        if ([[dic objectForKey:@"success"] boolValue]==1) {
            NSArray *array=dic[@"GpTupian"];
            NSMutableArray *imageArray= [NSMutableArray array];
            for (NSDictionary *dict in array) {
                GPImageModel *imageModel=[GPImageModel objectWithKeyValues:dict];
                NSLog(@"GPImageModel:%@",imageModel);
                NSString *url=(NSString *)imageModel.picurl;
                [imageArray addObject:url];
            }
            //            for (int i=0; i<=3; i++) {
            //                [_collectionView.photosWallArray addObject:[UIImage imageNamed:@"basicUser.jpg"]];
            //            }
            //            if (imageArray.count<4) {
            //                [_collectionView.photosWallArray replaceObjectsInRange:NSMakeRange(0, imageArray.count) withObjectsFromArray:imageArray];
            //            }
//            if (_isJoin) {
//                [imageArray addObject:_collectionView.addImage];
//            }
            _collectionView.photosWallArray=imageArray;
            
            NSLog(@"imageArray:%@",imageArray);
            [_collectionView reloadData];
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
 *  上传图片到相册service
 */
- (void)uplodeImageToAlbum:(NSString *)imgUrl{
    // http://112.124.12.201:8181/guangpai/home/api/tupian_add?juhui_id=1440&openid=oIYXxjpXKPtbDqnAFhA1-vsn6zkg&pic_url=http://guangpaiwx.oss-cn-qingdao.aliyuncs.com/20150715-066758100d794.jpg
    NSLog(@"%@额外人口我惹我肉味儿苦命人胃口人民网%@",[NSString stringWithFormat:@"%d",self.partyId],self.userId);
    [GPPartyHttpTool postPartyImageWithId:[NSString stringWithFormat:@"%d",self.partyId] openId:self.userId imageUrl:(NSString *)imgUrl success:^(id json) {
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

#pragma mark - publishCilckDelegate
/**
 *  浏览图片
 *
 *  @param index 图片位置
 */
- (void)selectImage:(NSUInteger)index photosWallArray:(NSMutableArray *)photosWallArray{
    __weak typeof(self) weakSelf=self;
    
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:index userID:self.userID photosWallArray:photosWallArray photoBroswerDelegate:self photoModelBlock:^NSMutableArray *{
        NSLog(@"photosWallArray%@ index:%lu",photosWallArray,(unsigned long)index);
        NSMutableArray *photoArray=[photosWallArray  mutableCopy];
        if ([photoArray containsObject:self.collectionView.addImage]) {
            [photoArray removeObject:self.collectionView.addImage];
        }
        //        NSArray *array=@[ @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg",
        //                          @"http://www.netbian.com/d/file/20150505/5a760278eb985d8da2455e3334ad0c0f.jpg",
        //                          @"http://www.netbian.com/d/file/20141006/e9d6f04046d483843d353d7a301d36f8.jpg",
        //                          @"http://www.netbian.com/d/file/20130906/134dca4108f3f0ed10a4cc3f78848856.jpg",
        //                          @"http://www.netbian.com/d/file/20121111/a03b9adb18a982f6a49aa7bfa7b82371.jpg",
        //                          @"http://www.netbian.com/d/file/20130421/e0dabeee4e1e62fe114799bc7e4ccd66.jpg",
        //                          @"http://www.netbian.com/d/file/20121012/c890c1da17bb5b4291e9733fad8efb42.jpg",
        //                          @"http://www.netbian.com/d/file/20150318/c5c68492a4d6998229d1b6068c77951e.jpg0",
        //                          @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg",
        //                            @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg"];
        NSArray *networkImages=photoArray;
        NSLog(@"networkImages%@ index:%lu",networkImages,(unsigned long)index);
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            NSLog(@"networkImages%@ index:%d",networkImages[i],i);
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            //            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            //            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
            //            //源frame
            //            UIImageView *imageV =(UIImageView *) weakSelf.collectionView.subviews[i-1];
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
                
                if ([_collectionView.photosWallArray containsObject:self.collectionView.addImage]) {
                    [_collectionView.photosWallArray removeObject:self.collectionView.addImage];
                }
                [_collectionView.photosWallArray addObject:url];
                
                [_collectionView.photosWallArray addObject:_collectionView.addImage];
                
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
                
                //                [ _collectionView.photosWallArray replaceObjectAtIndex:index withObject:url];
                
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Recieve memory warning");
//    NSLog(@"~~~~~~~~~~~~~~level~~~~~~~~~~~~~~~ %d", (int)OSMemoryNotificationCurrentLevel());
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
