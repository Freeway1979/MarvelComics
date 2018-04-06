//
//  CharacterDataController.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterDataController.h"
#import "MarvelNetProvider.h"
#import "NSString+Format.h"

@implementation CharacterDataController

- (NSDictionary *)buildParameters:(NSString *)searchName
                            limit:(NSUInteger)limit
                           offset:(NSUInteger)offset
                          orderBy:(NSString *)orderBy
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (searchName.length>0) {
        [params setObject:searchName forKey:@"name"];
    }
    [params setObject:[NSString stringFromInteger:limit] forKey:@"limit"];
    [params setObject:[NSString stringFromInteger:offset] forKey:@"offset"];
    if (orderBy.length>0) {
        [params setObject:orderBy forKey:@"orderBy"];
    }
    return params;
}
/**
 Load Data Source from anywhere (network,local database,and file cache,etc...)

 @param params <#params description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)buildDataSource:(NSDictionary *)params
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure {
    
    [MarvelNetProvider getCharacterList:params success:^(BaseResponse *response) {
        if (success && response) {
            [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                success(response.data);
            }];
        }
    } failure:^(NSError *error) {
        if (failure) {
            [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                failure(error);
            }];
        }
    }];
    
}

@end
