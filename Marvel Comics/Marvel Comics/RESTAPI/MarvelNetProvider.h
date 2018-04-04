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

@interface MarvelNetProvider : NSObject
+(void)getCharacterList:(NSDictionary *)params
                success:(void (^)(BaseResponse *response))success
                failure:(void (^)(NSError *error))failure;
@end
