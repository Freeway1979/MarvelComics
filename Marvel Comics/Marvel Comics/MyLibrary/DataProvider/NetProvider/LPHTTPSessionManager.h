//
//  LPHTTPSessionManager.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestConfig.h"
#import "LPHTTPRequestSerializer.h"
#import "LPHTTPResponseSerializer.h"

@interface LPHTTPSessionManager : NSObject

@property (nonatomic,strong) LPHTTPRequestSerializer * _Nonnull requestSerializer;
@property (nonatomic,strong) LPHTTPResponseSerializer * _Nonnull responseSerializer;

+ (instancetype _Nonnull )shared;
+ (instancetype _Nonnull )sharedJSONManager;

- (NSURLSessionDataTask *_Nonnull)GET:(NSString *_Nonnull)URLString
                           parameters:(id _Nullable )parameters
                               config:(RequestConfig *_Nullable)config
                              success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                              failure:(void (^_Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

- (NSURLSessionDataTask *_Nonnull)POST:(NSString *_Nonnull)URLString
                    parameters:(id _Nullable )parameters
                        config:(RequestConfig *_Nullable)config
                       success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^_Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;
 
@end
