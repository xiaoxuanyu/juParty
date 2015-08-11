//
//  CLSlideViewController.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/14.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLSlideViewController.h"

#import "CLLeftViewController.h"
#import "BaseNavigationController.h"




#define LeftX  (self.view.bounds.size.width / 2)
#define LeftW  self.view.bounds.size.width / 2
#define LeftH  self.view.bounds.size.height





@interface CLSlideViewController ()<CLLeftViewControllerDelegate>

/**
 *  左侧的控制器是否在显示。
 */
@property(nonatomic,assign) BOOL isShow;
/**
 *  起点
 */
@property(nonatomic,assign) CGPoint startPoint;
@property(nonatomic, strong) UISwipeGestureRecognizer *rightPan;
@property(nonatomic,strong) UIPanGestureRecognizer *leftPan;
@property(nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation CLSlideViewController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [self init];
    
    if (self) {
        self.rootViewController = rootViewController;
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.isShow = NO;
       
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@",self.startPoint);
}

-(void)setupRoot
{
    if (self.rootViewController) {
        UIView *view = self.rootViewController.view;
        view.frame = self.view.frame;
        [self.view addSubview:view];
        [self addmenuItem];
    }
}
- (void)addmenuItem
{
    UIViewController *mainViewcontroller = nil;
    if ([self.rootViewController isKindOfClass:[BaseNavigationController class]]) {
        BaseNavigationController *nav =(BaseNavigationController *)self.rootViewController;
        mainViewcontroller = nav.viewControllers.firstObject;
    }
        mainViewcontroller.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigation__icon_meau"] highImage:[UIImage imageNamed:@"navigation__icon_meau_grey"] target:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"出现" style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation__icon_meau"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
//     mainViewcontroller.navigationItem.leftBarButtonItem = barItem;
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (_rootViewController) {
        [_rootViewController.view removeFromSuperview];
        _rootViewController = nil;
    }
    _rootViewController = rootViewController;
    [self setupRoot];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫方向
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;//向右扫
    [self.rootViewController.view addGestureRecognizer:rightSwipeGesture];
    self.rightPan = rightSwipeGesture;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    
//    pan.delegate = (id <UIGestureRecognizerDelegate>)self;
//    [self.rootViewController.view addGestureRecognizer:pan];
//    self.rightPan = pan;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.rootViewController.view addGestureRecognizer:tap];
    self.tap = tap;
    tap.enabled = NO;
    
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
    leftPan.delegate = (id <UIGestureRecognizerDelegate>)self;
    [self.rootViewController.view addGestureRecognizer:leftPan];
    self.leftPan = leftPan;
    self.leftPan.enabled = NO;


}
//轻扫手势触发方法
- (void)swipeGesture:(UISwipeGestureRecognizer *)gesture{
    
    if (gesture.direction==UISwipeGestureRecognizerDirectionLeft) {//向左扫
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"左扫" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {//向右扫
          NSLog(@"UISwipeGestureRecognizerDirectionRight Start");
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x = [UIScreen mainScreen].bounds.size.width / 2;
        rect.origin.y = 0;
        rect.size.height = self.view.bounds.size.height;
        rect.size.width = self.view.bounds.size.width;
        CGRect rect2 = self.leftViewController.view.frame;
        rect2.origin.x = 0;
        rect2.origin.y = 0;
        rect2.size.height = self.view.bounds.size.height;
        rect2.size.width = self.view.bounds.size.width / 2;
        [UIView animateWithDuration:.35 animations:^{
            self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.rootViewController.view.frame = rect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.leftViewController.view.frame = rect2;
            self.leftViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.isShow = !self.isShow;
            self.leftPan.enabled = YES;
            self.tap.enabled = YES;
            [self rootIsSCrolling:NO];
        }];


    }
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return  YES;
//}
-(void)setLeftViewController:(CLLeftViewController *)leftViewController
{
    _leftViewController = leftViewController;
    
    UIView *view = self.leftViewController.view;
    view.frame = self.view.frame;
    leftViewController.delegate = self;
    [self.view addSubview:view];
     [self performSelector:@selector(setupLeft) withObject:nil afterDelay:0.01];
}
- (void)setupLeft
{

    CGRect rect = self.leftViewController.view.frame;
    rect.origin.x = -LeftX;
    rect.origin.y = 0;
    rect.size.height = self.view.bounds.size.height;
    rect.size.width = self.view.bounds.size.width / 2;
    self.leftViewController.view.frame = rect;
    self.leftViewController.view.alpha = 0;
    
}

- (void)rootIsSCrolling:(BOOL)isScroll
{
    UIViewController *mainViewcontroller = nil;
    if ([self.rootViewController isKindOfClass:[BaseNavigationController class]]) {
        BaseNavigationController *nav = (BaseNavigationController *)self.rootViewController;
        mainViewcontroller = nav.viewControllers.firstObject;
        mainViewcontroller.view.userInteractionEnabled = isScroll;
    }
}
- (void)showLeft
{
    NSLog(@"点击左侧");
    if (!self.isShow) {
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x = [UIScreen mainScreen].bounds.size.width / 2;
        rect.origin.y = 0;
        rect.size.height = self.view.bounds.size.height;
        rect.size.width = self.view.bounds.size.width;
        CGRect rect2 = self.leftViewController.view.frame;
        rect2.origin.x = 0;
        rect2.origin.y = 0;
        rect2.size.height = self.view.bounds.size.height;
        rect2.size.width = self.view.bounds.size.width / 2;
        [UIView animateWithDuration:.35 animations:^{
            self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.rootViewController.view.frame = rect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.leftViewController.view.frame = rect2;
            self.leftViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.isShow = !self.isShow;
            self.leftPan.enabled = YES;
            self.tap.enabled = YES;
            [self rootIsSCrolling:NO];
        }];
        
    }
    else
    {
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x = 0;
        rect.origin.y = 0;
        rect.size.height = self.view.bounds.size.height;
        rect.size.width =  self.view.bounds.size.width;
        CGRect rect2 = self.leftViewController.view.frame;
        rect2.origin.x = - LeftX;
        rect2.origin.y = 0;
        rect2.size.height = self.view.bounds.size.height;
        rect2.size.width = self.view.bounds.size.width / 2;
        [UIView animateWithDuration:.35 animations:^{
            self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.rootViewController.view.frame = rect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(1,1);
            self.leftViewController.view.frame = rect2;
            self.leftViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            self.isShow = !self.isShow;
            self.rightPan.enabled = YES;
            self.leftPan.enabled = NO;
            self.tap.enabled = NO;
            [self rootIsSCrolling:YES];
        }];
        
    }
}

-(void)handleTap:(UITapGestureRecognizer *)tap
{
    if (self.isShow) {
        [self showLeft];
    }
}

-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint locationPoint = [pan translationInView:self.view];
    CGFloat offsetX = locationPoint.x - self.startPoint.x;
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        if (locationPoint.x - self.startPoint.x > 0) {
            CGFloat leftOffsetX = offsetX * 60/(LeftW);
//            CGFloat rootZoom = offsetX/(self.view.bounds.size.width - 60) * 0.5;
            CGRect rootRect = self.rootViewController.view.frame;
            rootRect.origin.x = offsetX;
            self.rootViewController.view.frame = rootRect;
//            self.rootViewController.view.transform = CGAffineTransformMakeScale(1-rootZoom, 1-rootZoom);
            CGRect leftRect = self.leftViewController.view.frame;
            leftRect.origin.x = leftOffsetX - 60;
            leftRect.size.width = self.view.bounds.size.width/2 + leftOffsetX *self.view.bounds.size.width/2/60;
            self.leftViewController.view.frame = leftRect;
//            self.leftViewController.view.transform = CGAffineTransformMakeScale(0.5 +rootZoom , 0.5 +rootZoom);
            self.leftViewController.view.alpha = offsetX/(self.view.bounds.size.width - 60) *1.0;

        }
        else
        {
            return;
        
        }
        
        if (offsetX >= (self.view.bounds.size.width - 60)) {
            pan.enabled = YES;
        }
        
        
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled)
    {
        if (offsetX >= [UIScreen mainScreen].bounds.size.width/4) {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = LeftX;
            rect.origin.y = 0;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width = LeftW;

            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = 0;
            rect2.origin.y = 0;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = LeftW;
            [UIView animateWithDuration:0.25 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
                self.isShow = YES;
                self.leftPan.enabled = YES;
                self.tap.enabled = YES;
                [self rootIsSCrolling:NO];
            }];


        }else
        {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width = self.view.bounds.size.width;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = -LeftW;
            rect2.origin.y = 0;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = LeftW;
            [UIView animateWithDuration:0.15 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 0;
            } completion:^(BOOL finished) {
                self.isShow = NO;
                self.tap.enabled = NO;
            }];

        }
    }
}
- (void)handleLeftPan:(UIPanGestureRecognizer *)leftPan
{

    
    CGPoint locationPoint = [leftPan translationInView:self.view];
    CGFloat offsetX = - (locationPoint.x - self.startPoint.x);
    
    if (leftPan.state == UIGestureRecognizerStateChanged) {
//        if (locationPoint.x - self.startPoint.x <= 0) {
//            CGFloat leftOffsetX = offsetX * 60/(self.view.bounds.size.width - 60);
////            CGFloat rootZoom = offsetX/(self.view.bounds.size.width - 60) * 0.5;
//            CGRect rootRect = self.rootViewController.view.frame;
//            rootRect.origin.x = [UIScreen mainScreen].bounds.size.width- 60 - offsetX;
//            self.rootViewController.view.frame = rootRect;
////            self.rootViewController.view.transform = CGAffineTransformMakeScale(0.5+ rootZoom, 0.5 +rootZoom);
//            CGRect leftRect = self.leftViewController.view.frame;
//            leftRect.origin.x = -leftOffsetX;
//            self.leftViewController.view.frame = leftRect;
////            self.leftViewController.view.transform = CGAffineTransformMakeScale(1-rootZoom ,1-rootZoom);
//            self.leftViewController.view.alpha = 1.0 - offsetX/(self.view.bounds.size.width - 60) *1.0;
//        }
//        else
//        {
//            return;
//        }
        if (offsetX >= (LeftW)) {
            leftPan.enabled = NO;
        }
    }
    else if (leftPan.state == UIGestureRecognizerStateCancelled || leftPan.state == UIGestureRecognizerStateEnded)
    {
        if (offsetX >= [UIScreen mainScreen].bounds.size.width/4) {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width =  self.view.bounds.size.width;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = -LeftX;
            rect2.origin.y = 0;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = LeftW;
            [UIView animateWithDuration:.25 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 0;
            } completion:^(BOOL finished) {
                self.isShow = !self.isShow;
                self.rightPan.enabled = YES;
                self.leftPan.enabled = NO;
                self.tap.enabled = NO;
                [self rootIsSCrolling:YES];
            }];
            
            
        }
        else
        {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = LeftW;
            rect.origin.y = 0;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width = self.view.bounds.size.width;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = 0;
            rect2.origin.y = 0;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = LeftW;
            [UIView animateWithDuration:0.25 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
                self.isShow = YES;
                self.leftPan.enabled = YES;
                self.tap.enabled = YES;
                [self rootIsSCrolling:NO];
            }];
            
        }
        
    }

    
    
}

- (void)CLLeftViewControllerDidChange{
    self.isShow = NO;
}


@end
