//
//  MMarvel.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MMarvel.h"

@implementation MMarvel
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.mid = [[jsonObject objectForKey:@"id"] integerValue];
        self.available = [[jsonObject objectForKey:@"available"] integerValue];
        self.returned = [[jsonObject objectForKey:@"returned"] integerValue];
        self.collectionURI = [jsonObject objectForKey:@"collectionURI"];
        self.desc = [jsonObject objectForKey:@"description"];
        self.title = [jsonObject objectForKey:@"title"];
    }
    return self;
}

@end
