//
//  BaseResponseData.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "BaseResponseData.h"

@implementation BaseResponseData

- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.offset = [[jsonObject objectForKey:@"offset"] integerValue];
        self.limit = [[jsonObject objectForKey:@"limit"] integerValue];
        self.total = [[jsonObject objectForKey:@"total"] integerValue];
        self.count = [[jsonObject objectForKey:@"count"] integerValue];
        self.results = [jsonObject objectForKey:@"results"];
    }
    
    return self;
}
@end
