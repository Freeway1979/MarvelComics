//
//  Character.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MCharacter.h"
#import "JSONUtils.h"
@implementation MCharacter
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.mid = [[jsonObject objectForKey:@"id"] integerValue];
        self.name = [jsonObject objectForKey:@"name"];
        self.desc = [jsonObject objectForKey:@"description"];
        //self.modified = [jsonObject objectForKey:@"modified"];
        self.resourceURI = [jsonObject objectForKey:@"resourceURI"];
        MThumbnail *thumbnail = [MThumbnail new];
        thumbnail = [thumbnail fromJSONObject:[jsonObject objectForKey:@"thumbnail"]];
        self.thumbnail = thumbnail;
        
        self.comics = [[MComic new]
                       fromJSONObject:[jsonObject objectForKey:@"comics"]];
        self.events = [[MEvent new]
                       fromJSONObject:[jsonObject objectForKey:@"events"]];
        self.stories = [[MStory new]
                       fromJSONObject:[jsonObject objectForKey:@"stories"]];
        self.series = [[MSeries new]
                       fromJSONObject:[jsonObject objectForKey:@"series"]];
        
        NSArray *arr = [jsonObject objectForKey:@"urls"];
        if (arr) {
            self.urls = [self jsonArray2UrlArray:arr];
        }
    }

    return self;
}
//TODO:Generic type is required!
- (NSArray *) jsonArray2UrlArray:(NSArray *)jsonArray
{
    return [JSONUtils jsonArray2ObjectArray:jsonArray
                                objectClass:[MURL class]];
}

@end
