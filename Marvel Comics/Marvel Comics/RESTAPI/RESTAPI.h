//
//  RESTAPI.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RESTAPI : NSObject

+ (NSString *) urlOfListChars;
+ (NSString *) urlOfCharByID:(NSString *)ID;

+ (NSString *) urlOfGetComicsByCharacterID:(NSString *)characterId;
+ (NSString *) urlOfGetEventsByCharacterID:(NSString *)characterId;
+ (NSString *) urlOfGetStoriesByCharacterID:(NSString *)characterId;
+ (NSString *) urlOfGetSeriesByCharacterID:(NSString *)characterId;

@end
