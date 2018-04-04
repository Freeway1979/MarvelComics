//
//  LPJSONRequestSerializer.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPJSONRequestSerializer.h"

@implementation LPJSONRequestSerializer

+ (instancetype) shared
{
    static LPJSONRequestSerializer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LPJSONRequestSerializer alloc] init];
        sharedInstance.writingOptions = (NSJSONWritingOptions)0;
    });
    return sharedInstance;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(nullable id)parameters
                                     error:(NSError * _Nullable)error
{
   
    NSMutableURLRequest *mutableRequest = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];
    if (parameters) {
        if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
            [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:self.writingOptions
                                                         error:&error];
        [mutableRequest setHTTPBody:data];
    }
    
    return mutableRequest;
}


@end
