//
//  MURL.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MURL.h"

@implementation MURL
- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.type = [jsonObject objectForKey:@"type"];
        self.url = [jsonObject objectForKey:@"url"];
    }
    
    return self;
}
@end
