//
//  LPHTTPResponseSerializer.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPHTTPResponseSerializer.h"

@implementation LPHTTPResponseSerializer

+ (instancetype) serializer {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.stringEncoding = NSUTF8StringEncoding;
    
    self.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
    self.acceptableContentTypes = nil;
    
    return self;
}
- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError **)error
{
    return TRUE;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *)error
{
    [self validateResponse:(NSHTTPURLResponse *)response data:data error:&error];
    
    return data;
}

@end
