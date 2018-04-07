//
//  NSDictionary+URLEncodedString.m
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSDictionary+URLEncodedString.h"
#import "NSString+URLEncode.h"

@implementation NSDictionary (URLEncodedString)

/**
 NSDictionary to url query string without URLEncoding by default

 @return <#return value description#>
 */
- (NSString *)urlQueryString {
    return [self urlQueryString:NO];
}

/**
 NSDictionary to url query string with URLEncoding or not

 @param urlEncoded <#urlEncoded description#>
 @return <#return value description#>
 */
- (NSString *)urlQueryString:(BOOL)urlEncoded {
    if (self.count>0) {
        NSMutableString *queryString = [NSMutableString string];
        [self enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [queryString appendFormat:@"&%@=%@",key,obj];
        }];
        
        if (urlEncoded) {
            return [queryString urlEncodedString];
        }
        return queryString;
    }
    return nil;
}
@end
