//
//  BaseResponseData.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON2Model.h"

@interface BaseResponseData : NSObject<JSON2Model>

@property (nonatomic,assign) NSInteger offset;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSArray *results;

@property Class resultClass;

- (instancetype)initWithResultClass:(Class)resultClass;

- (instancetype) fromJSONObject:(id)jsonObject;

@end
