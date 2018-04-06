//
//  LPImangeDownloader.h
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPWebImageOperation.h"
#import "LPImageDownloadOperation.h"

typedef void(^LPImageDownloaderCompletedBlock)(UIImage *image, NSData *data, NSError *error, BOOL finished);

typedef void (^LPImageDownloaderFailedBlock)(NSURLSessionTask *, NSError *);

@class LPImageDownloadOperation;

@interface LPImageDownloader : NSObject

+ (LPImageDownloader *) shared;

@property (assign, nonatomic) NSTimeInterval downloadTimeout;

- (LPImageDownloadOperation *)downloadImageWithURL:(NSURL *)url
                                    completedBlock:(LPImageDownloaderCompletedBlock)completedBlock
                                       failedBlock:(LPImageDownloaderFailedBlock)failedBlock
                                       cancelBlock:(NoParamsBlock)cancelBlock;

@end
