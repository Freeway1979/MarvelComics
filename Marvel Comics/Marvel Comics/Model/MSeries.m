//
//  MSeries.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MSeries.h"

@implementation MSeries
- (instancetype) fromJSONObject:(id)jsonObject
{
    [super fromJSONObject:jsonObject];
    if (jsonObject) {
        NSArray *arr = [jsonObject objectForKey:@"items"];
        NSMutableArray<MSeriesSummary *> *items = [NSMutableArray array];
        for (id obj in arr) {
            MSeriesSummary *o = [MSeriesSummary new];
            o = [o fromJSONObject:obj];
            [items addObject:o];
        }
        self.items = items;
    }
    return self;
}
@end
