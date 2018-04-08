//
//  CharacterDataProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterDataProvider.h"
#import "NSFileManager+LPExtension.h"

#define ARCHIEVED_CACHE_FILE_NAME @"characterDetailCache.plist"
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
        [shared readDataFromFile];
    });
    return shared;
}
- (NSString *)savedFullFilePath
{
    NSString *filePath = [[NSFileManager defaultManager] getDocumentDirectoryFileFullPathWithFileName:ARCHIEVED_CACHE_FILE_NAME];
    NSLog(@"file path %@",filePath);
    return filePath;
}
- (void)readDataFromFile
{
    NSMutableDictionary *cache = [NSMutableDictionary dictionary];
    NSDictionary *saved = [NSDictionary dictionaryWithContentsOfFile:[self savedFullFilePath]];
    if (saved) {
        [saved enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            GroupImageSubtitleVM *model  = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            if (model) {
                [cache setObject:model forKey:key];
            }
        }];
    }
    self.cache = [NSMutableDictionary dictionaryWithDictionary:cache];
}
- (void)writeDataToFile
{
    NSMutableDictionary *saved = [NSMutableDictionary dictionaryWithCapacity:self.cache.count];
    [self.cache enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, GroupImageSubtitleVM * _Nonnull obj, BOOL * _Nonnull stop) {
         NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [saved setObject:archivedData forKey:key];
    }];
    BOOL result = [saved writeToFile:[self savedFullFilePath] atomically:YES];
    if (!result) {
        NSLog(@"Failed to save cache");
    }
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
    
    //Save to file
    [shared writeDataToFile];
    
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
