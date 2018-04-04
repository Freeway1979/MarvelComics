//
//  LPHTTPSessionManager.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPHTTPSessionManager.h"
#import "RequestConfig.h"
#import "HTTPMethod.h"
#import "LPJSONRequestSerializer.h"
#import "LPJSONResponseSerializer.h"

@interface LPHTTPSessionManager ()
//@property (readwrite, nonatomic, strong) NSURL *baseURL;
@end

@implementation LPHTTPSessionManager

+ (instancetype)shared {
    static LPHTTPSessionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LPHTTPSessionManager alloc] init];
        sharedInstance.requestSerializer = [LPHTTPRequestSerializer serializer];
        sharedInstance.responseSerializer = [LPHTTPResponseSerializer serializer];
    });
    return sharedInstance;
}
+ (instancetype)sharedJSONManager {
    static LPHTTPSessionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LPHTTPSessionManager alloc] init];
        sharedInstance.requestSerializer = [LPHTTPRequestSerializer serializer];
        sharedInstance.responseSerializer = [LPJSONResponseSerializer serializer];
    });
    return sharedInstance;
}

 
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                       config:(RequestConfig *)config
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:HTTPMethod.GET
                                                        URLString:URLString
                                                       parameters:parameters
                                                           config:config
                                                          success:success
                                                          failure:failure];
    [dataTask resume];
    
    return dataTask;
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                       config:(RequestConfig *)config
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:HTTPMethod.POST
                                                        URLString:URLString
                                                       parameters:parameters
                                                           config:config  success:success failure:failure];
    [dataTask resume];
    
    return dataTask;
}
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString * _Nonnull)URLString
                                      parameters:(id)parameters
                                          config:(RequestConfig *)config
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    RequestConfig *cfg = config;
    if (cfg == nil ) {
        cfg = [RequestConfig shared];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:cfg.policy
                                                       timeoutInterval:cfg.timeout];
    
//    NSString *agent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36";
//
//    [request setValue:agent forHTTPHeaderField:@"User-Agent"];
//    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"1" forHTTPHeaderField:@"Upgrade-Insecure-Requests"];
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                NSError *error;
                data = [self.responseSerializer responseObjectForResponse:response data:data error:error];
                success(dataTask, data);
            }
        }
    }];

    return dataTask;
}

@end
