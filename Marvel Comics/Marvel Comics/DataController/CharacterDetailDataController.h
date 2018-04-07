//
//  CharacterDetailDataController.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataControllerProtocol.h"
#import "MCharacter.h"
#import "CharacterVM.h"
#import "DetailViewController.h"

@interface CharacterDetailDataController : NSObject<DataControllerProtocol>

@property (nonatomic,weak) DetailViewController *viewController;

@property (nonatomic,strong) CharacterVM *character;

@property (nonatomic,strong) NSArray<MComic *> *comicList;
@property (nonatomic,strong) NSArray<MStory *> *storyList;
@property (nonatomic,strong) NSArray<MEvent *> *eventList;
@property (nonatomic,strong) NSArray<MSeries *> *seriesList;

- (instancetype)initViewController:(UIViewController *)viewController
                         character:(CharacterVM *)character;
/**
 Load Data Source from anywhere (network,local database,and file cache,etc...)
 
 @param params <#params description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)buildDataSource:(NSDictionary *)params
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure;

- (void)loadServerData;

@end
