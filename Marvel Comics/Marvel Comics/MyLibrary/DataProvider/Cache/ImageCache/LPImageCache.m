//
//  LPImageCache.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPImageCache.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (ImageCache)
/**
 Cost size of image
 
 @return <#return value description#>
 */
- (NSUInteger) cacheCost ;
@end

@implementation UIImage (ImageCache)

/**
 Cost size of image

 @return <#return value description#>
 */
- (NSUInteger)cacheCost {
    NSUInteger cost = self.size.height * self.size.width * self.scale * self.scale;
    return cost;
}
@end

@interface NSData (ImageCache)
- (BOOL) isPNGData;
@end

@implementation NSData (ImageCache)

+ (NSData *)PNGSignatureData
{
    // PNG signature bytes and data (below)
    static unsigned char kPNGSignatureBytes[8] = {0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};
    static NSData *PNGSignatureData = nil;
    if (!PNGSignatureData) {
        PNGSignatureData = [NSData dataWithBytes:kPNGSignatureBytes length:8];
    }
    return PNGSignatureData;
}
- (BOOL) isPNGData
{
    NSData *PNGSignatureData = [NSData PNGSignatureData];
    NSUInteger pngSignatureLength = [PNGSignatureData length];
    if ([self length] >= pngSignatureLength) {
        if ([[self subdataWithRange:NSMakeRange(0, pngSignatureLength)] isEqualToData:PNGSignatureData]) {
            return YES;
        }
    }
    
    return NO;
}

@end


@implementation LPImageCache

+ (instancetype)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init
{
    return [self initWithName:nil cacheSize:0];
}
- (instancetype)initWithName:(NSString *)name
                   cacheSize:(NSUInteger)cacheSize
{
    self = [super init];
    if (self) {
        
        self.ioQueue = dispatch_queue_create("com.chaser.marvel.MarvelImageCache", DISPATCH_QUEUE_SERIAL);
        
        NSString *namespace = [@"com.chaser.marvel." stringByAppendingString:name?name:@"MarvelImageCache"];
        NSCache *cache = [[AutoPurgeCache alloc] init];
        [cache setName:namespace];
        
        if (cacheSize==0) {
            [cache setTotalCostLimit:IMAGE_CACHE_SIZE];
        }
        else
        {
            [cache setTotalCostLimit:cacheSize];
        }
        self.memoryCache = cache;
        dispatch_sync(self.ioQueue, ^{
            self.fileManager = [NSFileManager new];
        });
        NSString *path = [self makeDiskCachePath:namespace];
        self.diskCachePath = path;
        self.shouldCacheImagesInMemory = YES;

        [self registerObservers];
    }
    return self;
}
- (void)dealloc {
    [self unregisterObservers];
}
-(NSString *)makeDiskCachePath:(NSString*)fullNamespace
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}
- (void)registerObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cleanDisk)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
}
- (void)unregisterObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)clearMemory {
    [self.memoryCache removeAllObjects];
}

- (void)cleanDisk {
    [self.fileManager removeItemAtPath:self.diskCachePath error:nil];
    [self.fileManager createDirectoryAtPath:self.diskCachePath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
}


- (void)setCacheSize:(NSUInteger)cacheSize
{
    [self.memoryCache setTotalCostLimit:cacheSize];
}

- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}

- (NSString *)defaultCachePathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:self.diskCachePath];
}

/**
 Cache Key is URL ---> MD5(URL)-->FileName

 @param key URL
 @return MD5(URL)+Extension
 */
- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [key pathExtension]]];
    
    return filename;
}


- (void)storeImage:(UIImage *)image
         imageData:(NSData *)imageData
            forKey:(NSString *)key
            toDisk:(BOOL)toDisk {
    if (!image || !key) {
        return;
    }
    // if memory cache is enabled
    if (self.shouldCacheImagesInMemory) {
        NSUInteger cost = [image cacheCost];
        [self.memoryCache setObject:image forKey:key cost:cost];
    }
    
    if (toDisk) {
        dispatch_async(self.ioQueue, ^{
            NSData *data = imageData;
            
            if (image && !data ) {
                int alphaInfo = CGImageGetAlphaInfo(image.CGImage);
                BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
                                  alphaInfo == kCGImageAlphaNoneSkipFirst ||
                                  alphaInfo == kCGImageAlphaNoneSkipLast);
                BOOL imageIsPng = hasAlpha;
                if ([imageData length] >= [[NSData PNGSignatureData] length]) {
                    imageIsPng = [imageData isPNGData];
                }
                if (imageIsPng) {
                    data = UIImagePNGRepresentation(image);
                }
                else {
                    data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
                }
             }
            
            [self storeImageDataToDisk:data forKey:key];
        });
    }
}
- (void)storeImageDataToDisk:(NSData *)imageData
                      forKey:(NSString *)key {
    
    if (!imageData) {
        return;
    }
    
    if (![self.fileManager fileExistsAtPath:_diskCachePath]) {
        [self.fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    NSString *cachePathForKey = [self defaultCachePathForKey:key];
    [self.fileManager createFileAtPath:cachePathForKey contents:imageData attributes:nil];
}


/**
 Store Image to Disk and Memory Cache

 @param image UIImage
 @param key <#key description#>
 */
- (void)storeImage:(UIImage *)image
            forKey:(NSString *)key {
    [self storeImage:image imageData:nil forKey:key toDisk:YES];
}

- (void)storeImage:(UIImage *)image
            forKey:(NSString *)key
            toDisk:(BOOL)toDisk {
    [self storeImage:image imageData:nil forKey:key toDisk:toDisk];
}

#pragma mark GET
- (BOOL)diskImageExistsWithKey:(NSString *)key {
    BOOL exists = NO;
      exists = [[NSFileManager defaultManager] fileExistsAtPath:[self defaultCachePathForKey:key]];
 
    //Double Check
    if (!exists) {
        exists = [[NSFileManager defaultManager] fileExistsAtPath:[[self defaultCachePathForKey:key] stringByDeletingPathExtension]];
    }
    
    return exists;
}
- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key {
    return [self.memoryCache objectForKey:key];
}

- (UIImage *)imageFromDiskCacheForKey:(NSString *)key {
    
    // First check the in-memory cache
    UIImage *image = [self imageFromMemoryCacheForKey:key];
    if (image) {
        return image;
    }
    
    // Second check the disk cache
    UIImage *diskImage = [self diskImageForKey:key];
    if (diskImage && self.shouldCacheImagesInMemory) {
        NSUInteger cost = [diskImage cacheCost];
        [self.memoryCache setObject:diskImage forKey:key cost:cost];
    }
    
    return diskImage;
}

/**
 Get Image  by key

 @param key <#key description#>
 @return <#return value description#>
 */
- (UIImage *)diskImageForKey:(NSString *)key {
    UIImage *image = nil;
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    
    //Double Check
    if (!data) {
        // No extension
        data = [NSData dataWithContentsOfFile:[defaultPath stringByDeletingPathExtension]];
    }
    if (data) {
        image = [[UIImage alloc] initWithData:data];
        //TODO:FOR MORE IMAGE FORMAT
        return image;
    }
    return nil;
}
@end
