//
//  JSONUtils.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "JSONUtils.h"

@implementation JSONUtils
+ (NSArray *) jsonArray2ObjectArray:(NSArray *)jsonArray
                        objectClass:(Class)objectClass
{
    if (!jsonArray) {
        return nil;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSMutableArray *items = [NSMutableArray array];
    for (id obj in jsonArray) {
        id o = [[objectClass alloc] init];
        if ([o respondsToSelector:@selector(fromJSONObject:)]) {
            [o performSelector:@selector(fromJSONObject:) withObject:obj];
        }
        //o = [o fromJSONObject:obj];
        [items addObject:o];
    }
#pragma clang diagnostic pop
    return items;
}
@end
