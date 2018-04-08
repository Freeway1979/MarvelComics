//
//  NSFileManager+LPExtension.m
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSFileManager+LPExtension.h"

@implementation NSFileManager (LPExtension)
#pragma mark path
-(NSString *)pathForLibraryDirectory
{
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}
-(NSString *)pathForDocumentDirectory
{
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}
-(NSString *)getDocumentDirectoryFileFullPathWithFileName:(NSString *)fileName
{
    NSString *filePath = [[self pathForDocumentDirectory] stringByAppendingPathComponent:fileName];
 
    return filePath;
}
@end
