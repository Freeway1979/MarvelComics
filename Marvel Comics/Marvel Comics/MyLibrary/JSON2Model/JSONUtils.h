//
//  JSONUtils.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtils : NSObject
+ (NSArray *) jsonArray2ObjectArray:(NSArray *)jsonArray
                        objectClass:(Class)objectClass;
@end
