//
//  MThumbnail.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MThumbnail.h"

@implementation MThumbnail
- (NSString *) fullUrl
{
    return [NSString stringWithFormat:@"%@.%@",self.path,self.extension];
}
- (NSString *) fullThumbnailUrl
{
    NSString *standard = @"medium";
    if ([UIUtils is3XDevice]) {
        standard = @"xlarge";
    }
    else if ([UIUtils is2XDevice])
    {
        standard = @"large";
    }
    return [NSString stringWithFormat:@"%@/standard_%@.%@",self.path,standard,self.extension];
}

- (instancetype) fromJSONObject:(id)jsonObject
{
    if (jsonObject) {
        self.path = [jsonObject objectForKey:@"path"];
        self.extension = [jsonObject objectForKey:@"extension"];
     }
    
    return self;
}
@end
