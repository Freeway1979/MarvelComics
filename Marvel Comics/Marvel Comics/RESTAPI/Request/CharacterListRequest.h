//
//  CharacterListRequest.h
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface CharacterListRequest : BaseRequest

@property (nonatomic,copy) NSString *nameStartsWith;

@end
