//
//  MEvent.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MEvent.h"

@implementation MEvent
- (instancetype) fromJSONObject:(id)jsonObject
{
    [super fromJSONObject:jsonObject];
    if (jsonObject) {
        NSArray *arr = [jsonObject objectForKey:@"items"];
        NSMutableArray<MEventSummary *> *items = [NSMutableArray array];
        for (id obj in arr) {
            MEventSummary *o = [MEventSummary new];
            o = [o fromJSONObject:obj];
            [items addObject:o];
        }
        self.items = items;
    }
    
    return self;
}
@end
