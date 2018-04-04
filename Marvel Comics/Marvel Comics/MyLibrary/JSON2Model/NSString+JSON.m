//
//  NSString+JSON.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
- (NSData *)toJSONData
{
   return [self dataUsingEncoding:NSUTF8StringEncoding];
}
- (id) toJSONObject
{
    NSData *data = [self toJSONData];
    NSError *error;
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if([NSJSONSerialization isValidJSONObject:json])
    {
        return json;
    }
    return nil;
}

+ (NSString *)fromJSONData:(NSData *)jsonData
{
    NSString *str = [[NSString alloc] initWithData:(NSData *)jsonData encoding:NSUTF8StringEncoding];
    return str;
}
+ (NSString *)fromJSONObject:(id)jsonObject
{
    NSData *jsonData = nil;
    if ([self isKindOfClass:[NSString class]]) {
        return jsonObject;
    } else if ([self isKindOfClass:[NSData class]]) {
        jsonData = jsonObject;
    }
    if (jsonData) {
        return [NSString fromJSONData:jsonData];
    }
    //TODO:
    return nil;
}
@end
