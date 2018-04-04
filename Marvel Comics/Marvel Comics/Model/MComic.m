//
//  MComic.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MComic.h"

@implementation MComic
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.available = [[jsonObject objectForKey:@"available"] integerValue];
        self.returned = [[jsonObject objectForKey:@"returned"] integerValue];
        self.collectionURI = [jsonObject objectForKey:@"collectionURI"];
        
        NSArray *arr = [jsonObject objectForKey:@"items"];
        NSMutableArray<MComicSummary *> *items = [NSMutableArray array];
        for (id obj in arr) {
            MComicSummary *o = [MComicSummary new];
            o = [o fromJSONObject:obj];
            [items addObject:o];
        }
        self.items = items;
    }
    
    
    return self;
}
@end
