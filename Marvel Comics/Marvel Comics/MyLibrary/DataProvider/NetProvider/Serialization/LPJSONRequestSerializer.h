//
//  LPJSONRequestSerializer.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPHTTPRequestSerializer.h"

@interface LPJSONRequestSerializer : LPHTTPRequestSerializer

@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

+ (instancetype) shared;
@end
