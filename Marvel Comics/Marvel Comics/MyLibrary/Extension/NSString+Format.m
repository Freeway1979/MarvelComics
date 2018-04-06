//
//  NSString+Format.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)
+ (NSString *)stringFromInteger:(NSInteger)integer
{
    return [NSString stringWithFormat:@"%ld",integer];
}
@end
