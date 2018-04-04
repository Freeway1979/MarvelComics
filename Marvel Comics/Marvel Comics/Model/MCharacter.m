//
//  Character.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MCharacter.h"

@implementation MCharacter
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.id = [[jsonObject objectForKey:@"id"] integerValue];
        self.name = [jsonObject objectForKey:@"name"];
        self.desc = [jsonObject objectForKey:@"desc"];
        //self.modified = [jsonObject objectForKey:@"modified"];
        self.resourceURI = [jsonObject objectForKey:@"resourceURI"];
        MThumbnail *thumbnail = [MThumbnail new];
        thumbnail = [thumbnail fromJSONObject:[jsonObject objectForKey:@"thumbnail"]];
        self.thumbnail = thumbnail;
        
        
        
    }
//    //urls (Array[Url], optional): A set of public web site URLs for the resource.,
//    @property (nonatomic,strong) NSArray<MURL *> *urls;
//    //comics (ComicList, optional): A resource list containing comics which feature this character.,
//    @property (nonatomic,strong) NSArray<MComic*> *comics;
//    //stories (StoryList, optional): A resource list of stories in which this character appears.,
//    @property (nonatomic,strong) NSArray<MStory *> *stories;
//    //events (EventList, optional): A resource list of events in which this character appears.,
//    @property (nonatomic,strong) NSArray<MEvent *> *events;
//    //series (SeriesList, optional): A resource list of series in which this character appears.
//    @property (nonatomic,strong) NSArray<MSeries *> *series;

    return self;
}
@end
