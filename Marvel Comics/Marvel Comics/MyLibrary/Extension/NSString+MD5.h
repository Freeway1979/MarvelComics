//
//  NSString+MD5.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

+ (NSString *) MD5OfString:(NSString *)theString;

- (NSString *) MD5String;

@end
