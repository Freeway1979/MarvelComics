//
//  BaseResponse.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseData.h"
#import "JSON2Model.h"

@interface BaseResponse : NSObject<JSON2Model>

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *etag;

@property Class resultClass;
@property (nonatomic,strong) BaseResponseData * data;

+ (instancetype) instanceFromJSONObject:(id)jsonObject
                      resultObjectClass:(Class)resultObjectClass;
- (instancetype) fromJSONObject:(id)jsonObject;

@end
