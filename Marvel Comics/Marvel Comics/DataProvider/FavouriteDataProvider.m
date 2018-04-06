//
//  FavouriteDataProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "FavouriteDataProvider.h"
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

- (void)saveToLocalFile
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"favouriteDictionary.plist"];
    [self.favouriteDictionary writeToFile:path atomically:YES];
}

- (void)loadFromLocalFile
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"favouriteDictionary.plist"];
   
    self.favouriteDictionary = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
}
@end
