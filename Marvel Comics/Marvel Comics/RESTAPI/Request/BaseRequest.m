//
//  BaseRequest.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "BaseRequest.h"
#import "NSObject+NSDictionary.h"

@implementation BaseRequest

- (NSDictionary *)parameterDictionary
{
    NSMutableArray *keys = [NSMutableArray arrayWithArray:@[@"offset",@"limit"]];
    if (self.orderBy.length>0) {
        [keys addObject:@"orderBy"];
    }
    return [self dictionaryWithValuesForKeys:keys];
}
@end
