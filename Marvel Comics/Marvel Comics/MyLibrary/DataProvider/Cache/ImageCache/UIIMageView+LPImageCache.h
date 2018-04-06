//
//  UIImageView+LPImageCache.h
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageCacheManager.h"
#import "LPImageDownloader.h"

@interface UIImageView (LPImageCache)

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                options:(NSInteger)options;

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                options:(NSInteger)options
                 failed:(LPImageDownloaderFailedBlock)failedBlock
              completed:(LPImageDownloaderCompletedBlock)completedBlock;
@end
