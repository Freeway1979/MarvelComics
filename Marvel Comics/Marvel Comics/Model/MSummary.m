//
//  MSummary.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MSummary.h"

@implementation MSummary
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.name = [jsonObject objectForKey:@"name"];
        self.resourceURI = [jsonObject objectForKey:@"resourceURI"];
    }
    
    return self;
}
@end
