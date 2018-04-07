//
//  LPImageCache.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AutoPurgeCache.h"

typedef NS_OPTIONS(NSUInteger, LPImageOptions) {
    LPImageOptionsLowPriority = 1 << 0,
    LPImageOptionsBackgroundPriority = 1 << 1,
    LPImageOptionsDefaultPriority = 1 << 2
};

typedef NS_ENUM(NSInteger, LPImageCacheType) {
    /**
     * NOT TO BE CACHED
     */
    LPImageCacheTypeNone,
    /**
     * DISK CACHE
     */
    LPImageCacheTypeDisk,
    /**
     * Memory CACHE
     */
    LPImageCacheTypeMemory
};

typedef void(^LPImageQueryCompletedBlock)(UIImage *image, LPImageCacheType cacheType);

typedef void(^LPImageCheckCacheCompletionBlock)(BOOL isInCache);

typedef void (^LPImageDownloaderFailedBlock)(NSURLSessionTask *, NSError *);

typedef void(^LPImageDownloaderCompletedBlock)(UIImage *image, NSData *data, NSError *error, BOOL finished);


#define IMAGE_CACHE_SIZE (50*1024*1024)

@interface LPImageCache : NSObject
@property (nonatomic,strong) NSFileManager *fileManager;
@property (nonatomic,strong) NSCache *memoryCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (strong, nonatomic) dispatch_queue_t ioQueue;
@property (strong, nonatomic) NSMutableArray<NSString *> *customPaths;
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

+ (instancetype)sharedImageCache ;

- (instancetype)initWithName:(NSString *)name
                   cacheSize:(NSUInteger)cacheSize;

- (void)setCacheSize:(NSUInteger)cacheSize;

- (NSString *)cachePathForKey:(NSString *)key
                       inPath:(NSString *)path;

- (NSString *)defaultCachePathForKey:(NSString *)key;

- (NSString *)cachedFileNameForKey:(NSString *)key;

- (NSOperation *)queryDiskCacheForKey:(NSString *)key
                       completedBlock:(LPImageQueryCompletedBlock)completedBlock;

- (void)storeImage:(UIImage *)image
         imageData:(NSData *)imageData
            forKey:(NSString *)key
            toDisk:(BOOL)toDisk ;

- (void)storeImageDataToDisk:(NSData *)imageData
                      forKey:(NSString *)key ;

/**
 Store Image to Disk and Memory Cache
 
 @param image UIImage
 @param key <#key description#>
 */
- (void)storeImage:(UIImage *)image
            forKey:(NSString *)key ;

- (void)storeImage:(UIImage *)image
            forKey:(NSString *)key
            toDisk:(BOOL)toDisk;

#pragma mark GET
- (BOOL)diskImageExistsWithKey:(NSString *)key ;

- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key ;

- (UIImage *)imageFromDiskCacheForKey:(NSString *)key ;

/**
 Get Image  by key
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (UIImage *)diskImageForKey:(NSString *)key ;
@end
