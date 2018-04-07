//
//  LPImangeDownloader.h
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPWebImageOperation.h"
#import "ImageCacheManager.h"
#import "LPImageDownloadOperation.h"

@class ImageCacheManager;
@class LPImageDownloadOperation;

@interface LPImageDownloader : NSObject

+ (LPImageDownloader *) shared;

@property (assign, nonatomic) NSTimeInterval downloadTimeout;

- (LPImageDownloadOperation *)downloadImageWithURL:(NSURL *)url
                                           options:(LPImageOptions)options
                                    completedBlock:(LPImageDownloaderCompletedBlock)completedBlock
                                       failedBlock:(LPImageDownloaderFailedBlock)failedBlock
                                       cancelBlock:(NoParamsBlock)cancelBlock;

@end
