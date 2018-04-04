//
//  RequestConfig.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "RequestConfig.h"

@implementation RequestConfig

+ (instancetype)shared
{
    static RequestConfig *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[RequestConfig alloc] init];
        shared.timeout = 30.0f;
        shared.policy = NSURLRequestUseProtocolCachePolicy;
        shared.gzipEnabled = true;
    });
    return shared;
}

@end
