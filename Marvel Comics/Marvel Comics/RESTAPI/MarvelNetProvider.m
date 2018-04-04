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

@implementation MarvelNetProvider

+(void)getCharacterList:(NSDictionary *)params
                success:(void (^)(id responseDic))success
                failure:(void (^)(NSError *error))failure
{
    NSString *urlString = RESTAPI.urlOfListChars;
    [NetProvider getRequestWithURLString:urlString
                              parameters:params
                                  config:nil
                                 success:^(id responseDic) {
                                     if (responseDic) {
                                         BaseResponse *response = [BaseResponse instanceFromJSONObject:responseDic];
                                         NSLog(@"%@",response);
                                     }
                                     
                                     if (success) {
                                         success(responseDic);
                                     }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
