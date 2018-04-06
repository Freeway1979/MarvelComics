//
//  LPImageDownloadOperation.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPImageDownloadOperation.h"
@interface LPImageDownloadOperation ()
/**
 * The request used by the operation's task.
 */
@property (strong, nonatomic) NSURLRequest *request;
/**
 * The operation's task
 */
@property (strong, nonatomic) NSURLSessionTask *dataTask;

@property (copy, nonatomic) NoParamsBlock cancelBlock;

@end

@implementation LPImageDownloadOperation

- (instancetype)initWithRequest:(NSURLRequest *)request
                   ownedSession:(NSURLSession *)session
                 completedBlock:(LPImageDownloaderCompletedBlock)completedBlock
                    failedBlock:(LPImageDownloaderCompletedBlock)failedBlock
                    cancelBlock:(NoParamsBlock)cancelBlock
{
    if (self=[super init]) {
        self.request = [request copy];
        self.ownedSession = session;
        self.completedBlock = [completedBlock copy];
        self.failedBlock = [failedBlock copy];
        self.cancelBlock = [cancelBlock copy];
    }
    return self;
}
- (void)start {
    @synchronized (self) {
        if (self.isCancelled) {
            [self reset];
            return;
        }
        
        NSURLSession *session = self.ownedSession;
        if (!session) {
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.timeoutIntervalForRequest = 15;
            session = [NSURLSession sessionWithConfiguration:sessionConfig];
        }
        WS(ws);
        self.dataTask = [session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            LPImageDownloadOperation *strongSelf = ws;
            if (error) {
                if (strongSelf.failedBlock) {
                    strongSelf.failedBlock(strongSelf.dataTask, error);
                }
            } else {
                if (strongSelf.completedBlock) {
                    UIImage *image = [UIImage imageWithData:data];
                    strongSelf.completedBlock(image, data, error, YES);
                }
            }
        }];
        
    }
    [self.dataTask resume];
    
}
- (void)reset {
    self.cancelBlock = nil;
    self.completedBlock = nil;
    self.failedBlock = nil;
    self.dataTask = nil;
    if (self.ownedSession) {
        [self.ownedSession invalidateAndCancel];
        self.ownedSession = nil;
    }
}

- (void)cancel
{
    [super cancel];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    if (self.dataTask) {
        [self.dataTask cancel];
    }
    [self reset];
}
@end
