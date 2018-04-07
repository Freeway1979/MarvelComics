//
//  CharacterDetailDataController.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterDetailDataController.h"
#import "ImageSubtitleVM.h"
#import "GroupImageSubtitleVM.h"

@implementation CharacterDetailDataController

- (instancetype)initWithCharacter:(CharacterVM *)character
{
    if (self=[super init]) {
        self.character = character;
    }
    return self;
}

/**
 Load Data Source from anywhere (network,local database,and file cache,etc...)
 
 @param params params request
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)buildDataSource:(BaseRequest *)request
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure {
    
    NSMutableArray<GroupImageSubtitleVM *> *dataSource = [NSMutableArray array];
    //character
    NSMutableArray *arrayCharacter = [NSMutableArray array];
    CharacterVM *characterVM = self.character;
    characterVM.favouriteEnabled = YES;
    MCharacter *character = characterVM.character;
    [arrayCharacter addObject:characterVM];
    GroupImageSubtitleVM *group = [[GroupImageSubtitleVM alloc] initWithTitle:character.name
                                                                    cellArray:arrayCharacter];
    //group 1
    [dataSource addObject:group];
    ImageSubtitleVM *vm;
    //Comics
    NSMutableArray *arrayComics = [NSMutableArray array];
    MComic *comics = character.comics;
    NSUInteger itemCount = comics.items.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MComicSummary *item = [comics.items objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.name
                                              subtitle:item.name];
        [arrayComics addObject:vm];
    }
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Comics"
                                              cellArray:arrayComics];
    //group 2
    [dataSource addObject:group];
    
    //Stories
    NSMutableArray *arrayStories = [NSMutableArray array];
    MStory *stories = character.stories;
    itemCount = stories.items.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MStorySummary *item = [stories.items objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.name
                                              subtitle:item.name];
        [arrayStories addObject:vm];
    }
    //group 3
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Stories"
                                              cellArray:arrayStories];
    [dataSource addObject:group];

    //Events
    NSMutableArray *arrayEvents = [NSMutableArray array];
    MEvent *events = character.events;
    itemCount = events.items.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MEventSummary *item = [events.items objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.name
                                              subtitle:item.name];
        [arrayEvents addObject:vm];
    }
    //group 4
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Events"
                                              cellArray:arrayEvents];
    [dataSource addObject:group];
    //Series
    NSMutableArray *arraySeries = [NSMutableArray array];
    MSeries *series = character.series;
    itemCount = series.items.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MSeriesSummary *item = [series.items objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.name
                                              subtitle:item.name];
        [arraySeries addObject:vm];
    }
    //group 5
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Series"
                                              cellArray:arraySeries];
    [dataSource addObject:group];
    
    if (success) {
        success(dataSource);
    }
}
@end
