//
//  CLFeedBackView.m
//  聚派
//
//  Created by 伍晨亮 on 15/5/23.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import "CLFeedBackView.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"
@interface CLFeedBackView ()

@end

@implementation CLFeedBackView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"意见反馈";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //这个问题我已经解决了，其实是因为iOS7里导航栏，状态栏等有个边缘延伸的效果在。把边缘延伸关掉就好了。代码如下
    //取消iOS7的边缘延伸效果（例如导航栏，状态栏等等）
    if (IOS_VERSION >= 7.0) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
    }
//    self.modalPresentationCapturesStatusBarAppearance = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    //--------textView-------
   self.textView.layer.borderColor = [UIColor blackColor].CGColor;
//    self.textView.layer.borderWidth=1;
    self.textView.GPDelegate=self;
    _textView.layer.cornerRadius=3;
    _textView.placeholder = @"请留下您的建议....";
    [_textView setReturnKeyType:UIReturnKeyDone];
   [_textView setBackgroundColor:[UIColor clearColor]];
    ///---内容输入框，textView----
//    _detailTextView=[[GPTextView alloc] initWithFrame:CGRectMake(20, 80,fDeviceWidth-40, 100)];
//    _detailTextView.GPDelegate=self;
//    _detailTextView.layer.cornerRadius=3;
//    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
//    _detailTextView.placeholder = @"请留下您的建议....";
//    [_detailTextView setReturnKeyType:UIReturnKeyDone];
//    [_detailTextView setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:_detailTextView];
//    self.Content = self.textView.text;
    //----发送按钮----
    [_sendButton.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    //    [exitButton.layer setBorderWidth:1.0]; //边框宽度
    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    //    [exitButton.layer setBorderColor:colorref];//边框颜色
    [_sendButton setBackgroundColor:[Utils colorWithHexString:@"#f2cc1a"]];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    _sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//title color
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - actions
//- (IBAction)Send:(UIButton *)sender
//{
//    NSString *FeedbackText = self.textView.text;
//    NSString * encodingString = [FeedbackText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.20.137:8089/SSM/Front/gp_suggest_add?userId=123&suggestContent=%@",encodingString];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@",dict);
//
//    
//    if (dict[@"success"]) {
//        
//        [MBProgressHUD showSuccess:@"谢谢您的反馈"];
//        return;
//    }else
//    {
//        [MBProgressHUD showError:@"网络错误！"];
//         return;
//    }
//    
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendAction:(id)sender {
    ///请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    CLAccount *account=[CLAccountTool account];
    NSString *userId=account.unionid;
    NSLog(@"%@",userId);
  params[@"userId"]=userId;
    params[@"suggestContent"]=self.textView.text;
//    [[HttpTool postWithURL:Url_suggest params:params success:^(id responseObject) {
//        NSLog(@"responseObject:%@",responseObject);
//        NSDictionary *dic=responseObject;
//        if (dic[@"success"]) {
//            
//            [MBProgressHUD showSuccess:@"谢谢您的反馈"];
//        }else
//        {
//            [MBProgressHUD showError:@"网络错误！"];
//            return;
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"网络错误！"];
//    }]];
    [HttpTool postWithURL:Url_suggest params:params success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NSDictionary *dic=responseObject;
        if (dic[@"success"]) {
            
            [MBProgressHUD showSuccess:@"谢谢您的反馈"];
        }else
        {
            [MBProgressHUD showError:@"网络错误！"];
           
        }
    } failure:^(NSError *error) {
                [MBProgressHUD showError:@"网络错误！"];
    }];
}
#pragma mark - GPtextView delegate
-(void)textViewKeybordShow:(CGRect)endKeybordRect withAnimationDuration:(CGFloat)animationDuration{
    //    CGFloat Y = CGRectGetMaxY(_detailTextView.frame);
    //    NSLog(@"Y:%f",Y);
    //    NSLog(@"endKeybordRectTextView:%f",CGRectGetMinY(endKeybordRect));
    //    if (Y >CGRectGetMinY(endKeybordRect)) {
    //        [UIView animateWithDuration:animationDuration animations:^{
    //            self.transform = CGAffineTransformMakeTranslation(0, -(Y - CGRectGetMinY(endKeybordRect)));
    //        }];
    //    }
    CGFloat Y = CGRectGetMaxY(self.textView.frame);
    NSLog(@"Y:%f",Y+64);
    NSLog(@"endKeybordRectTextView:%f",endKeybordRect.origin.y);
    if (Y+64 > CGRectGetMinY(endKeybordRect)) {
        __weak typeof(self) weakSelf = self;
        [UIView animateKeyframesWithDuration:animationDuration delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            weakSelf.view.transform = CGAffineTransformMakeTranslation(0, -(Y +64- endKeybordRect.origin.y));
        } completion:nil];
    }
}
-(void)textViewKeybordHidden{
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
}
@end
