//
//  CharacterDataProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterDataProvider.h"

@interface CharacterDataProvider ()
@property (nonatomic,strong) NSMutableDictionary<NSString *,GroupImageSubtitleVM *> *cache;
@end

@implementation CharacterDataProvider
+ (instancetype)shared
{
    static CharacterDataProvider *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CharacterDataProvider alloc] init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:@"characterDetailCache"];
        if (!dic) {
            dic = [NSMutableDictionary dictionary];
        }
        shared.cache = dic ;
    });
    return shared;
}
+ (NSString *)buildKey:(NSString *)characterId
                 mtype:(MType)mtype
{
    NSString *marvelTypeString = [MMarvel marvelTypeString:mtype];
    NSString *key = [NSString stringWithFormat:@"%@_%@",characterId,marvelTypeString];
    return key;
}
+ (void)setCharacterDetailGroup:(GroupImageSubtitleVM *)data
                          mtype:(MType)mtype
                withCharacterId:(NSString *)characterId
{
    NSString *key = [self buildKey:characterId mtype:mtype];
    CharacterDataProvider *shared = [CharacterDataProvider shared];
    [shared.cache setObject:data forKey:key];
    [shared.cache writeToFile:@"characterDetailCache" atomically:YES];
    
}
+ (GroupImageSubtitleVM *)getCharacterDetailGroupWithCharacterId:(NSString *)characterId
                                                           mtype:(MType)mtype
{
    NSString *key = [self buildKey:characterId mtype:mtype];
    CharacterDataProvider *shared = [CharacterDataProvider shared];
    id data = [shared.cache objectForKey:key];
    return data;
}

@end
