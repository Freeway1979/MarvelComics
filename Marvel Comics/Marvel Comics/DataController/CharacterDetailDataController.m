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
#import "MarvelNetProvider.h"

@implementation CharacterDetailDataController

- (instancetype)initViewController:(DetailViewController *)viewController
                         character:(CharacterVM *)character
{
    if (self=[super init]) {
        self.character = character;
        self.viewController = viewController;
    }
    return self;
}

/**
 Load Data Source from anywhere (network,local database,and file cache,etc...)
 
 @param params params request
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)buildDataSource:(NSDictionary *)params
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure
{
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
    NSUInteger itemCount = self.comicList.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MMarvel *item = [self.comicList objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.title
                                              subtitle:item.desc];
        [arrayComics addObject:vm];
    }
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Comics"
                                              cellArray:arrayComics];
    //group 2
    [dataSource addObject:group];
    
    //Stories
    NSMutableArray *arrayStories = [NSMutableArray array];
    itemCount = self.storyList.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MMarvel *item = [self.storyList objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.title
                                              subtitle:item.desc];
        [arrayStories addObject:vm];
    }
    //group 3
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Stories"
                                              cellArray:arrayStories];
    [dataSource addObject:group];
    
    //Events
    NSMutableArray *arrayEvents = [NSMutableArray array];
    itemCount = self.eventList.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MMarvel *item = [self.eventList objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.title
                                              subtitle:item.desc];
        [arrayEvents addObject:vm];
    }
    //group 4
    group = [[GroupImageSubtitleVM alloc] initWithTitle:@"Events"
                                              cellArray:arrayEvents];
    [dataSource addObject:group];
    //Series
    NSMutableArray *arraySeries = [NSMutableArray array];
    itemCount = self.seriesList.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MMarvel *item = [self.seriesList objectAtIndex:i];
        vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.title
                                              subtitle:item.desc];
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
- (void)loadServerData
{
    NSString *characterId = [NSString stringWithFormat:@"%ld", self.character.character.mid];
    WS(ws);
    MType mtype;
    for (mtype = MTypeComic; mtype < MTypeSeries; mtype++) {
        [MarvelNetProvider getMarvelServiceListOfCharacter:characterId mtype:mtype success:^(BaseResponse *response) {
            id data = response.data.results;
            [ws onServerDataChanged:data mtype:mtype];
        } failure:^(NSError *error) {
            
        }];
    }
}
- (void)onServerDataChanged:(NSArray *)data
                      mtype:(MType)mtype
{
    switch (mtype) {
        case MTypeComic:
        {
            self.comicList = data;
        }
            break;
        case MTypeStory:
        {
            self.storyList = data;
        }
            break;
        case MTypeEvent:
        {
            self.eventList = data;
        }
            break;
        case MTypeSeries:
        {
            self.seriesList = data;
        }
        default:
            break;
    }
    WS(ws);
    [self buildDataSource:nil success:^(id data) {
        [AsyncTaskManager executeAsyncTaskOnMainThread:^{
            [ws.viewController onDataSourceChanged:data];
        }];
    } failure:^(NSError *eror) {
        
    }];
}
@end
