//
//  MarvelNetProvider.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MarvelNetProvider.h"
#import "RESTAPI.h"
#import "BaseResponse.h"
#import "MCharacter.h"
#import "CharacterListRequest.h"
#import "NSDictionary+URLEncodedString.h"
@implementation MarvelNetProvider


/**
 Get character list

 @param request <#request description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getCharacterList:(CharacterListRequest *)request
                success:(void (^)(BaseResponse *response))success
                failure:(void (^)(NSError *error))failure
{
    NSString *urlString = RESTAPI.urlOfListChars;
    
    NSDictionary *params = [request parameterDictionary];
 
    [NetProvider getRequestWithURLString:urlString
                              parameters:params
                                  config:nil
                                 success:^(id responseDic) {
                                     BaseResponse *response = nil;
                                     if (responseDic) {
                                         response = [BaseResponse instanceFromJSONObject:responseDic
                                                                       resultObjectClass:[MCharacter class]];
                                         NSLog(@"%@",response);
                                     }
                                     
                                     if (success) {
                                         success(response);
                                     }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 Get comics of character id

 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getComicListOfCharacter:(NSString *)characterId
                success:(void (^)(BaseResponse *response))success
                failure:(void (^)(NSError *error))failure
{
    return [self getMarvelServiceListOfCharacter:characterId
                                           mtype:MTypeComic success:success failure:failure];
}
/**
 Get stories of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getStoryListOfCharacter:(NSString *)characterId
                       success:(void (^)(BaseResponse *response))success
                       failure:(void (^)(NSError *error))failure
{
    return [self getMarvelServiceListOfCharacter:characterId
                                           mtype:MTypeStory success:success failure:failure];
}
/**
 Get Events of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getEventListOfCharacter:(NSString *)characterId
                       success:(void (^)(BaseResponse *response))success
                       failure:(void (^)(NSError *error))failure
{
    return [self getMarvelServiceListOfCharacter:characterId
                                           mtype:MTypeEvent success:success failure:failure];
}
/**
 Get series of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSeriesListOfCharacter:(NSString *)characterId
                       success:(void (^)(BaseResponse *response))success
                       failure:(void (^)(NSError *error))failure
{
    return [self getMarvelServiceListOfCharacter:characterId mtype:MTypeSeries success:success failure:failure];
}
/**
 Get comies/events/stories/series of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getMarvelServiceListOfCharacter:(NSString *)characterId
                                 mtype:(MType)mtype
                               success:(void (^)(BaseResponse *response))success
                               failure:(void (^)(NSError *error))failure

{
    NSString *urlString;
    Class objectClass;
    if (mtype==MTypeComic) {
        urlString = [RESTAPI urlOfGetComicsByCharacterID:characterId];
        objectClass = [MComic class];
    }
    else if (mtype == MTypeEvent)
    {
        urlString =  [RESTAPI urlOfGetEventsByCharacterID:characterId];
        objectClass = [MEvent class];
    }
    else if (mtype == MTypeStory)
    {
        urlString =  [RESTAPI urlOfGetStoriesByCharacterID:characterId];
        objectClass = [MStory class];
    }
    else if (mtype == MTypeSeries)
    {
        urlString =  [RESTAPI urlOfGetSeriesByCharacterID:characterId];
        objectClass = [MSeries class];
    }
    if (urlString.length==0) {
        return;
    }
    BaseRequest *request = [BaseRequest request];
    request.limit = 3;
    NSDictionary *params = [request parameterDictionary];
    [NetProvider getRequestWithURLString:urlString
                              parameters:params
                                  config:nil
                                 success:^(id responseDic) {
                                     BaseResponse *response = nil;
                                     if (responseDic) {
                                         response = [BaseResponse instanceFromJSONObject:responseDic
                                                                       resultObjectClass:objectClass];
                                         NSLog(@"%@",response);
                                     }
                                     
                                     if (success) {
                                         success(response);
                                     }
                                 } failure:^(NSError *error) {
                                     if (failure) {
                                         failure(error);
                                     }
                                 }];
}
@end
