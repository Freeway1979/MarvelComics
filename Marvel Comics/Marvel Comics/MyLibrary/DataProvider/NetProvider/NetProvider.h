//
//  NetProvider.h --Provides basic network communication APIs
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestConfig.h"

@interface NetProvider : NSObject

+(void)getRequestWithURLString:URLString
                    parameters:(NSDictionary *)params
                        config:(RequestConfig *)config
                       success:(void (^)(id responseDic))success
                       failure:(void (^)(NSError *error))failure;

+(void)postRequestWithURLString:URLString
                     parameters:(NSDictionary *)params
                         config:(RequestConfig *)config
                        success:(void (^)(id responseDic))success
                        failure:(void (^)(NSError *error))failure;



@end
