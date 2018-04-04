//
//  NSString+JSON.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

- (NSData *)toJSONData;
- (id) toJSONObject;

+ (NSString *)fromJSONData:(NSData *)jsonData;
+ (NSString *)fromJSONObject:(id)jsonObject;

@end
