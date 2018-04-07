//
//  UIImageView+LPImageCache.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "UIIMageView+LPImageCache.h"
//#import "objc/runtime.h"
#import "UIImage+Processing.h"

//static char imageURLKey;

@implementation UIImageView (LPImageCache)
- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                options:(NSInteger)options
{
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                   failed:nil
                completed:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                options:(NSInteger)options
                 failed:(LPImageDownloaderFailedBlock)failedBlock
              completed:(LPImageDownloaderCompletedBlock)completedBlock
{
    //objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    WS(ws);
    if (placeholder) {
        [AsyncTaskManager executeAsyncTaskOnMainThread:^{
             ws.image = placeholder;
        }];
    }
    
    if (url) {
        CGRect imageSize = self.frame;
        ImageCacheManager *cacheManager = [ImageCacheManager shared];
        [cacheManager downloadImageWithURL:url
                            completedBlock:^(UIImage *image, NSError *error, LPImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                UIImage *subImage = [UIImage getSubImage:image
                                                                 mCGRect:imageSize
                                                              centerBool:NO];
                                if (subImage) {
                                    [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                                        [ws setImage:subImage];
                                    }];
                                }
                                if (completedBlock) {
                                    completedBlock(image,nil, error,YES);
                                }
        }
                               failedBlock:failedBlock
                               cancelBlock:^{
            
        }];
  
    } else {
        [AsyncTaskManager executeAsyncTaskOnMainThread:^{
            //[self removeActivityIndicator];
            if (failedBlock) {
                NSError *error = [NSError errorWithDomain:@"WebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
                failedBlock(nil, error);
            }
        }];
    }
}


@end
