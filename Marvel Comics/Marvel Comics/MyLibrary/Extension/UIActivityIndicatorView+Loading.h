//
//  UIActivityIndicatorView+Loading.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIActivityIndicatorView (Loading)
+ (void)show:(UIView *)superView;
+ (void)show:(UIView *)superView
     timeout:(NSTimeInterval)timeout;
+ (void)dismiss;
@end
