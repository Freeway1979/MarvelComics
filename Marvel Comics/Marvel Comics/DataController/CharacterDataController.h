//
//  CharacterDataController.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataControllerProtocol.h"
#import "MasterViewController.h"
#import "CharacterListRequest.h"

@interface CharacterDataController : NSObject<DataControllerProtocol>

@property (nonatomic,weak) MasterViewController *vc;

- (CharacterListRequest *)buildParameters:(NSString *)searchName
                            limit:(NSUInteger)limit
                           offset:(NSUInteger)offset
                          orderBy:(NSString *)orderBy;
@end
