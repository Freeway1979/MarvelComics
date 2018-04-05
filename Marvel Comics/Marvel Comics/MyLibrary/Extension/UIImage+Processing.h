//
//  UIImage+Processing.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Processing)
/**
 generate sub image
 
 @param image source image
 @param mCGRect size of sub image
 @param centerBool YES to get mCGRect size from center point.NO to compress to mCGRect Size
 @return sub image
 */
+(UIImage*)getSubImage:(UIImage *)image
               mCGRect:(CGRect)mCGRect
            centerBool:(BOOL)centerBool;

@end
