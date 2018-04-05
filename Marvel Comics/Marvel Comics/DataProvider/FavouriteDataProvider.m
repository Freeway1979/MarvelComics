//
//  FavouriteDataProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "FavouriteDataProvider.h"
@interface FavouriteDataProvider ()
{

}
@end
static NSMutableDictionary<NSString *,NSNumber *> *favouriteDictionary;
@implementation FavouriteDataProvider

+ (void)favouriteCharacterWithId:(NSString *)characterId
{
    if (!favouriteDictionary) {
        favouriteDictionary = [NSMutableDictionary dictionary];
    }
    [favouriteDictionary setObject:[NSNumber numberWithInt:1] forKey:characterId];
}
+ (void)unfavouriteCharacterWithId:(NSString *)characterId
{
    if (!favouriteDictionary) {
        favouriteDictionary = [NSMutableDictionary dictionary];
    }
    [favouriteDictionary removeObjectForKey:characterId];
}
+ (BOOL)isFavouritedCharacterWithId:(NSString *)characterId
{
    if (!favouriteDictionary) {
        favouriteDictionary = [NSMutableDictionary dictionary];
    }
    NSNumber *num = [favouriteDictionary objectForKey:characterId];
    if (num) {
        return num.integerValue==1;
    }
    return NO;
}
+ (void)saveToLocalFile
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"favouriteDictionary.plist"];
    [favouriteDictionary writeToFile:path atomically:YES];
}

+ (void)loadFromLocalFile
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:@"favouriteDictionary.plist"];
   
    favouriteDictionary = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
}
@end
