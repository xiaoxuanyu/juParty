//
//  JXBAdPageView.m
//  XBAdPageView
//
//  Created by Peter Jin mail:i@Jxb.name on 15/5/13.
//  Github ---- https://github.com/JxbSir
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "JXBAdPageView.h"

@interface JXBAdPageView()<UIScrollViewDelegate>
@property (nonatomic,assign)int                 indexShow;
@property (nonatomic,copy)NSArray               *arrImage;
@property (nonatomic,strong)UIScrollView        *scView;
@property (nonatomic,strong)UIImageView         *imgPrev;
@property (nonatomic,strong)UIImageView         *imgCurrent;
@property (nonatomic,strong)UIImageView         *imgNext;
@property (nonatomic,assign)JXBAdPageCallback   myBlock;
@property (nonatomic,strong)NSTimer             *timer;
@end

@implementation JXBAdPageView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(indexadd) userInfo:nil repeats:YES];
        self.timer = timer;
        //消息循环
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self initUI];
}

- (void)initUI {
    _scView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    
    _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds:)];
    [_scView addGestureRecognizer:tap];
    
    
    _imgPrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgNext = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    
    [_scView addSubview:_imgPrev];
    [_scView addSubview:_imgCurrent];
    [_scView addSubview:_imgNext];
    
     _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20 , self.frame.size.width, 20)];
    _pageControl.numberOfPages=5;
    _pageControl.backgroundColor=[UIColor clearColor];
    _scView.backgroundColor=[UIColor clearColor];
    self.backgroundColor=[UIColor clearColor];
//     _pageControl.center = CGPointMake(self.frame.size.width -50, self.frame.size.height-10);
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
//    UIPageControl *control = [[UIPageControl alloc]init];
//    control.numberOfPages = 4;
//    control.pageIndicatorTintColor = [UIColor whiteColor];
//    control.currentPageIndicatorTintColor = [UIColor redColor];
//    control.center = CGPointMake(self.view.width * 0.5, self.view.height+10);
//    _control = control;
//    [self.view addSubview:control];
}

/**
 *  启动函数
 *
 *  @param imageArray 图片数组
 *  @param block      click回调
 */
- (void)startAdsWithBlock:(NSArray*)imageArray block:(JXBAdPageCallback)block {
    if(imageArray.count <= 1)
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _pageControl.numberOfPages = imageArray.count;
    _arrImage = imageArray;
    _myBlock = block;
    [self reloadImages];
}


/**
 *  点击广告
 */
- (void)tapAds:(UITapGestureRecognizer *)tapGesture
{
    if (_myBlock != NULL) {
        _myBlock(_indexShow);
    }
}
//- (void)addTimerO
//{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(indexadd) userInfo:nil repeats:YES];
//    self.timer = timer;
//    //消息循环
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
//}
-(void)indexadd
{
    _indexShow ++;

    [self reloadImages];
}

/**
 *  加载图片顺序
 */
- (void)reloadImages {
    if (_indexShow >= (int)_arrImage.count)
        _indexShow = 0;
    if (_indexShow < 0)
        _indexShow = (int)_arrImage.count - 1;
    int prev = _indexShow - 1;
    if (prev < 0)
        prev = (int)_arrImage.count - 1;
    int next = _indexShow + 1;
    if (next > _arrImage.count - 1)
        next = 0;
    _pageControl.currentPage = _indexShow;
    NSString* prevImage = [_arrImage objectAtIndex:prev];
    NSString* curImage = [_arrImage objectAtIndex:_indexShow];
    NSString* nextImage = [_arrImage objectAtIndex:next];
    if(_bWebImage)
    {
        if(delegate && [delegate respondsToSelector:@selector(setWebImage:imgUrl:)])
        {
            [delegate setWebImage:_imgPrev imgUrl:prevImage];
            [delegate setWebImage:_imgCurrent imgUrl:curImage];
            [delegate setWebImage:_imgNext imgUrl:nextImage];
        }
        else
        {
            _imgPrev.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:prevImage]]];
            _imgCurrent.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curImage]]];
            _imgNext.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextImage]]];
        }
    }
    else
    {
        _imgPrev.image = [UIImage imageNamed:prevImage];
        _imgCurrent.image = [UIImage imageNamed:curImage];
        _imgNext.image = [UIImage imageNamed:nextImage];
    }
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
}

/**
 *  切换图片完毕事件
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{

    if (scrollView.contentOffset.x >=self.frame.size.width* 2 )
        _indexShow++;
    else if (scrollView.contentOffset.x < self.frame.size.width)
        _indexShow--;

    [self reloadImages];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(indexadd) userInfo:nil repeats:YES];
    self.timer = timer;
    //消息循环
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
}

@end
