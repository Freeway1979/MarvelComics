//
//  UIUtils.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (BOOL)is3XDevice
{
    CGFloat scale = [UIScreen mainScreen].scale;
    return scale >= 3.0;
}
+ (BOOL)is2XDevice
{
    CGFloat scale = [UIScreen mainScreen].scale;
    return scale >= 2.0 && scale < 3.0;
}
@end
