//
//  CollectionHeaderView.m
//  GPCollectionView
//
//  Created by yintao on 15/5/15.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "UIImageView+WebCache.h"
@implementation CollectionHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
//        /*
//         ***容器，装载
//         */
//        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-20, CGRectGetWidth(self.frame), 20)];
//        containerView.backgroundColor = [UIColor clearColor];
//        [self addSubview:containerView];
//        UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame))];
//        alphaView.backgroundColor = [UIColor orangeColor];
//        alphaView.alpha = 0.7;
//        [containerView addSubview:alphaView];


        CGFloat labelHeight=25;
        CGFloat labelTop=2;
        ///------聚会主题照片------
         _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [_imageView setImage:[UIImage imageNamed:@"image_photo1.png"]];
      
        ///----文字描述label-------
        CGFloat textLabY=CGRectGetMaxY(_imageView.frame);
        UIView *labelView=[[UIView alloc] initWithFrame:CGRectMake(0, textLabY-labelHeight, fDeviceWidth, labelHeight)];
        [labelView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 2, fDeviceWidth, labelHeight-4)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.text=@"聚会主题照片";
//        [self addSubview:_titleLabel];
            [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        [self addSubview:_imageView];
        [_imageView addSubview:labelView];
        [labelView addSubview:_titleLabel];
        
    }
    return self;
}
-(void)setUserPhoto:(id)userPhoto{
    _userPhoto = userPhoto;
    if ([userPhoto isKindOfClass:[NSString class]]) {
        //        SDImageCache *imageCache = [SDImageCache sharedImageCache];
        //        if ([imageCache diskImageExistsWithKey:userPhoto]) {
        //            [_imageView setImage:[imageCache imageFromDiskCacheForKey:userPhoto]];
        //        } else {
        //            [_imageView sd_setImageWithURL:[NSURL URLWithString:userPhoto] placeholderImage:[UIImage imageNamed:@"image_photo2.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
        //            }];
          [_imageView setImage:[UIImage imageNamed:@"image_photo2.png"]];
        
        UIImage *im = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:userPhoto];
        if (!im) {
            im = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:userPhoto];
            
        }
        if (im) {
            //            im = [self getSubImage:im mCGRect:self.bounds centerBool:NO];
            im= [Utils thumbnailWithImage:im size:self.bounds.size];
            [_imageView setImage:im];
        }else{
            [_imageView setImage:[UIImage imageNamed:nil]];
            NSURL *url = [NSURL URLWithString:[userPhoto stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image) {
                    
                    [[SDImageCache sharedImageCache] storeImage:image forKey:userPhoto toDisk:YES];
                    //                    UIImage *targetImage = [self getSubImage:image mCGRect:self.bounds centerBool:NO];
                    UIImage *targetImage = [Utils thumbnailWithImage:image size:self.bounds.size];
                    [_imageView setImage:targetImage];
                }
            }];
        }
        
    }
//    else if ([userPhoto isKindOfClass:[UIImage class]]){
//        if (userPhoto != self.addPhotosImage) {
//            UIImage *targetImage = userPhoto;
//            NSLog(@"targetImage:%@",targetImage);
//            [_imageView setImage:targetImage];
//        }else{
//            
//            [_imageView setImage:self.addPhotosImage];
//        }
//    }
}
//-(void)layoutSubviews{
//    [self.image sd_setImageWithURL:[NSURL URLWithString:_imageModel.picurl] placeholderImage:[UIImage imageNamed:@"image_photo1.png"]];
//}
//- (void)layoutSubviews{
//[self.image sd_setImageWithURL:[NSURL URLWithString:_imageModel.picurl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
//}
@end
