//
//  BaseRequest.h
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RecordNumberPerPage (20)

@interface BaseRequest : NSObject

@property (nonatomic,assign) NSUInteger limit;

@property (nonatomic,assign) NSUInteger offset;

@property (nonatomic,copy) NSString* orderBy;

+ (instancetype)request;

- (NSDictionary *)parameterDictionary;

- (instancetype) initWithLimit:(NSUInteger)limit
                        offset:(NSUInteger)offset;

@end
