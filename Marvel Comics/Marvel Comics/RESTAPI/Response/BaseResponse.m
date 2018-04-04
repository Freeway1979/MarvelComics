//
//  BaseResponse.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse
+ (instancetype) instanceFromJSONObject:(id)jsonObject
{
    BaseResponse *response = [BaseResponse new];
    if (jsonObject) {
        response = [response fromJSONObject:jsonObject];
    }
    return response;
}
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.code = [[jsonObject objectForKey:@"code"] integerValue];
        self.status = [jsonObject objectForKey:@"status"];
        self.etag = [jsonObject objectForKey:@"etag"];
        id data = [jsonObject objectForKey:@"data"];
        BaseResponseData *baseData = [BaseResponseData new];
        self.data = [baseData fromJSONObject:data];
    }
    
    return self;
}


@end
