//
//  CharacterDataProvider.h
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GroupImageSubtitleVM.h"
#import "MMarvel.h"

@interface CharacterDataProvider : NSObject
+(instancetype) shared;
+ (NSString *)buildKey:(NSString *)characterId
                 mtype:(MType)mtype;
+ (void)setCharacterDetailGroup:(GroupImageSubtitleVM *)data
                          mtype:(MType)mtype
           withCharacterId:(NSString *)characterId;
+ (GroupImageSubtitleVM *)getCharacterDetailGroupWithCharacterId:(NSString *)characterId
                                                           mtype:(MType)mtype;

@end
