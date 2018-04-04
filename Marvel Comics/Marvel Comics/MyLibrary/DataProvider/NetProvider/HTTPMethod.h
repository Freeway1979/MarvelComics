//
//  HTTPMethod.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPMethod : NSObject
+(NSString *)GET;
+(NSString *)POST;
+(NSString *)PUT;
+(NSString *)DELETE;
+(NSString *)PATCH;
+(NSString *)HEAD;
@end
