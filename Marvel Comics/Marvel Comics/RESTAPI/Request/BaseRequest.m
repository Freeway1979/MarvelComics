//
//  BaseRequest.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "BaseRequest.h"
#import "NSObject+NSDictionary.h"

@implementation BaseRequest
+ (instancetype)request
{
    return [BaseRequest new];
}
- (instancetype) int
{
    return [self initWithLimit:RecordNumberPerPage offset:0];
}
- (instancetype) initWithLimit:(NSUInteger)limit
                        offset:(NSUInteger)offset
{
    if (self=[super init]) {
        self.limit = limit;
        self.offset = offset;
    }
    return self;
}

- (NSDictionary *)parameterDictionary
{
    NSMutableArray *keys = [NSMutableArray arrayWithArray:@[@"offset",@"limit"]];
    if (self.orderBy.length>0) {
        [keys addObject:@"orderBy"];
    }
    return [self dictionaryWithValuesForKeys:keys];
}
@end
