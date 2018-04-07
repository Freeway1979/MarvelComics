//
//  NetProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NetProvider.h"
#import "LPHTTPSessionManager.h"
#import "NSString+URLEncode.h"
#import "NSDictionary+URLEncodedString.h"

@implementation NetProvider

+(void)getRequestWithURLString:URLString
                    parameters:(NSDictionary *)params
                        config:(RequestConfig *)config
                       success:(void (^)(id responseDic))success
                       failure:(void (^)(NSError *error))failure
{
    NSMutableString *finalUrlString = [NSMutableString stringWithString:URLString];
    NSString *queryString = [params urlQueryString:YES];
    if (queryString) {
        [finalUrlString appendString:queryString];
    }
    NSString *finalUrl = finalUrlString;
    NSLog(@"finalUrl %@",finalUrl);
    LPHTTPSessionManager *sessionManager = [LPHTTPSessionManager sharedJSONManager];
    [sessionManager GET:finalUrl
             parameters:nil
                 config:config
                success:^(NSURLSessionDataTask * _Nonnull dataTask, id _Nullable response) {
        if (success) {
            success(response);
        }
    }
                failure:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postRequestWithURLString:URLString
                     parameters:(NSDictionary *)params
                         config:(RequestConfig *)config
                        success:(void (^)(id responseDic))success
                        failure:(void (^)(NSError *error))failure
{
    NSMutableString *finalUrlString = [NSMutableString stringWithString:URLString];
    NSString *queryString = [params urlQueryString:YES];
    if (queryString) {
        [finalUrlString appendString:queryString];
    }
    NSString *finalUrl = finalUrlString;
    NSLog(@"finalUrl %@",finalUrl);
    
    LPHTTPSessionManager *sessionManager = [LPHTTPSessionManager sharedJSONManager];
    [sessionManager POST:finalUrl
              parameters:nil
                  config:config
                 success:^(NSURLSessionDataTask * _Nonnull dataTask, id _Nullable response) {
        if (success) {
            success(response);
        }
    }
                 failure:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
