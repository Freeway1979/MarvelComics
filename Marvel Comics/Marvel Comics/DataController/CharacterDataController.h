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

@class MasterViewController;
@interface CharacterDataController : NSObject<DataControllerProtocol>
@property (nonatomic,weak) MasterViewController *vc;
@property (strong, nonatomic) NSArray<CharacterVM *> *characterList;

#pragma mark - search
@property (nonatomic,assign) NSUInteger offset;
@property (nonatomic,assign) NSUInteger limit;
@property (nonatomic,copy) NSString *searchWord;
#pragma mark -pagination
@property (nonatomic,assign) BOOL isPaginationMode;

- (instancetype)initViewController:(MasterViewController *)viewController;

- (void) buildDataSource;
- (void)loadNextPage;


- (CharacterListRequest *)buildParameters:(NSString *)searchName
                            limit:(NSUInteger)limit
                           offset:(NSUInteger)offset
                          orderBy:(NSString *)orderBy;
@end
