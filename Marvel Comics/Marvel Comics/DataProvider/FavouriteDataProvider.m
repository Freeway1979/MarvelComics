//
//  FavouriteDataProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "FavouriteDataProvider.h"
#import "NSFileManager+LPExtension.h"
#define ARCHIEVED_FAVOURITE_CACHE_FILE_NAME @"favouriteDictionary.plist"
@interface FavouriteDataProvider ()
@property (nonatomic,strong) NSMutableDictionary<NSString *,NSNumber *> *favouriteDictionary;
@end
@implementation FavouriteDataProvider
+ (instancetype)shared
{
    static FavouriteDataProvider *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[FavouriteDataProvider alloc] init];
        shared.favouriteDictionary = [NSMutableDictionary dictionary];
    });
    return shared;
}

+ (void)favouriteCharacterWithId:(NSString *)characterId
{
    FavouriteDataProvider *shared = [FavouriteDataProvider shared];
    [shared.favouriteDictionary setObject:[NSNumber numberWithInt:1] forKey:characterId];
    [shared saveToLocalFile];
}
+ (void)unfavouriteCharacterWithId:(NSString *)characterId
{
    FavouriteDataProvider *shared = [FavouriteDataProvider shared];
    [shared.favouriteDictionary removeObjectForKey:characterId];
    [shared saveToLocalFile];
}
+ (BOOL)isFavouritedCharacterWithId:(NSString *)characterId
{
    FavouriteDataProvider *shared = [FavouriteDataProvider shared];
    
    NSNumber *num = [shared.favouriteDictionary objectForKey:characterId];
    if (num) {
        return num.integerValue==1;
    }
    return NO;
}

#pragma mark - Serialization to local data
- (NSString *)savedFilePath
{
    NSString *filePath = [[NSFileManager defaultManager] getDocumentDirectoryFileFullPathWithFileName:ARCHIEVED_FAVOURITE_CACHE_FILE_NAME];
    return filePath;
}
- (void)saveToLocalFile
{
    NSString *filePath = [self savedFilePath];
    [self.favouriteDictionary writeToFile:filePath atomically:YES];
}

- (void)loadFromLocalFile
{
    NSString *filePath = [self savedFilePath];
    self.favouriteDictionary = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
}
@end
