//
//  LPImageDownloadOperation.h
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPWebImageOperation.h"
#import "LPImageDownloader.h"
#import "LPImageCache.h"

@interface LPImageDownloadOperation : NSOperation <LPWebImageOperation>

@property (nonatomic,copy) LPImageDownloaderCompletedBlock completedBlock;

@property (nonatomic,copy) LPImageDownloaderFailedBlock failedBlock;

@property (strong, nonatomic) NSURLSession *ownedSession;

/**
 * The request used by the operation's task.
 */
@property (strong, nonatomic, readonly) NSURLRequest *request;
/**
 * The operation's task
 */
@property (strong, nonatomic, readonly) NSURLSessionTask *dataTask;

- (instancetype)initWithRequest:(NSURLRequest *)request
                   ownedSession:(NSURLSession *)session
                 completedBlock:(LPImageDownloaderCompletedBlock)completedBlock
                    failedBlock:(LPImageDownloaderCompletedBlock)failedBlock
                    cancelBlock:(NoParamsBlock)cancelBlock;

@end
