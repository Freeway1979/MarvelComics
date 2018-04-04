//
//  BaseResponseData.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "BaseResponseData.h"
#import "JSONUtils.h"
@implementation BaseResponseData
- (instancetype)initWithResultClass:(Class)resultClass
{
    self = [super init];
    if (self) {
        self.resultClass = resultClass;
    }
    return self;
}
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.offset = [[jsonObject objectForKey:@"offset"] integerValue];
        self.limit = [[jsonObject objectForKey:@"limit"] integerValue];
        self.total = [[jsonObject objectForKey:@"total"] integerValue];
        self.count = [[jsonObject objectForKey:@"count"] integerValue];
        //results
        NSArray *results = [jsonObject objectForKey:@"results"];
        if (results && self.resultClass) {
            self.results = [JSONUtils jsonArray2ObjectArray:results objectClass:self.resultClass];
        }
    }
    
    return self;
}
@end
