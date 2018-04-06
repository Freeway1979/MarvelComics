//
//  NSString+URLEncode.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

- (NSString *) urlEncodedString
{
    NSString *escapedString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    
    
    return escapedString;
}
- (NSString *) urlDecodedString
{
    NSString *unescapedString = [self stringByRemovingPercentEncoding];
    return unescapedString;
}
@end
