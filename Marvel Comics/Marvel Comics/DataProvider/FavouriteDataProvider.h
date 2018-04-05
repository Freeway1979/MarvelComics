//
//  FavouriteDataProvider.h
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavouriteDataProvider : NSObject

+ (BOOL)isFavouritedCharacterWithId:(NSString *)characterId;
+ (void)favouriteCharacterWithId:(NSString *)characterId;
+ (void)unfavouriteCharacterWithId:(NSString *)characterId;
+ (void)saveToLocalFile;
+ (void)loadFromLocalFile;

@end
