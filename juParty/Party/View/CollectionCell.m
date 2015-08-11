//
//  CollectionCell.m
//  GPCollectionView
//
//  Created by yintao on 15/5/14.
//  Copyright (c) 2015年 guangp. All rights reserved.
//

#import "CollectionCell.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
//#import <MobileCoreServices/MobileCoreServices.h>
//#import <AssetsLibrary/AssetsLibrary.h>
@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
       self.backgroundColor=[UIColor purpleColor];
        self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        //UimageView图片展示时先以展示局部，用户点击后显示整个图片，代码如下
        [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        self.imageView.clipsToBounds = YES;
        self.imageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        [self addSubview:self.imageView];
        
//        self.text=[[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.frame)-10, 20)];
//        self.text.backgroundColor=[UIColor brownColor];
//        self.text.textAlignment=NSTextAlignmentCenter;
//        [self addSubview:self.text];
//        
//        self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        self.btn.frame=CGRectMake(5, CGRectGetMaxY(self.text.frame), CGRectGetWidth(self.frame)-10, 30);
//        [self.btn setTitle:@"按钮" forState:UIControlStateNormal];
//        [self.btn setBackgroundColor:[UIColor orangeColor]];
//        [self addSubview:self.btn];
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
            //im = [self getSubImage:im mCGRect:self.bounds centerBool:NO];
            //im=[self imageCompressForWidth:im targetWidth:self.width];
           im = [Utils thumbnailWithImage:im size:self.bounds.size];
            [_imageView setImage:im];
        }else{
            [_imageView setImage:[UIImage imageNamed:nil]];
            NSURL *url = [NSURL URLWithString:[userPhoto stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
             
            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image) {
            
                    [[SDImageCache sharedImageCache] storeImage:image forKey:userPhoto toDisk:YES];
//                  UIImage *targetImage = [self getSubImage:image mCGRect:self.bounds centerBool:NO];
                      //    UIImage *targetImage = [self imageCompressForWidth:im targetWidth:self.width];
              
                    UIImage *targetImage = [Utils thumbnailWithImage:image size:self.bounds.size];
                    [_imageView setImage:targetImage];
                }
            }];
        }
        
    }else if ([userPhoto isKindOfClass:[UIImage class]]){
        if (userPhoto != self.addPhotosImage) {
            UIImage *targetImage = userPhoto;
            NSLog(@"targetImage:%@",targetImage);
            [_imageView setImage:targetImage];
        }else{
            
            [_imageView setImage:self.addPhotosImage];
        }
    }
}

#pragma mark - 截取图片部分
-(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool
{
    
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, smallBounds, subImageRef);
    [image drawInRect:smallBounds];
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
}
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//- (void)layoutSubviews{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageModel.picurl] placeholderImage:[UIImage imageNamed:@"basicUser.jpg"]];
//}
@end
