//
//  ImageCacheManager.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "ImageCacheManager.h"
#import <UIKit/UIKit.h>

@implementation ImageCacheManager
+ (instancetype)shared {
    static ImageCacheManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageCacheManager alloc] init];
      });
    return sharedInstance;
}

- (NSString *)cacheKeyForURL:(NSURL *)url
{
    if (!url) {
        return @"";
    }
    return [url absoluteString];
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
