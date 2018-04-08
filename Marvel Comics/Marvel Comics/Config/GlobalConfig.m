//
//  GlobalConfig.m --Holds any config memory within application's lifecycle
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "GlobalConfig.h"
#import "FavouriteDataProvider.h"
#import "CharacterDataProvider.h"
@interface GlobalConfig ()
@property (nonatomic,strong) FavouriteDataProvider *favouriteDataProvider;
@property (nonatomic,strong) CharacterDataProvider *characterDetailDataProvider;
@end

@implementation GlobalConfig
+ (instancetype)shared
{
    static GlobalConfig *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[GlobalConfig alloc] init];
        
        shared.favouriteDataProvider = [FavouriteDataProvider shared];
        [shared.favouriteDataProvider loadFromLocalFile];
        
        shared.characterDetailDataProvider = [CharacterDataProvider shared];
    });
    return shared;
}

@end
