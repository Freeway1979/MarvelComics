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
@implementation MarvelNetProvider

+(void)getCharacterList:(NSDictionary *)params
                success:(void (^)(BaseResponse *response))success
                failure:(void (^)(NSError *error))failure
{
    NSString *urlString = RESTAPI.urlOfListChars;
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
@end
