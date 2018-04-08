//
//  MMarvel.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MMarvel.h"

@implementation MMarvel
+ (NSString *)marvelTypeString:(MType)mtype
{
    switch (mtype) {
        case MTypeComic:
            return @"Comics";
            break;
        case MTypeEvent:
            return @"Events";
            break;
        case MTypeStory:
            return @"Stories";
            break;
        case MTypeSeries:
            return @"Series";
            break;
            
        default:
            break;
    }
    return nil;
}
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
