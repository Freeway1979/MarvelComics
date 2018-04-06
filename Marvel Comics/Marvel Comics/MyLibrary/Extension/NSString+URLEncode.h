//
//  NSString+URLEncode.h
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)
- (NSString *) urlEncodedString;
- (NSString *) urlDecodedString;
@end
