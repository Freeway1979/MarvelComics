//
//  RESTAPI.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "RESTAPI.h"
#import "NSString+MD5.h"

@implementation RESTAPI

const static NSString * const MARVEL_API_KEY = @"26f078219f521b98b320e9283bc73bd5";
const static NSString * const MARVEL_PRIVATE_KEY = @"b9165c41e58ea83b0147150738c72b93092d5871";


const static NSString * const MARVEL_BASE_URL = @"http://gateway.marvel.com:80";
//Fetches lists of comics filtered by a character id.
const static NSString * const MARVEL_API_LIST_CHARS = @"/v1/public/characters";
//Fetches a single character by id.
const static NSString * const MARVEL_API_GET_CHAR_BY_ID = @"/v1/public/characters/{characterId}";
//Fetches lists of comics filtered by a character id.
const static NSString * const MARVEL_API_GET_COMICS_BY_ID = @"/v1/public/characters/{characterId}/comics";
//Fetches lists of events filtered by a character id.
const static NSString * const MARVEL_API_GET_EVENTS_BY_ID = @"/v1/public/characters/{characterId}/events";
//Fetches lists of series filtered by a character id.
const static NSString * const MARVEL_API_GET_SERIES_BY_ID = @"/v1/public/characters/{characterId}/series";
//Fetches lists of stories filtered by a character id.
const static NSString * const MARVEL_API_GET_STORIES_BY_ID = @"/v1/public/characters/{characterId}/stories";

+ (NSString *)authorizedString {
    NSTimeInterval ts = [[[NSDate alloc] init] timeIntervalSince1970];
    NSUInteger tsInt = (NSUInteger)(ts * 1000);
    NSString *hash = [[[NSString stringWithFormat:@"%lu%@%@",(unsigned long)tsInt,MARVEL_PRIVATE_KEY,MARVEL_API_KEY] MD5String] lowercaseString];
    NSString *str = [NSString stringWithFormat:@"ts=%lu&apikey=%@&hash=%@",tsInt,MARVEL_API_KEY,hash];
    return str;
}

+ (NSString *)urlByAPI:(const NSString *)api
{
    NSString *url = [NSString stringWithFormat:@"%@%@?%@",MARVEL_BASE_URL,api,[self authorizedString]];
    
    return url;
}

+ (NSString *) urlOfListChars
{
    return [self urlByAPI:MARVEL_API_LIST_CHARS];
}
+ (NSString *) urlOfCharByID:(NSString *)ID
{
    NSString *api = [MARVEL_API_GET_CHAR_BY_ID stringByReplacingOccurrencesOfString:@"{characterId}" withString:ID];
    return [self urlByAPI:api];
}
@end
