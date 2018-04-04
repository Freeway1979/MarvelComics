//
//  LPHTTPRequestSerializer.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHTTPRequestSerializer:NSObject

+(instancetype _Nonnull ) serializer;

- (NSMutableURLRequest *_Nonnull)requestWithMethod:(NSString *_Nonnull)method
                                         URLString:(NSString *_Nonnull)URLString
                                parameters:(nullable id)parameters
                                             error:(NSError * _Nullable)error;
 


@end
