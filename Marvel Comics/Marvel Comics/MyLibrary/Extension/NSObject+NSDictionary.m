//
//  NSObject+NSDictionary.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSObject+NSDictionary.h"
#import <objc/runtime.h>

@implementation NSObject (NSDictionary)


/**
 Get a Dictionary with properties and values

 @return <#return value description#>
 */
- (NSDictionary *) dictionaryWithPropertiesOfObject
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSLog(@"Key %@",key);
        [dict setObject:[self valueForKey:key] forKey:key];
    }
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}
@end
