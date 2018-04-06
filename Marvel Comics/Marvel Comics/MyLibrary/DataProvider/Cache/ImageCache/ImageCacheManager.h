//
//  ImageCacheManager.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPImageCache.h"
#import "LPImageDownloader.h"

typedef void(^LPImageCompletionWithFinishedBlock)(UIImage *image,NSError *error, LPImageCacheType cacheType, BOOL finished, NSURL *imageURL);


@interface ImageCacheManager : NSObject

@property (strong, nonatomic, readonly) LPImageCache *imageCache;
@property (strong, nonatomic, readonly) LPImageDownloader *imageDownloader;

+ (instancetype)shared ;


- (NSString *)cacheKeyForURL:(NSURL *)url;
- (void)downloadImageWithURL:(NSURL *)url
              completedBlock:(LPImageCompletionWithFinishedBlock)completedBlock
                 failedBlock:(LPImageDownloaderFailedBlock)failedBlock
                 cancelBlock:(NoParamsBlock)cancelBlock;

@end
