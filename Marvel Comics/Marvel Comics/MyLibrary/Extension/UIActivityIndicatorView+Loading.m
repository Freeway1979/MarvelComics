//
//  UIActivityIndicatorView+Loading.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "UIActivityIndicatorView+Loading.h"

@implementation UIActivityIndicatorView (Loading)

static UIActivityIndicatorView *activityIndicatorView;

+ (void)show:(UIView *)superView
{
    [self show:superView timeout:0];
}

+ (void)show:(UIView *)superView
     timeout:(NSTimeInterval)timeout
{
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame:CGRectMake(0,0,140,140)];
    activityIndicatorView.center = superView.center;
    activityIndicatorView.hidesWhenStopped = YES;
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    //[activityIndicatorView setBackgroundColor:[UIColor lightGrayColor]];
    [superView addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    if (timeout>0) {
        [AsyncTaskManager executeAsyncTaskOnMainThread:^{
            [UIActivityIndicatorView dismiss];
        } withDelay:timeout];
    }
    
}
+ (void)dismiss
{
    [activityIndicatorView stopAnimating];
}
@end
