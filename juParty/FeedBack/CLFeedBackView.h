//
//  CLFeedBackView.h
//  聚派
//
//  Created by 伍晨亮 on 15/5/23.
//  Copyright (c) 2015年 伍晨亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPTextView.h"
#import "BaseViewController.h"
@interface CLFeedBackView : UIViewController<GPTextViewDelegate>
@property (strong, nonatomic) IBOutlet GPTextView *textView;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)sendAction:(id)sender;
//@property (nonatomic,retain)GPTextView *textView;
//@property (nonatomic,retain)UIButton *sendButton;
@property (nonatomic,copy) NSString *Content;

@end
