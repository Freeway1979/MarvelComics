//
//  NSDictionary+URLEncodedString.h
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URLEncodedString)
/**
 NSDictionary to url query string without URLEncoding by default
 
 @return <#return value description#>
 */
- (NSString *)urlQueryString;

/**
 NSDictionary to url query string with URLEncoding or not
 
 @param urlEncoded <#urlEncoded description#>
 @return <#return value description#>
 */
- (NSString *)urlQueryString:(BOOL)urlEncoded ;

@end
