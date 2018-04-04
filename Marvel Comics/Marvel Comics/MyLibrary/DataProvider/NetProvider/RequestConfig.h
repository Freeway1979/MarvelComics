//
//  RequestConfig.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestConfig : NSObject

@property (nonatomic,assign) Boolean gzipEnabled;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, assign) NSURLRequestCachePolicy policy;


/**
 shared config

 @return <#return value description#>
 */
+ (instancetype)shared;

@end
