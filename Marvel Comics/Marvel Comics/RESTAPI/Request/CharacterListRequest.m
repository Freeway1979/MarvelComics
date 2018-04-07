//
//  CharacterListRequest.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterListRequest.h"

@implementation CharacterListRequest
- (NSDictionary *)parameterDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[super parameterDictionary]];
    if (self.nameStartsWith.length>0) {
        [dic setObject:self.nameStartsWith forKey:@"nameStartsWith"];
    }
    return [dic copy];
}

@end
