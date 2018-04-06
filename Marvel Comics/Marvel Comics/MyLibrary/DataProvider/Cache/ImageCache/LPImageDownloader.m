//
//  LPImageDownloader.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPImageDownloader.h"

@interface LPImageDownloader () <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSOperationQueue *downloadQueue;

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation LPImageDownloader

+ (LPImageDownloader *) shared {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
- (id)init {
    if ((self = [super init])) {
        self.downloadQueue = [NSOperationQueue new];
        self.downloadQueue.maxConcurrentOperationCount = 6;
        self.downloadQueue.name = @"com.chaser.imagedownloader";
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = self.downloadTimeout;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
    }
    return self;
}

- (LPImageDownloadOperation *)downloadImageWithURL:(NSURL *)url
                                    completedBlock:(LPImageDownloaderCompletedBlock)completedBlock
                                       failedBlock:(LPImageDownloaderFailedBlock)failedBlock
                                       cancelBlock:(NoParamsBlock)cancelBlock
{
  
//    //__weak __typeof(self)wself = self;
//    NSTimeInterval timeoutInterval = self.downloadTimeout;
//    if (timeoutInterval == 0.0) {
//        timeoutInterval = 15.0;
//    }
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
//                                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                             timeoutInterval:timeoutInterval];
//
//
//    request.HTTPShouldUsePipelining = YES;
//
//    LPImageDownloadOperation *operation = [[LPImageDownloadOperation alloc]
//                                           initWithRequest:request
//                                           ownedSession:self.session
//                                           completedBlock:completedBlock
//                                           failedBlock:failedBlock
//                                           cancelBlock:cancelBlock];
//
//    [self.downloadQueue addOperation:operation];
    [AsyncTaskManager executeAsyncTask:^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            if (completedBlock) {
                UIImage *image = [UIImage imageWithData:data];
                completedBlock(image,data,nil,YES);
            }
        }
        else
        {
            if (failedBlock) {
                NSError *error = [NSError errorWithDomain:@"DownloadImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Failed to download image"}];
                failedBlock(nil, error);
            }
        }
    }];
    
    return nil;
}

@end
