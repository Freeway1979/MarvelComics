//
//  LPHTTPResponseSerializer.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHTTPResponseSerializer : NSObject
+ (instancetype _Nonnull )serializer ;


@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, assign) NSJSONReadingOptions readingOptions;
@property (nonatomic, copy, nullable) NSIndexSet *acceptableStatusCodes;
@property (nonatomic, copy, nullable) NSSet <NSString *> *acceptableContentTypes;

- (id _Nonnull )responseObjectForResponse:(NSURLResponse *_Nullable)response
                                     data:(NSData *_Nullable)data
                                    error:(NSError *_Nullable)error;
@end
