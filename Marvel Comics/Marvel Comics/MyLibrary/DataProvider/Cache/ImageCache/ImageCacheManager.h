//
//  ImageCacheManager.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPImageCache.h"

@interface ImageCacheManager : NSObject

@property (strong, nonatomic, readonly) LPImageCache *imageCache;

+ (instancetype)shared ;


- (NSString *)cacheKeyForURL:(NSURL *)url;

@end
