//
//  HTTPMethod.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "HTTPMethod.h"

@implementation HTTPMethod
+(NSString *)GET
{
    return @"GET";
}
+(NSString *)POST
{
    return @"POST";
}
+(NSString *)PUT
{
    return @"PUT";
}
+(NSString *)DELETE
{
    return @"DELETE";
}
+(NSString *)PATCH
{
    return @"PATCH";
}
+(NSString *)HEAD
{
    return @"HEAD";
}
@end
