//
//  LPJSONResponseSerializer.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPHTTPResponseSerializer.h"

@interface LPJSONResponseSerializer : LPHTTPResponseSerializer
+ (instancetype _Nonnull )serializer ;

- (id _Nonnull )responseObjectForResponse:(NSURLResponse *_Nullable)response
                                     data:(NSData *_Nullable)data
                                    error:(NSError *_Nullable)error;
@end
