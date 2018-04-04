//
//  JSON2Model.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSON2Model
/**
 JSON String to Data Model
 */
@optional
- (id)fromJSONString:(NSString *)json;

@required
- (id)fromJSONObject:(id)jsonObject;

@optional
- (NSString *)toJSONString;

@end
