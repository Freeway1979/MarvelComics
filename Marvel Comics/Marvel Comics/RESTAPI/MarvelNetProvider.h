//
//  MarvelNetProvider.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetProvider.h"
#import "BaseResponse.h"
#import "CharacterListRequest.h"
#import "MMarvel.h"

@interface MarvelNetProvider : NSObject

/**
 Get character list
 
 @param request <#request description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getCharacterList:(CharacterListRequest *)request
                success:(void (^)(BaseResponse *response))success
                failure:(void (^)(NSError *error))failure;


/**
 Get comics of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getComicListOfCharacter:(NSString *)characterId
                       success:(void (^)(BaseResponse *response))success
                       failure:(void (^)(NSError *error))failure;
/**
 Get stories of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getStoryListOfCharacter:(NSString *)characterId
                       success:(void (^)(BaseResponse *response))success
                       failure:(void (^)(NSError *error))failure;
/**
 Get Events of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getEventListOfCharacter:(NSString *)characterId
                       success:(void (^)(BaseResponse *response))success
                       failure:(void (^)(NSError *error))failure;
/**
 Get series of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSeriesListOfCharacter:(NSString *)characterId
                        success:(void (^)(BaseResponse *response))success
                        failure:(void (^)(NSError *error))failure;
/**
 Get comies/events/stories/series of character id
 
 @param characterId <#characterId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getMarvelServiceListOfCharacter:(NSString *)characterId
                                 mtype:(MType)mtype
                               success:(void (^)(BaseResponse *response))success
                               failure:(void (^)(NSError *error))failure;

@end
