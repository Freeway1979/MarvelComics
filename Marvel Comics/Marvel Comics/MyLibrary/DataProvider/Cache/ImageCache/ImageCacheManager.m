//
//  ImageCacheManager.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "ImageCacheManager.h"
#import <UIKit/UIKit.h>
@interface ImageCacheManager ()

@property (strong, nonatomic) LPImageCache *imageCache;
@property (strong, nonatomic) LPImageDownloader *imageDownloader;

@end

@implementation ImageCacheManager
+ (instancetype)shared {
    static ImageCacheManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageCacheManager alloc] init];
        
    });
    return sharedInstance;
}
- (instancetype)init {
    LPImageCache *cache = [LPImageCache sharedImageCache];
    LPImageDownloader *downloader = [LPImageDownloader shared];
    return [self initWithCache:cache downloader:downloader];
}
- (instancetype)initWithCache:(LPImageCache *)cache
                   downloader:(LPImageDownloader *)downloader
{
    if ((self = [super init])) {
        _imageCache = cache;
        _imageDownloader = downloader;
    }
    return self;
}

- (NSString *)cacheKeyForURL:(NSURL *)url
{
    if (!url) {
        return @"";
    }
    return [url absoluteString];
}

/**
 background download ,no need call back

 @param url <#url description#>
 */
- (void)backgroundDownloadImageWithURL:(NSURL *)url
{
    [self downloadImageWithURL:url
                       options:LPImageOptionsBackgroundPriority
                completedBlock:nil
                   failedBlock:nil
                   cancelBlock:nil];
}
- (void)downloadImageWithURL:(NSURL *)url
                     options:(LPImageOptions)options
              completedBlock:(LPImageCompletionWithFinishedBlock)completedBlock
                 failedBlock:(LPImageDownloaderFailedBlock)failedBlock
                 cancelBlock:(NoParamsBlock)cancelBlock
{
//    if (!completedBlock) {
//        return;
//    }
    __block NSString *key = [self cacheKeyForURL:url];
    WS(ws);
    //Check memory cache
    [self.imageCache queryDiskCacheForKey:key completedBlock:^(UIImage *image, LPImageCacheType cacheType) {
        if (image) {
            if (completedBlock) {
                completedBlock(image,nil, LPImageCacheTypeMemory,YES, url);
            }
            return;
        }
        
        //Download from web
        [self.imageDownloader downloadImageWithURL:url
                                           options:options
                                    completedBlock:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            __strong typeof(self) strongSelf = ws;
            [strongSelf.imageCache storeImage:image
                                    imageData:data
                                       forKey:key
                                       toDisk:YES];
            if (completedBlock) {
                completedBlock(image,error,LPImageCacheTypeMemory,YES, url);
            }
        } failedBlock:^(NSURLSessionTask *task, NSError *error) {
            if (failedBlock) {
                 failedBlock(task,error);
            }
        } cancelBlock:^{
            
        }];
        
        
    }];
}

- (void)saveImageToCache:(UIImage *)image forURL:(NSURL *)url {
    if (image && url) {
        NSString *key = [self cacheKeyForURL:url];
        [self.imageCache
         storeImage:image
         forKey:key
         toDisk:YES];
    }
}



@end
