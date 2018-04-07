//
//  NSString+URLEncode.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSString+URLEncode.h"
//#import <objc/runtime.h>

@implementation NSString (URLEncode)

//static char key;
//- (NSString *)url
//{
//    return objc_getAssociatedObject(self, &key);
//}
//- (void)setUrl:(NSString *)url
//{
//    objc_setAssociatedObject(self, &key, url,OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
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
