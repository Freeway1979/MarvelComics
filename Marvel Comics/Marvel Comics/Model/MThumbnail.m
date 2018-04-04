//
//  MThumbnail.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MThumbnail.h"

@implementation MThumbnail

- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.path = [jsonObject objectForKey:@"path"];
        self.extension = [jsonObject objectForKey:@"extension"];
     }
    
    return self;
}
@end
