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
#import "CharacterDataProvider.h"
#import "NSString+Format.h"

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
    [dataSource addObject:group];
    
    //Comics/Stories/Events/Series
    for (MType mtype = MTypeComic; mtype < MTypeCount; mtype++) {
        NSString *characterId = [NSString stringFromInteger:self.character.character.mid];
        group = [CharacterDataProvider getCharacterDetailGroupWithCharacterId:characterId
                                                                        mtype:mtype];
        if (!group)
        {
            NSArray *data = [self getDataList:mtype];
            group = [self buildGroupVM:[MMarvel marvelTypeString:mtype] list:data];
            [CharacterDataProvider setCharacterDetailGroup:group mtype:mtype
                                           withCharacterId:characterId];
        }
        [dataSource addObject:group];
    }

    if (success) {
        success(dataSource);
    }
}
- (GroupImageSubtitleVM *) buildGroupVM:(NSString *)title
                                   list:(NSArray<MMarvel *> *)list
{
    NSMutableArray *arrayMarvels = [NSMutableArray array];
    NSUInteger itemCount = list.count;
    for (int i=0; i<3 && i<itemCount; i++) {
        MMarvel *item = [list objectAtIndex:i];
        ImageSubtitleVM *vm = [[ImageSubtitleVM alloc] initWithImageUrl:nil
                                                 title:item.title
                                              subtitle:item.desc];
        [arrayMarvels addObject:vm];
    }
    return [[GroupImageSubtitleVM alloc] initWithTitle:title
                                              cellArray:arrayMarvels];
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
- (NSArray *)getDataList:(MType)mtype
{
    switch (mtype) {
        case MTypeComic:
        {
            return self.comicList;
        }
            break;
        case MTypeStory:
        {
            return self.storyList;
        }
            break;
        case MTypeEvent:
        {
            return self.eventList;
        }
            break;
        case MTypeSeries:
        {
            return self.seriesList;
        }
        default:
            break;
    }
    return nil;
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
    
    GroupImageSubtitleVM *groupVM = [self buildGroupVM:[MMarvel marvelTypeString:mtype]
                                                  list:data];
    NSString *characterId = [NSString stringFromInteger:self.character.character.mid];
    [CharacterDataProvider setCharacterDetailGroup:groupVM
                                             mtype:mtype
                                   withCharacterId:characterId];
    WS(ws);
    [self buildDataSource:nil success:^(id data) {
        [AsyncTaskManager executeAsyncTaskOnMainThread:^{
            [ws.viewController onDataSourceChanged:data];
        }];
    } failure:^(NSError *eror) {
        
    }];
}
@end
