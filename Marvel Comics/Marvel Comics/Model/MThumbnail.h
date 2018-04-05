//
//  MThumbnail.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON2Model.h"
@interface MThumbnail : NSObject <JSON2Model>

@property (nonatomic,copy) NSString *path;

@property (nonatomic,copy) NSString *extension;

/**
 Original Image with size of 850x850
 */
@property (nonatomic,copy,readonly) NSString *fullUrl;
/**
 Small Image of Thumbnail with size of 200*200,140x140,100x100
 */
@property (nonatomic,copy,readonly) NSString *fullThumbnailUrl;

@end
